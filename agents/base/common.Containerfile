FROM registry.fedoraproject.org/fedora:43

# Install shared dependencies used by all agent images.
RUN dnf install npm git \
    curl wget gnupg jq ca-certificates \
    vim nano make \
    zip unzip procps ripgrep tree ImageMagick -y && \
    dnf clean all

# Store globally installed npm packages under /usr/local.
ENV NPM_CONFIG_PREFIX=/usr/local
ENV PATH=$NPM_CONFIG_PREFIX/bin:$PATH

RUN mkdir -p /root/.config /root/.local /home/agent

ENV HOME=/home/agent

WORKDIR /home/agent
