FROM agent-runtime-base:fedora43

RUN npm i -g @openai/codex \
  && echo "Installed Codex CLI version: $(codex --version)"

CMD ["codex"]
