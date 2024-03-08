# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/master/containers

FROM mcr.microsoft.com/vscode/devcontainers/base:jammy@sha256:08845a02c0472bb026f9cc4bb74bccaf2039945e7a9b41c4dbcce578c1830d40

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
           build-essential=* libssl-dev=* zlib1g-dev=* libgmp-dev=* libpcap-dev=* libbz2-dev=* \
           yasm=* pkg-config=* \
           gdb=* cpio=* pre-commit=* \
           libpocl-dev=* ocl-icd-opencl-dev=* pocl-opencl-icd=* \
           golang=* shellcheck=* \
    #
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get -y install --no-install-recommends nodejs=* \
    # Clean up-
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

USER vscode
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | bash -s -- -y
