######################################################################
# Copyright (c) 2021 Claudio André <claudioandre.br at gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
######################################################################

FROM ubuntu:latest
LABEL maintainer Claudio André (c) 2021 1.0.Cloud Tools
LABEL software automation for John the Ripper

RUN apt-get update -qq && \
    export DEBIAN_FRONTEND="noninteractive" && \
    apt-get install -y curl gnupg software-properties-common && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install -y \
        terraform ansible \
        wget git nano \
        && \
    useradd -U -m usr && \
    # Clean the image
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists

USER usr
WORKDIR /host/workdir
ENV PROVIDER AWS
CMD /bin/bash