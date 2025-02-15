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
# Copyright (c) 2023-2024 Claudio André <dev at claudioandre.slmail.me>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
###############################################################################
# Dockerfile for building John the Ripper (for fuzzing)
# More info at https://github.com/openwall/john-packages

FROM gcr.io/oss-fuzz-base/base-builder:v1@sha256:4b98548ccde24ad0e0f3671db7ff5712838cec5903474a323ec95688eecc0917

RUN git clone --depth 1 https://github.com/openwall/john.git /upstream \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        libbz2-dev=* libgmp-dev=* libpcap-dev=* \
        libssl-dev=* zlib1g-dev=* \
    # libFuzzingEngine requires a root user
    && useradd --uid 0 --non-unique --gid 0 -m tester \
# ==================================================================
# Clean up the image (shrink the Docker image)
# ------------------------------------------------------------------
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

WORKDIR $SRC/john
COPY .clusterfuzzlite/build.sh $SRC/
COPY scripts/helper.sh /upstream

USER tester
HEALTHCHECK NONE
