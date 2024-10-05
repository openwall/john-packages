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
# Copyright (c) 2021-2024 Claudio André <dev at claudioandre.slmail.me>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
###############################################################################
# Dockerfile for a cloud helper tool
# More info at https://github.com/openwall/john-packages

FROM ubuntu:latest@sha256:b359f1067efa76f37863778f7b6d0e8d911e3ee8efa807ad01fbf5dc1ef9006b
LABEL org.opencontainers.image.authors="Claudio André <dev@claudioandre.slmail.me>"
LABEL description="Automation for John the Ripper (1.0.Cloud Tools)"

ENV HC_DOWNLOAD_SHA256="cafb01beac341bf2a9ba89793e6dd2468110291adfbb6c62ed11a0cde6c09029"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update -qq \
    && export DEBIAN_FRONTEND="noninteractive" \
    && apt-get install -y --no-install-recommends \
        gnupg=* software-properties-common=* ca-certificates=* \
        wget=* git=* nano=* \
    && wget --progress=dot:giga https://apt.releases.hashicorp.com/gpg -O gpg.key \
    && echo "$HC_DOWNLOAD_SHA256  gpg.key" | sha256sum -c - \
    && gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg < gpg.key \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
        tee /etc/apt/sources.list.d/hashicorp.list \
    && apt-add-repository --yes --update ppa:ansible/ansible \
    && apt-get install -y --no-install-recommends \
        terraform=* ansible=* \
    && useradd -U -m usr \
# ==================================================================
# Clean up the image (shrink the Docker image)
# ------------------------------------------------------------------
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

USER usr
WORKDIR /host/workdir
ENV PROVIDER=AWS
CMD ["/bin/bash"]
HEALTHCHECK NONE
