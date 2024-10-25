#!/bin/bash
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
# Script to get logs files from CI
# More info at https://github.com/openwall/john-packages

# Directory names and folders
FLATPAK="6533120921"
AZURE_ID="482"

# Azure Windows package (64 bits) ##############################################
wget "https://dev.azure.com/claudioandre-br/40224313-b91e-465d-852b-fc4ea516f33e/_apis/build/builds/$AZURE_ID/logs/128" \
	-O windows_log.txt

# GitLab (Linux Flatpak app) ###################################################
wget "https://gitlab.com/claudioandre-br/JtR-CI/-/jobs/$FLATPAK/raw" \
	-O bundle_log.txt

# macOS ########################################################################
wget "https://api.cirrus-ci.com/v1/task/4652265359802368/logs/build.log" \
	-O macM1_log.txt
wget "https://api.cirrus-ci.com/v1/task/4652265359802368/logs/package.log" \
	-O - >>macM1_log.txt

# Snap App #####################################################################
rm buildlog*.gz

wget https://launchpad.net/~claudioandre.br/john/+snap/john-the-ripper/+build/2438416/+files/buildlog_snap_ubuntu_jammy_amd64_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/john/+snap/john-the-ripper/+build/2438417/+files/buildlog_snap_ubuntu_jammy_armhf_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/john/+snap/john-the-ripper/+build/2438418/+files/buildlog_snap_ubuntu_jammy_arm64_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/john/+snap/john-the-ripper/+build/2438419/+files/buildlog_snap_ubuntu_jammy_ppc64el_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/john/+snap/john-the-ripper/+build/2438420/+files/buildlog_snap_ubuntu_jammy_s390x_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/john/+snap/john-the-ripper/+build/2438421/+files/buildlog_snap_ubuntu_jammy_riscv64_john-the-ripper_BUILDING.txt.gz
