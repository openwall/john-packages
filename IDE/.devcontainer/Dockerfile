###############################################################################
#        _       _             _   _            _____  _
#       | |     | |           | | | |          |  __ \(_)
#       | | ___ | |__  _ __   | |_| |__   ___  | |__) |_ _ __  _ __   ___ _ __
#   _   | |/ _ \| '_ \| '_ \  | __| '_ \ / _ \ |  _  /| | '_ \| '_ \ / _ \ '__|
#  | |__| | (_) | | | | | | | | |_| | | |  __/ | | \ \| | |_) | |_) |  __/ |
#   \____/ \___/|_| |_|_| |_|  \__|_| |_|\___| |_|  \_\_| .__/| .__/ \___|_|
#                                                       | |   | |
#                                                       |_|   |_|
#
# Copyright (c) 2024 Claudio André <dev@claudioandre.slmail.me>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
###############################################################################
# Dockerfile for development with VS Code
# More info at https://github.com/openwall/john-packages

# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/master/containers

FROM mcr.microsoft.com/vscode/devcontainers/base:noble@sha256:167e522ad50971b29dda8c09faac30562fce5a7596f1aba765995728985184b8

ENV NODE_DOWNLOAD_SHA256="dd3bc508520fcdfdc8c4360902eac90cba411a7e59189a80fb61fcbea8f4199c"
ENV RUST_DOWNLOAD_SHA256="32a680a84cf76014915b3f8aa44e3e40731f3af92cd45eb0fcc6264fd257c428"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        build-essential=* ca-certificates=* cpio=* gdb=* golang=* libbz2-dev=* libgmp-dev=* \
        libpcap-dev=* libpocl-dev=* libssl-dev=* ocl-icd-opencl-dev=* pkg-config=* \
        pocl-opencl-icd=* pre-commit=* shellcheck=* yasm=* zlib1g-dev=* \
    #
    && TMPFILE=$(mktemp /tmp/node-XXXXX) \
    && curl -sSf --proto '=https' --tlsv1.3 https://deb.nodesource.com/setup_20.x | \
        tee "$TMPFILE" | bash - \
    && echo "$NODE_DOWNLOAD_SHA256  $TMPFILE" | sha256sum -c - \
    && apt-get -y install --no-install-recommends nodejs=* \
    # Clean up-
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN TMPFILE=$(mktemp /tmp/node-XXXXX) \
    && curl -sSf --proto '=https' --tlsv1.3 https://sh.rustup.rs | \
        tee "$TMPFILE" | bash -s -- -y \
    && echo "$RUST_DOWNLOAD_SHA256  $TMPFILE" | sha256sum -c -

USER vscode
HEALTHCHECK NONE
