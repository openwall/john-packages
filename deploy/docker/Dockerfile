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
# Copyright (c) 2019-2023 Claudio André <claudioandre.br at gmail.com>
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

FROM nvidia/cuda:12.3.2-base-ubuntu22.04@sha256:8cecfe099315f73127d6d5cc43fce32c7ffff4ea0460eefac48f2b7d811ce857 AS build
WORKDIR /build/
COPY build.sh .

# To build a release run a (docker build [...] --build-arg release=true)
ARG RELEASE=false
ARG COMMIT=39db7dd63e3fefb343c3dbb72eaa5c7599b6c298
ARG TYPE=ALL

RUN ./build.sh "${TYPE}"

# ==================================================================
# Build the final lean Docker image
# ------------------------------------------------------------------
FROM nvidia/cuda:12.3.2-base-ubuntu22.04@sha256:8cecfe099315f73127d6d5cc43fce32c7ffff4ea0460eefac48f2b7d811ce857

# ==================================================================
# Runtime setup and libraries
# ------------------------------------------------------------------
# libssl3                          (apt)
# libgomp1                         (apt)
# Default user is JtR

COPY --from=build /build/john /john
RUN mkdir -p /usr/share/ && ln -s /john/run /usr/share/john
COPY docker-entrypoint.sh /usr/local/bin/

RUN ln -s /usr/local/bin/docker-entrypoint.sh . && \
    useradd -U -m JtR && \
    apt-get update -qq && \
    export DEBIAN_FRONTEND="noninteractive" && \
    apt-get install -y --no-install-recommends libssl3=3.0* libgomp1=12.3* ocl-icd-libopencl1=2.2* \
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
ENV VERSION="${VERSION}"
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["best"]
