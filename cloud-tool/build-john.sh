#!/usr/bin/env bash
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

# Prepare the environment
sudo apt-get -y install git build-essential libssl-dev zlib1g-dev libgmp-dev libpcap-dev libbz2-dev
git clone --depth 10 https://github.com/openwall/john.git
cd john/src

# Build John the Ripper
# TODO remove the next line
rm -f *fmt_plug.c
./configure && make -sj2
../run/john
