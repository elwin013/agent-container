DOCKER_RUN_ARGS=()
AGENT_ARGS=("$@")

if [[ -n "${CONTAINER_ENGINE:-}" ]]; then
  ENGINE_BIN="$CONTAINER_ENGINE"
elif command -v podman >/dev/null 2>&1; then
  ENGINE_BIN="podman"
else
  ENGINE_BIN="docker"
fi

if [[ "$#" -gt 0 ]]; then
  AGENT_ARGS=()
  parsing_docker_args=true

  for arg in "$@"; do
    if [[ "$arg" == "--" && "$parsing_docker_args" == true ]]; then
      parsing_docker_args=false
      continue
    fi

    if [[ "$parsing_docker_args" == true ]]; then
      DOCKER_RUN_ARGS+=("$arg")
    else
      AGENT_ARGS+=("$arg")
    fi
  done

  if [[ "$parsing_docker_args" == true ]]; then
    AGENT_ARGS=("$@")
    DOCKER_RUN_ARGS=()
  fi
fi

for arg in "${DOCKER_RUN_ARGS[@]}"; do
  if [[ "$arg" == "--network" || "$arg" == "--net" || "$arg" == --network=* || "$arg" == --net=* ]]; then
    printf 'Error: custom network flags are not supported; wrappers always use network %s\n' "$AGENT_NETWORK" >&2
    exit 1
  fi
done

"$ENGINE_BIN" network inspect "$AGENT_NETWORK" >/dev/null 2>&1 || "$ENGINE_BIN" network create "$AGENT_NETWORK" >/dev/null
