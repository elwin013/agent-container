FROM registry.fedoraproject.org/fedora:43

# Install shared dependencies used by all agent images.
RUN dnf install npm git \
    curl wget gnupg jq ca-certificates \
    vim nano make \
    zip unzip procps ripgrep tree ImageMagick -y && \
    dnf clean all

# Store globally installed npm packages under /root/.npm-global.
ENV NPM_CONFIG_PREFIX=/root/.npm-global
ENV PATH=$NPM_CONFIG_PREFIX/bin:$PATH

RUN mkdir -p /root/.npm-global /root/.config /root/.local

WORKDIR /app
