FROM agent-runtime-base-java:fedora43

RUN npm install -g @jetbrains/junie-cli && \
  echo "Installed Junie CLI version: $(junie --version)"

CMD ["junie"]
