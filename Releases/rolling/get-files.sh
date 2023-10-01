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
# Copyright (c) 2021-2023 Claudio André <claudioandre.br at gmail.com>
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
FLATPAK="5132721237"
AZURE_ID="447"

# Azure Windows package (64 bits) ##############################################
wget "https://dev.azure.com/claudioandre-br/40224313-b91e-465d-852b-fc4ea516f33e/_apis/build/builds/$AZURE_ID/logs/123" \
    -O windows_log.txt

# GitLab (Linux Flatpak app) ###################################################
wget "https://gitlab.com/claudioandre-br/JtR-CI/-/jobs/$FLATPAK/raw" \
    -O bundle_log.txt

# macOS ########################################################################
wget "https://api.cirrus-ci.com/v1/task/4704739347136512/logs/build.log" \
    -O macM1_log.txt
wget "https://api.cirrus-ci.com/v1/task/4704739347136512/logs/package.log" \
    -O ->> macM1_log.txt

wget "https://circleci.com/api/v1.1/project/github/claudioandre-br/JohnTheRipper/6318/output/102/0?file=true&allocation-id=650b9460965983317c043b4b-0-build%2FABCDEFGH" \
    -O macX86_log.txt

# Snap App #####################################################################
rm buildlog*.gz

wget https://launchpad.net/~claudioandre.br/john/+snap/john-the-ripper/+build/2236339/+files/buildlog_snap_ubuntu_jammy_armhf_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/john/+snap/john-the-ripper/+build/2236341/+files/buildlog_snap_ubuntu_jammy_s390x_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/john/+snap/john-the-ripper/+build/2236340/+files/buildlog_snap_ubuntu_jammy_arm64_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/john/+snap/john-the-ripper/+build/2236338/+files/buildlog_snap_ubuntu_jammy_amd64_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/john/+snap/john-the-ripper/+build/2236315/+files/buildlog_snap_ubuntu_jammy_ppc64el_john-the-ripper_BUILDING.txt.gz
