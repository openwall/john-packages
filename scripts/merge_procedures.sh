#!/bin/bash -e

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
# Copyright (c) 2024 Claudio André <dev at claudioandre.slmail.me>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
###############################################################################
# Script to control the automatic merge process
# More info at https://github.com/openwall/john-packages

echo "Environment"
env
echo "Done"

git config --global user.name "Continuous Integration"
git config --global user.email "username@users.noreply.github.com"
MERGE="$BRANCH"

if [[ "$APPROVALS" -ge 1 || "$SKIP" == 'true' ]]; then
	if [[ "$OWNER" != "openwall" ]]; then
		echo "From a fork."
		MERGE="$OWNER-$BRANCH"
		git checkout -b "$MERGE" main
		git pull "https://github.com/$OWNER/$REPO.git" "$BRANCH"
	else
		git checkout "$MERGE"
	fi
	echo "Merging the PR."
	git checkout main
	git merge --ff-only "$MERGE" || exit 1

	git push origin main
	git log -1
else
	echo "PR is not ready for merging! Nothing to do."
	exit 1
fi
