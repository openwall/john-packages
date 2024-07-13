# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/master/containers

FROM mcr.microsoft.com/vscode/devcontainers/base:noble@sha256:4584130239525059f7afd0014db436c4e9775872e4db0ec903c6e628480b9f6e

ENV NODE_DOWNLOAD_SHA256="f8fb478685fb916cc70858200595a4f087304bcde1e69aa713bf2eb41695afc1"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
           build-essential=* libssl-dev=* zlib1g-dev=* libgmp-dev=* libpcap-dev=* libbz2-dev=* \
           yasm=* pkg-config=* \
           gdb=* cpio=* pre-commit=* \
           libpocl-dev=* ocl-icd-opencl-dev=* pocl-opencl-icd=* \
           golang=* shellcheck=* \
    #
    && TMPFILE=$(mktemp /tmp/node-XXXXX) \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | \
       tee "$TMPFILE" | bash - \
    && echo "$NODE_DOWNLOAD_SHA256  $TMPFILE" | sha256sum -c - \
    && apt-get -y install --no-install-recommends nodejs=* \
    # Clean up-
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | bash -s -- -y

USER vscode
HEALTHCHECK NONE
