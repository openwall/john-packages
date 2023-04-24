#!/bin/bash
######################################################################
# Copyright (c) 2021-2023 Claudio André <claudioandre.br at gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
######################################################################

# Directory names and folders
APPVEYOR_32bits=""
FLATPAK="4052942751"
FLATPAK_TEST="4052942753"
AZURE_ID="389"
DOCKER=""

# AppVeyor (32 bits) ###########################################################
if [[ -n $APPVEYOR_32bits ]]; then
    wget https://ci.appveyor.com/api/buildjobs/$APPVEYOR_32bits/log                       -O x32_log.txt
fi

# Azure Windows package (64 bits) ##############################################
wget https://dev.azure.com/claudioandre-br/40224313-b91e-465d-852b-fc4ea516f33e/_apis/build/builds/$AZURE_ID/logs/128 -O x64_log.txt

# GitLab (Linux Flatpak app) ###################################################
wget https://gitlab.com/claudioandre-br/JtR-CI/-/jobs/$FLATPAK/raw                    -O bundle_log.txt
wget https://gitlab.com/claudioandre-br/JtR-CI/-/jobs/$FLATPAK_TEST/raw               -O bundle_test.txt

#Fiz download manual
#wget https://api.travis-ci.org/v3/job/$DOCKER/log.txt    -O docker_log.txt

# Snap App #####################################################################
rm buildlog*.gz

wget https://launchpad.net/~claudioandre.br/+snap/john-the-ripper/+build/2070904/+files/buildlog_snap_ubuntu_bionic_armhf_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/+snap/john-the-ripper/+build/2070905/+files/buildlog_snap_ubuntu_bionic_arm64_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/+snap/john-the-ripper/+build/2070903/+files/buildlog_snap_ubuntu_bionic_amd64_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/+snap/john-the-ripper/+build/2070902/+files/buildlog_snap_ubuntu_bionic_i386_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/+snap/john-the-ripper/+build/2070907/+files/buildlog_snap_ubuntu_bionic_s390x_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/+snap/john-the-ripper/+build/2070906/+files/buildlog_snap_ubuntu_bionic_ppc64el_john-the-ripper_BUILDING.txt.gz

if [[ "$1" == "ALL_FILES" ]]; then
    https://artprodsbr1.artifacts.visualstudio.com/A56e4da31-e2d8-472b-be22-766278080a34/40224313-b91e-465d-852b-fc4ea516f33e/_apis/artifact/cGlwZWxpbmVhcnRpZmFjdDovL2NsYXVkaW9hbmRyZS1ici9wcm9qZWN0SWQvNDAyMjQzMTMtYjkxZS00NjVkLTg1MmItZmM0ZWE1MTZmMzNlL2J1aWxkSWQvMzExL2FydGlmYWN0TmFtZS93aW5feDY0Ljd60/content?format=file&subPath=%2Fwin_x64.7z  -O x64_win.7z
    wget https://ci.appveyor.com/api/buildjobs/$APPVEYOR_32bits/artifacts/win_x32.7z  -O x32_win.7z
    wget https://gitlab.com/claudioandre-br/packages/-/jobs/$FLATPAK/artifacts/download  -O john.flatpak.zip

    unzip john.flatpak.zip
    sha256sum *.zip
    sha256sum *.7z
    sha256sum john.flatpak
fi

