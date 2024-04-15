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
# Copyright (c) 2021-2023 Claudio André <claudioandre.br at gmail.com>
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

FROM ubuntu:latest@sha256:77906da86b60585ce12215807090eb327e7386c8fafb5402369e421f44eff17e
LABEL org.opencontainers.image.authors="Claudio André <claudioandre.br at gmail com>"
LABEL description="IDE automation for John the Ripper (1.0.Cloud Tools)"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update -qq && \
    export DEBIAN_FRONTEND="noninteractive" && \
    apt-get install -y --no-install-recommends wget=* gnupg=* software-properties-common=* ca-certificates=* && \
    wget --progress=dot:giga -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install -y --no-install-recommends \
        terraform=* ansible=* \
        wget=* git=* nano=* \
    && useradd -U -m usr \
    # Clean the image
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

USER usr
WORKDIR /host/workdir
ENV PROVIDER=AWS
CMD ["/bin/bash"]
HEALTHCHECK NONE
