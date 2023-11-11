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

FROM nvidia/cuda:12.3.0-base-ubuntu22.04@sha256:ab701cbe9784a586949674dac46a83cd4bed19944fbc9324619317be865ea678 AS build
WORKDIR /build/
COPY build.sh .

# To build a release run a (docker build [...] --build-arg release=true)
ARG RELEASE=false
ARG COMMIT=39db7dd63e3fefb343c3dbb72eaa5c7599b6c298
ARG TYPE=ALL

RUN ./build.sh "${TYPE}"

# ==================================================================
# Tagging
# ------------------------------------------------------------------
FROM nvidia/cuda:12.3.0-base-ubuntu22.04@sha256:ab701cbe9784a586949674dac46a83cd4bed19944fbc9324619317be865ea678
LABEL maintainer="Claudio André (c) 2019-2023"

ARG VERSION_NAME
LABEL software="John the Ripper ${VERSION_NAME}"

LABEL org.opencontainers.image.revision="bleeding"

ARG BUILD_DATE
LABEL org.opencontainers.image.created="${BUILD_DATE}"

ARG VERSION
LABEL org.opencontainers.image.version="${VERSION}"

LABEL org.opencontainers.image.source="https://github.com/openwall/john-packages"

LABEL \
    org.opencontainers.image.authors="Claudio André <claudioandre.br at gmail com>" \
    org.opencontainers.image.url="https://github.com/openwall/john-packages.git" \
    org.opencontainers.image.vendor="Openwall" \
    org.opencontainers.image.licenses="GPL-2.0" \
    org.opencontainers.image.title="John the Ripper CE Auditing Tool" \
    org.opencontainers.image.description="John the Ripper is an Open Source password security auditing and password recovery tool. See https://www.openwall.com/john/"

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
    apt-get install -y --no-install-recommends libssl3=3.0* libgomp1=12.3* ocl-icd-opencl-dev=2.2* && \
# ==================================================================
# Clean up the image (shrink the Docker image)
# ------------------------------------------------------------------
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

# ==================================================================
# Default startup
# ------------------------------------------------------------------
USER JtR
ENV BASE=ubuntu
ENV VERSION="${VERSION}"
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["best"]
