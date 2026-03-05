DOCKER_RUN_ARGS=()
AGENT_ARGS=("$@")

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

docker network inspect "$AGENT_NETWORK" >/dev/null 2>&1 || docker network create "$AGENT_NETWORK" >/dev/null
