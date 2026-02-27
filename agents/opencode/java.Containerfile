FROM agent-runtime-base-java:fedora43

RUN npm install -g opencode-ai \
  && echo "Installed Open Code version: $(opencode --version)"

CMD ["opencode"]
