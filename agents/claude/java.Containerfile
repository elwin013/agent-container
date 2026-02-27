FROM agent-runtime-base-java:fedora43

RUN npm install -g @anthropic-ai/claude-code \
  && echo "Installed Claude Code version: $(claude --version)"

CMD ["claude"]
