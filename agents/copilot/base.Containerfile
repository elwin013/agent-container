FROM agent-runtime-base:fedora43

RUN npm install -g @github/copilot \
  && echo "Installed GitHub Copilot CLI version: $(copilot --version)"

CMD ["copilot"]
