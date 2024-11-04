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
# Copyright (c) 2017-2024 Claudio André <dev@claudioandre.slmail.me>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
###############################################################################
# Dockerfile for Continuous Integration
# More info at https://github.com/openwall/john-packages

FROM ubuntu:24.04@sha256:99c35190e22d294cdace2783ac55effc69d32896daaa265f0bbedbcde4fbe3e5
LABEL org.opencontainers.image.authors="Claudio André <dev@claudioandre.slmail.me>"
LABEL description="Docker images for John the Ripper CI (1.0.Ubuntu 24 OpenCL)"
LABEL org.opencontainers.image.source="https://github.com/openwall/john-packages"

RUN apt-get update -qq \
    && export DEBIAN_FRONTEND="noninteractive" \
    && apt-get install -y --no-install-recommends \
        afl++ build-essential ca-certificates clang debhelper git libbz2-dev libgmp-dev libnet1-dev libomp-dev \
        libpcap-dev libpocl-dev libssl-dev llvm ocl-icd-libopencl1 ocl-icd-opencl-dev \
        opencl-headers pkg-config pocl-opencl-icd wget yasm zlib1g-dev zzuf \
    # Azure DevOps requires a root user
    && useradd --uid 0 --non-unique --gid 0 -m tester \
# ==================================================================
# Clean up the image (shrink the Docker image)
# ------------------------------------------------------------------
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

ENV BASE ubuntu-pocl
CMD [ "/bin/bash" ]

USER tester
HEALTHCHECK NONE
