# Junie

- Images:
  - `agents/junie/base.Containerfile`
  - `agents/junie/java.Containerfile`
- Wrappers:
  - `agents/junie/scripts/junie`
  - `agents/junie/scripts/junie-auth`
  - `agents/junie/scripts/junie-git`
  - `agents/junie/scripts/junie-java`
  - `agents/junie/scripts/junie-java-git`
- Image tags:
  - `junie-container`
  - `junie-container-java`
- Install method:
  - `npm install -g @jetbrains/junie-cli`
- Auth callback:
  - `junie-auth` exposes `127.0.0.1:62345:62345` for login callback handling.
