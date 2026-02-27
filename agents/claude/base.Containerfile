FROM agent-runtime-base:fedora43

RUN npm install -g @anthropic-ai/claude-code && \
  echo "Installed Claude Code version: $(claude --version)"

CMD ["claude"]
