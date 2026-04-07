# agent-container

Run coding agents in containers against the current project directory (`$(pwd)` mounted to `/app`) so agents do not get full host filesystem access.

Base runtime: Fedora 43.

## Requirements

- Docker or Podman
- `make`

## Quick Start

```sh
make build-all
```

This builds all images and installs wrapper scripts into `~/.local/bin`.

## Running new version (after 06/04/2026) when you have the older version

If you previously ran an agent as `root` and later switch to the non-root wrapper mode, repair ownership on mounted host paths before starting the agent again:

```sh
sudo chown -R "$USER:$(id -gn)" \
  ~/.config/opencode ~/.local/state/opencode ~/.local/share/opencode \
  ~/.config/claude ~/.claude ~/.claude.json \
  ~/.junie \
  ~/.copilot \
  ~/.codex ~/.config/codex \
  ~/.cache/opencode ~/.cache/claude ~/.cache/junie ~/.cache/copilot ~/.cache/codex \
  ~/.local/share/agent-container/m2
```

Also available:

- `make build-opencode`, `make build-opencode-java`
- `make build-claude`, `make build-claude-java`
- `make build-junie`, `make build-junie-java`
- `make build-copilot`, `make build-copilot-java`
- `make build-codex`, `make build-codex-java`

Backward-compatible aliases:

- `make build` -> `make build-opencode`
- `make build-java` -> `make build-opencode-java`

## Wrappers

All wrappers run from your project directory and are installed to `~/.local/bin`.

Wrapper sources in `agents/*/scripts` are generated from templates in `templates/wrappers`.

- OpenCode: `opencode`, `opencode-auth`, `opencode-java`
- Claude Code: `claude`, `claude-java`
- Junie: `junie`, `junie-java`
- GitHub Copilot CLI: `copilot`, `copilot-java`
- OpenAI Codex CLI: `codex`, `codex-java`

Make sure `~/.local/bin` is on your `PATH`.

## PATH Setup

On some systems (notably Ubuntu), `~/.local/bin` is not on `PATH` by default. Add it to your shell init file:

```sh
# bash (Ubuntu default)
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# zsh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# fish
fish_add_path "$HOME/.local/bin"
```

On macOS with zsh, use `~/.zshrc`. On other shells, add the same `export PATH=...` line to the shell's init file and restart your terminal.

## Passing Runtime Flags

Use `--` to separate container flags from agent flags:

```sh
opencode -e FOO=bar -- -s session-id
claude --cpus 2 -- --help
junie -e BAR=baz -- --help
```

Without `--`, arguments are forwarded to the agent CLI.

## Container Network

All wrappers attach containers to a shared Docker network named `agentic_network`.

- The network is auto-created on first run if it does not exist.
- Custom container network flags (`--network` or `--net`) are not supported by wrappers.
- You can override the default network name with `AGENT_NETWORK` if needed.

## Git Configuration

All wrappers configure git inside the container:

- set user name/email
- set `/app` as `safe.directory`
- disable commit/tag GPG signing

Defaults:

- All wrappers use one shared variable set:
  - `AGENT_NAME` (controls gitconfig path namespace)
  - `AGENT_GIT_NAME` (git `user.name`)
  - `AGENT_GIT_EMAIL` (git `user.email`)

- Per-wrapper default values:
  - OpenCode (`opencode`, `opencode-java`): `AGENT_NAME=opencode`, `AGENT_GIT_NAME="OpenCode Agent"`, `AGENT_GIT_EMAIL=opencode@localhost`
  - Claude (`claude`, `claude-java`): `AGENT_NAME=claude`, `AGENT_GIT_NAME="Claude Code Agent"`, `AGENT_GIT_EMAIL=claude@localhost`
  - Junie (`junie`, `junie-java`): `AGENT_NAME=junie`, `AGENT_GIT_NAME="Junie Agent"`, `AGENT_GIT_EMAIL=junie@localhost`
  - Copilot (`copilot`, `copilot-java`): `AGENT_NAME=copilot`, `AGENT_GIT_NAME="GitHub Copilot Agent"`, `AGENT_GIT_EMAIL=copilot@localhost`
  - Codex (`codex`, `codex-java`): `AGENT_NAME=codex`, `AGENT_GIT_NAME="OpenAI Codex Agent"`, `AGENT_GIT_EMAIL=codex@localhost`

Persistent gitconfig paths:

- `${HOME}/.config/${AGENT_NAME}/gitconfig`

## Runtime User

Wrappers run the agent process as the current host UID/GID so bind-mounted files keep the same host ownership.

- Shared SELinux mounts use `:z` so multiple agent containers can run at once
- Runtime mode is selected automatically:
- Rootful Docker and rootful Podman use `--user <uid>:<gid>`
- Rootless Podman uses `--userns=keep-id`
- Rootless Docker falls back to container `root` so bind mounts stay writable
- Agent config, cache, and state mounts live under `/home/agent` inside the container, while the wrapper starts the process in `/app`

Set `CONTAINER_ENGINE=podman` or `CONTAINER_ENGINE=docker` to override the detected engine.

## Wrapper Generation

- Render all wrappers: `make render-wrappers`
- Render one agent only: `bash scripts/render-wrappers <agent-id>`
- Verify generated wrappers are up-to-date: `make check-generated-wrappers`

`addbin-*` targets automatically render wrappers before copying to `~/.local/bin`.

## Updating Tools

To update an agent to a new version without touching your local configuration, rebuild its image and reinstall wrappers. User data and settings are stored in your home directory (see "Mounted Host Paths"), so updates do not remove or reset them.

Force a rebuild for a specific agent (for example - opencode):

```sh
git pull
make rebuild-opencode
```

Rebuild base images:

```sh
git pull
make rebuild-base
make rebuild-base-java
```

You can also rebuild just one Containerfile directly:

```sh
docker build --no-cache -t opencode-container -f agents/opencode/base.Containerfile .
```

## Mounted Host Paths

- OpenCode: `~/.local/state/opencode`, `~/.local/share/opencode`, `~/.config/opencode`
- `opencode-auth` also exposes `127.0.0.1:1455:1455` - used as callback for login
- Claude: `~/.claude`, `~/.claude.json`, `~/.config/claude`
- Junie: `~/.junie`
- Copilot: `~/.copilot`
- Codex: `~/.codex`
- Java wrappers: `~/.local/share/agent-container/m2` -> `/home/agent/.m2`

## Repository Layout

- `agents/base`: shared base images
- `agents/<agent>`: agent images and notes
- `agents/<agent>/scripts`: wrapper scripts
- `mk`: reusable make modules

## Remove

Remove installed wrappers:

```sh
make removebin
```

Remove images:

```sh
docker rmi \
  opencode-container opencode-container-java \
  claude-code-container claude-code-container-java \
  junie-container junie-container-java \
  copilot-container copilot-container-java \
  codex-container codex-container-java
```
