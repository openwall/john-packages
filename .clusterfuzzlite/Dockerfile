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
# Copyright (c) 2023 Claudio André <claudioandre.br at gmail.com>
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

FROM gcr.io/oss-fuzz-base/base-builder:v1@sha256:fc88839e5c2a160a4249f9bc54472f338e7e4bf33f292515cce52efbcf2027ee

RUN git clone --depth 1 https://github.com/openwall/john.git /upstream
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends libssl-dev=* zlib1g-dev=* && \
    apt-get install -y --no-install-recommends libgmp-dev=* libpcap-dev=* libbz2-dev=* \
# ==================================================================
# Clean up the image (shrink the Docker image)
# ------------------------------------------------------------------
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

WORKDIR $SRC/john
COPY .clusterfuzzlite/build.sh $SRC/
