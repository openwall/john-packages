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
# Copyright (c) 2019-2024 Claudio André <dev at claudioandre.slmail.me>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
###############################################################################
# Dockerfile for john the ripper that supports CPU formats plus NVIDIA GPUs
# More info at https://github.com/openwall/john-packages

# John the Ripper Docker image is hosted at GitHub Packages
#   https://github.com/openwall/john-packages/pkgs/container/john

FROM nvidia/cuda:12.6.1-base-ubuntu24.04@sha256:d02202d00be34dc690d068f89338f35ed5d122c061b2e6038eb735eb2b9b291d AS build
WORKDIR /build/
COPY build.sh .

# To build a release run a (docker build [...] --build-arg TYPE=ALL)
ARG TYPE=ALL
ARG RELEASE_COMMIT

RUN ./build.sh "$TYPE" "$RELEASE_COMMIT"

# ==================================================================
# Build the final lean Docker image
# ------------------------------------------------------------------
FROM nvidia/cuda:12.6.1-base-ubuntu24.04@sha256:d02202d00be34dc690d068f89338f35ed5d122c061b2e6038eb735eb2b9b291d

# ==================================================================
# Runtime setup and libraries
# ------------------------------------------------------------------
COPY --from=build /build /john
COPY docker-entrypoint.sh /usr/local/bin/
RUN mkdir -p /usr/share/ \
    && ln -s /john/run /usr/share/john

RUN useradd -U -m JtR \
    && export DEBIAN_FRONTEND="noninteractive" \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        libssl3t64=3.0* \
        libgomp1=14* \
        ocl-icd-libopencl1=2.3* \
# ==================================================================
# Clean up the image (shrink the Docker image)
# ------------------------------------------------------------------
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# ==================================================================
# Default startup
# ------------------------------------------------------------------
USER JtR
ENV BASE=ubuntu
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["best"]
HEALTHCHECK --interval=1m CMD docker-entrypoint.sh
