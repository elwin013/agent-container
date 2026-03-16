FROM agent-runtime-base-java:fedora43

RUN npm i -g @openai/codex \
  && echo "Installed Codex CLI version: $(codex --version)"

CMD ["codex"]
