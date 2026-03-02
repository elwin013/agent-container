FROM agent-runtime-base:fedora43

# Install SDKMAN and multiple Java versions (17, 21, 25) plus Maven and Gradle.
ENV SDKMAN_DIR=/root/.sdkman
ENV PATH=$SDKMAN_DIR/candidates/java/current/bin:$SDKMAN_DIR/candidates/maven/current/bin:$SDKMAN_DIR/candidates/gradle/current/bin:$PATH

RUN curl -s "https://get.sdkman.io" | bash
RUN bash -lc "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk version"
RUN bash -lc "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk install java 17.0.18-tem"
RUN bash -lc "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk install maven"
RUN bash -lc "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk install gradle"
RUN bash -lc "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk install java 21.0.10-tem"
RUN bash -lc "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk install java 24.0.2-tem"
RUN bash -lc "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk install java 25.0.2-tem"
RUN bash -lc "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk default java 25.0.2-tem"
