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

Also available:

- `make build-opencode`, `make build-opencode-java`
- `make build-claude`, `make build-claude-java`
- `make build-junie`, `make build-junie-java`
- `make build-copilot`, `make build-copilot-java`

Backward-compatible aliases:

- `make build` -> `make build-opencode`
- `make build-java` -> `make build-opencode-java`

## Wrappers

All wrappers run from your project directory and are installed to `~/.local/bin`.

- OpenCode: `opencode`, `opencode-auth`, `opencode-git`, `opencode-java`, `opencode-java-git`
- Claude Code: `claude`, `claude-git`, `claude-java`, `claude-java-git`
- Junie: `junie`, `junie-git`, `junie-java`, `junie-java-git`
- GitHub Copilot CLI: `copilot`, `copilot-git`, `copilot-java`, `copilot-java-git`

Make sure `~/.local/bin` is on your `PATH`.

## Passing Runtime Flags

Use `--` to separate container flags from agent flags:

```sh
opencode --network host -e FOO=bar -- -s session-id
claude --cpus 2 -- --help
junie -e BAR=baz -- --help
```

Without `--`, arguments are forwarded to the agent CLI.

## Git Wrappers

`*-git` wrappers configure git inside the container:

- set user name/email
- set `/app` as `safe.directory`
- disable commit/tag GPG signing

Defaults:

- OpenCode: `OPENCODE_GIT_NAME`, `OPENCODE_GIT_EMAIL`
- Claude: `CLAUDE_GIT_NAME`, `CLAUDE_GIT_EMAIL`
- Junie: `JUNIE_GIT_NAME`, `JUNIE_GIT_EMAIL`
- Copilot: `COPILOT_GIT_NAME`, `COPILOT_GIT_EMAIL`

Persistent gitconfig paths:

- `~/.config/opencode/gitconfig`
- `~/.config/claude/gitconfig`
- `~/.config/junie/gitconfig`
- `~/.config/copilot/gitconfig`

## Mounted Host Paths

- OpenCode: `~/.local/state/opencode`, `~/.local/share/opencode`, `~/.config/opencode`
- `opencode-auth` also exposes `127.0.0.1:1455:1455` - used as callback for login
- Claude: `~/.claude`, `~/.claude.json`, `~/.config/claude`
- Junie: `~/.junie`
- Copilot: `~/.copilot`
- Java wrappers: `~/.local/share/agent-container/m2` -> `/root/.m2`

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
  copilot-container copilot-container-java
```
