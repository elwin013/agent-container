# agent-container

Run coding agents in containers against your current directory so they cannot access your full host file system.

Images use Fedora 43 as the base.

## Requirements

- Docker or Podman
- `make`

## Repository structure

- `agents/opencode`: OpenCode image definitions and notes
- `agents/opencode/scripts`: OpenCode wrappers
- `agents/claude`: Claude image definitions and notes
- `agents/claude/scripts`: Claude wrappers
- `agents/junie`: Junie image definitions and notes
- `agents/junie/scripts`: Junie wrappers
- `agents/base`: shared base images reused by all agents
- `mk`: Make target modules

## Architecture

This repository organizes agent container support by capability and agent name.

- `agents/<agent>` stores image definitions and notes for each agent variant.
- `agents/base` stores shared runtime base images.
- `agents/<agent>/scripts` stores standalone wrapper scripts copied to `~/.local/bin`.
- `mk` stores reusable make target modules for build/install flows.

To add a new agent:

1. Add `agents/<agent>/base.Containerfile` and `agents/<agent>/java.Containerfile`.
2. Add standalone wrappers under `agents/<agent>/scripts/`.
3. Add `build-*`, `addbin-*`, and `removebin-*` targets.
4. Add `agents/<agent>/README.md` and update `README.md`.

Build flow:

- `build-base` builds `agent-runtime-base:fedora43` from `agents/base/common.Containerfile`.
- `build-base-java` builds `agent-runtime-base-java:fedora43` from `agents/base/java.Containerfile`.
- Agent build targets depend on one of these base images.

## Build and install wrappers

OpenCode:

```sh
make build-opencode
make build-opencode-java
```

Claude Code:

```sh
make build-claude
make build-claude-java
```

Junie:

```sh
make build-junie
make build-junie-java
```

Build everything in one command:

```sh
make build-all
```

Backward-compatible aliases:

- `make build` -> `make build-opencode`
- `make build-java` -> `make build-opencode-java`

Base images are built first automatically:

- `make build-base`
- `make build-base-java`

## Installed wrapper scripts

Wrapper sources live in each agent directory under `agents/*/scripts/`. Build targets copy wrappers into `~/.local/bin`.

OpenCode wrappers:

- `~/.local/bin/opencode`
- `~/.local/bin/opencode-auth`
- `~/.local/bin/opencode-git`
- `~/.local/bin/opencode-java`
- `~/.local/bin/opencode-java-git`

Claude wrappers:

- `~/.local/bin/claude`
- `~/.local/bin/claude-git`
- `~/.local/bin/claude-java`
- `~/.local/bin/claude-java-git`

Junie wrappers:

- `~/.local/bin/junie`
- `~/.local/bin/junie-auth`
- `~/.local/bin/junie-git`
- `~/.local/bin/junie-java`
- `~/.local/bin/junie-java-git`

Make sure `~/.local/bin` is on your `PATH`.

## Usage

Run from your project directory.

OpenCode:

```sh
opencode
opencode-auth
opencode-git
opencode-java
opencode-java-git
```

Claude Code:

```sh
claude
claude-git
claude-java
claude-java-git
```

Junie:

```sh
junie
junie-auth
junie-git
junie-java
junie-java-git
```

To pass extra container runtime flags, use `--` to separate container flags from agent flags:

```sh
opencode --network host -e FOO=bar -- -s session-id
claude --cpus 2 -- --help
junie -e BAR=baz -- --help
```

Without `--`, all arguments are forwarded to the agent CLI.

## Git-enabled wrappers

`*-git` wrappers set git identity inside the container, set `/app` as `safe.directory`, and disable GPG signing for commits and tags.

Defaults:

- OpenCode: `OPENCODE_GIT_NAME="OpenCode Agent"`, `OPENCODE_GIT_EMAIL="opencode@localhost"`
- Claude: `CLAUDE_GIT_NAME="Claude Code Agent"`, `CLAUDE_GIT_EMAIL="claude@localhost"`
- Junie: `JUNIE_GIT_NAME="Junie Agent"`, `JUNIE_GIT_EMAIL="junie@localhost"`

Git config is persisted on the host:

- OpenCode: `~/.config/opencode/gitconfig`
- Claude: `~/.config/claude/gitconfig`
- Junie: `~/.config/junie/gitconfig`

## Mounted state/config directories

OpenCode wrappers mount:

- `$(pwd)` -> `/app`
- `~/.local/state/opencode` -> `/root/.local/state/opencode`
- `~/.local/share/opencode` -> `/root/.local/share/opencode`
- `~/.config/opencode` -> `/root/.config/opencode`
- `opencode-auth` additionally exposes `127.0.0.1:1455:1455`

Claude wrappers mount:

- `$(pwd)` -> `/app`
- `~/.claude` -> `/root/.claude`
- `~/.claude.json` -> `/root/.claude.json`
- `~/.config/claude` -> `/root/.config/claude`

Junie wrappers mount:

- `$(pwd)` -> `/app`
- `~/.junie` -> `/root/.junie`
- `junie-auth` additionally exposes `127.0.0.1:62345:62345`

Java wrappers additionally mount:

- `~/.local/share/agent-container/m2` -> `/root/.m2`

## Junie status

Junie images install `@jetbrains/junie-cli` globally via npm.

## Remove

Remove local wrapper scripts:

```sh
make removebin
```

Remove images:

```sh
docker rmi \
  opencode-container \
  opencode-container-java \
  claude-code-container \
  claude-code-container-java \
  junie-container \
  junie-container-java
```
