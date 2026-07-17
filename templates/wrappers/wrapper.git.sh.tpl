#!/usr/bin/env bash
# GENERATED FILE - DO NOT EDIT

set -euo pipefail

CONTAINER_IMAGE="${CONTAINER_IMAGE:-__CONTAINER_IMAGE_DEFAULT__}"
AGENT_NAME="${AGENT_NAME:-__AGENT_NAME_DEFAULT__}"
CONTAINER_NAME="__AGENT_CMD__-$(basename "$(pwd)")-$(date +%Y%m%d%H%M%S)"
AGENT_NETWORK="${AGENT_NETWORK:-agentic_network}"

__ARG_PARSE_AND_NETWORK_FRAGMENT__

M2_CACHE_HOST="$HOME/.local/share/agent-container/m2"
AGENT_CACHE_DIR_HOST="$HOME/.cache/${AGENT_NAME}"
AGENT_CONFIG_DIR_HOST="${HOME}/.config/${AGENT_NAME}"
CONTAINER_HOME="/home/agent"
PROJECT_DIR="$(pwd -P)"
CONTAINER_PROJECT_DIR="$PROJECT_DIR"

# Preserve the host project path so agents that key state by their working
# directory keep unrelated projects separate. Avoid masking container runtime
# paths when the wrapper is invoked from an unusual top-level directory.
case "$PROJECT_DIR" in
  /|/bin|/boot|/dev|/etc|/home|/lib|/lib64|/proc|/root|/run|/sbin|/sys|/tmp|/usr|/var|"$CONTAINER_HOME")
    CONTAINER_PROJECT_DIR="/workspace${PROJECT_DIR}"
    ;;
esac

__HOST_SETUP_LINES__

GIT_CONFIG_HOST="${AGENT_CONFIG_DIR_HOST}/gitconfig"
mkdir -p "$AGENT_CACHE_DIR_HOST"
mkdir -p "$(dirname "${GIT_CONFIG_HOST}")"
touch "${GIT_CONFIG_HOST}"

AGENT_GIT_NAME="${AGENT_GIT_NAME:-__AGENT_GIT_NAME_DEFAULT__}"
AGENT_GIT_EMAIL="${AGENT_GIT_EMAIL:-__AGENT_GIT_EMAIL_DEFAULT__}"

if [[ "$CONTAINER_IMAGE" == *-java ]]; then
  DOCKER_RUN_ARGS+=("-v" "$M2_CACHE_HOST:${CONTAINER_HOME}/.m2:z")
fi

RUNTIME_USER_ARGS=()
IDENTITY_MOUNTS=()

if [[ "$ENGINE_BIN" == "podman" ]]; then
  if [[ "$("$ENGINE_BIN" info --format '{{.Host.Security.Rootless}}' 2>/dev/null || printf false)" == "true" ]]; then
    RUNTIME_USER_ARGS+=("--userns=keep-id")
  else
    RUNTIME_USER_ARGS+=("--user" "$(id -u):$(id -g)")
  fi
else
  if "$ENGINE_BIN" info --format '{{range .SecurityOptions}}{{println .}}{{end}}' 2>/dev/null | grep -qx 'name=rootless'; then
    :
  else
    RUNTIME_USER_ARGS+=("--user" "$(id -u):$(id -g)")

    PASSWD_FILE="$(mktemp)"
    GROUP_FILE="$(mktemp)"
    trap 'rm -f "$PASSWD_FILE" "$GROUP_FILE"' EXIT

    printf 'root:x:0:0:root:/root:/bin/bash\n' > "$PASSWD_FILE"
    printf 'agent:x:%s:%s:Agent:%s:/bin/bash\n' "$(id -u)" "$(id -g)" "$CONTAINER_HOME" >> "$PASSWD_FILE"

    printf 'root:x:0:\n' > "$GROUP_FILE"
    printf 'agent:x:%s:\n' "$(id -g)" >> "$GROUP_FILE"

    IDENTITY_MOUNTS+=("-v" "$PASSWD_FILE:/etc/passwd:ro,z")
    IDENTITY_MOUNTS+=("-v" "$GROUP_FILE:/etc/group:ro,z")
  fi
fi


"$ENGINE_BIN" run --rm --tty --interactive --init \
  --name "$CONTAINER_NAME" \
  --add-host=host.docker.internal:host-gateway \
  --network "$AGENT_NETWORK" \
  "${RUNTIME_USER_ARGS[@]}" \
  -v "$AGENT_CACHE_DIR_HOST:${CONTAINER_HOME}/.cache:z" \
__DOCKER_MOUNT_LINES__
  "${IDENTITY_MOUNTS[@]}" \
  -e HOME="$CONTAINER_HOME" \
  -e XDG_CACHE_HOME="${CONTAINER_HOME}/.cache" \
  -e XDG_CONFIG_HOME="${CONTAINER_HOME}/.config" \
  -e XDG_DATA_HOME="${CONTAINER_HOME}/.local/share" \
  -e XDG_STATE_HOME="${CONTAINER_HOME}/.local/state" \
  -e GIT_CONFIG_GLOBAL="${CONTAINER_HOME}/.config/${AGENT_NAME}/gitconfig" \
  -e AGENT_GIT_NAME="$AGENT_GIT_NAME" \
  -e AGENT_GIT_EMAIL="$AGENT_GIT_EMAIL" \
  -v "$PROJECT_DIR:$CONTAINER_PROJECT_DIR:z" \
  "${DOCKER_RUN_ARGS[@]}" \
  "$CONTAINER_IMAGE" \
  bash -lc '__GIT_BOOTSTRAP_FRAGMENT__' -- "$CONTAINER_PROJECT_DIR" "${AGENT_ARGS[@]}"
