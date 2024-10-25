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
# Copyright (c) 2019-2024 Claudio André <dev at claudioandre.slmail.me>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
###############################################################################

git_tag=$(git rev-parse --short=7 HEAD 2>/dev/null)
ID=$(curl -s https://raw.githubusercontent.com/openwall/john-packages/release/deploy/Release.ID 2>/dev/null | tr -d '\n')

if [[ -z "$ID" || "$ID" == "404: Not Found" ]]; then

	if [[ -f ../../john/Release.ID ]]; then
		echo "==== Using flatpak's Release.ID ====" >&2
		ID=$(cat ../../john/Release.ID)
	fi
else
	echo "==== Using the version from 'Release.ID' ====" >&2
fi
size=${#ID}

if [[ $size -gt 6 || "$ID" == v* ]]; then
	echo "$ID"
else
	echo "$ID$git_tag"
fi

# Examples
# 1.9J1+2404     # Rolling release
# 1.9J1+c9825e6  # Development version
# v1.10.0        # A real release (without the name Jumbo)
