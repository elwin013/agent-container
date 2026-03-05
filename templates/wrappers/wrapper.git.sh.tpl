#!/usr/bin/env bash
# GENERATED FILE - DO NOT EDIT

set -euo pipefail

CONTAINER_IMAGE="${CONTAINER_IMAGE:-__CONTAINER_IMAGE_DEFAULT__}"
AGENT_NAME="${AGENT_NAME:-__AGENT_NAME_DEFAULT__}"
CONTAINER_NAME="__AGENT_CMD__-$(basename "$(pwd)")-$(date +%Y%m%d%H%M%S)"
AGENT_NETWORK="${AGENT_NETWORK:-agentic_network}"

__ARG_PARSE_AND_NETWORK_FRAGMENT__

M2_CACHE_HOST="$HOME/.local/share/agent-container/m2"
AGENT_CONFIG_DIR_HOST="${HOME}/.config/${AGENT_NAME}"

__HOST_SETUP_LINES__

GIT_CONFIG_HOST="${AGENT_CONFIG_DIR_HOST}/gitconfig"
mkdir -p "$(dirname "${GIT_CONFIG_HOST}")"
touch "${GIT_CONFIG_HOST}"

AGENT_GIT_NAME="${AGENT_GIT_NAME:-__AGENT_GIT_NAME_DEFAULT__}"
AGENT_GIT_EMAIL="${AGENT_GIT_EMAIL:-__AGENT_GIT_EMAIL_DEFAULT__}"

if [[ "$CONTAINER_IMAGE" == *-java ]]; then
  DOCKER_RUN_ARGS+=("-v" "$M2_CACHE_HOST:/root/.m2:Z")
fi

exec docker run --rm --tty --interactive \
  --name "$CONTAINER_NAME" \
  --add-host=host.docker.internal:host-gateway \
  --network "$AGENT_NETWORK" \
__DOCKER_MOUNT_LINES__
  -e GIT_CONFIG_GLOBAL="/root/.config/${AGENT_NAME}/gitconfig" \
  -e AGENT_GIT_NAME="$AGENT_GIT_NAME" \
  -e AGENT_GIT_EMAIL="$AGENT_GIT_EMAIL" \
  -v "$(pwd):/app:Z" \
  "${DOCKER_RUN_ARGS[@]}" \
  "$CONTAINER_IMAGE" \
  bash -lc '__GIT_BOOTSTRAP_FRAGMENT__' -- "${AGENT_ARGS[@]}"
