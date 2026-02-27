FROM agent-runtime-base:fedora43

RUN npm install -g @jetbrains/junie-cli && \
  echo "Installed Junie CLI version: $(junie --version)"

CMD ["junie"]
