# GitHub Copilot CLI

- Images:
  - `agents/copilot/base.Containerfile`
  - `agents/copilot/java.Containerfile`
- Wrappers:
  - `agents/copilot/scripts/copilot`
  - `agents/copilot/scripts/copilot-git`
  - `agents/copilot/scripts/copilot-java`
  - `agents/copilot/scripts/copilot-java-git`
- Wrapper generation:
  - Generated from `templates/wrappers` via `bash scripts/render-wrappers`
- Image tags:
  - `copilot-container`
  - `copilot-container-java`
- Install method:
  - `npm install -g @github/copilot`
