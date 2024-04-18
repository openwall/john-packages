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
# Copyright (c) 2019-2023 Claudio André <claudioandre.br at gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
###############################################################################
# Script with helpers to build binaries and packages
# More info at https://github.com/openwall/john-packages

function do_configure() {
	param="$1"
	shift
	# shellcheck disable=SC2086
	set -- $param "$@"
	./configure "$@"
}

function do_build() {
	set -e

	if [[ -n "$MAKE_CMD" ]]; then
		MAKE="$MAKE_CMD"
	else
		MAKE="make"
	fi

	if [[ -z "$MAKE_FLAGS" ]]; then
		MAKE_FLAGS="-sj$(nproc)"
	fi
	echo "$MAKE with flags: $MAKE_FLAGS"

	if [[ -n "$1" ]]; then
		$MAKE -s clean && $MAKE "$MAKE_FLAGS" && mv ../run/john "$1"
	else
		$MAKE -s clean && $MAKE "$MAKE_FLAGS"
	fi
	set +e
}

function do_get_version() {
	# Computes the package version
	(
		if [[ $FLATPAK_BUILD -ne 1 ]]; then
			cd .. || exit 1
			do_validate_checksum \
				https://raw.githubusercontent.com/openwall/john-packages/main/tests/package_version.sh
			chmod +x package_version.sh
		fi
	)
	PACKAGE_VERSION="$(../package_version.sh)"
	export PACKAGE_VERSION
	echo "$PACKAGE_VERSION" >version.txt
	rm -f ../package_version.sh
}

function do_clean_package() {
	# Removes files that should not be in the final package version
	(
		cd .. || exit 1
		if [[ $FLATPAK_BUILD -ne 1 ]]; then
			do_validate_checksum \
				https://raw.githubusercontent.com/openwall/john-packages/main/tests/clean_package.sh
		fi
		# shellcheck source=/dev/null
		source clean_package.sh
		rm -f clean_package.sh
	)
}

function do_release() {

	if [[ -n "$3" ]]; then
		(
			#Create a 'john' executable
			cd ../run
			ln -s "$3" john
		)
	fi

	# Save information about how the binaries were built
	cat <<-EOF >../run/Defaults
		#   This file lists how the build (binaries) were made
		[Build Configuration]
		System Wide Build="$1"
		Architecture="$(uname -m)"
		OpenMP=No
		OpenCL="$2"
		Optional Libraries=Yes
		Regex, OpenMPI, Experimental Code, ZTEX=No
		Version="$PACKAGE_VERSION"
	EOF

	echo "-----------------------------------------------------------"
	cat ../run/Defaults
	echo "-----------------------------------------------------------"
	ls -l ../run/john || true
	echo "-----------------------------------------------------------"

	if [[ $FLATPAK_BUILD -eq 1 ]]; then
		# Test whether the fallback works.
		../run/john || true
		echo "-----------------------------------------------------------"
		../run/john-avx2-omp
		echo "-----------------------------------------------------------"
	fi
}

function do_validate_checksum() {
	FILE_URL="$1"
	FILE_BASENAME=$(basename "$FILE_URL")
	URL_LOCATION=$(dirname "$FILE_URL")

	echo "-----------------------------------------------------------"
	wget "$FILE_URL" -O "$FILE_BASENAME"
	echo "-----------------------------------------------------------"
	echo "Downloading and validating $FILE_BASENAME:"
	echo "- from $URL_LOCATION;"
	CHECKSUM_VALUE=$(grep "$FILE_BASENAME" requirements.txt | cut -d' ' -f1)
	echo "- expecting: $CHECKSUM_VALUE;"

	# Validate data
	echo "$CHECKSUM_VALUE  $FILE_BASENAME" | sha256sum -c -
	RETURN_VALUE=$?

	if [[ RETURN_VALUE -ne 0 ]]; then
		echo "-----------------------------------------------------------"
		exit 1
	fi
	echo "-----------------------------------------------------------"
}

# Show environment information
if [[ $FLATPAK_BUILD -eq 1 ]]; then
	# shellcheck source=/dev/null
	source ../show_info.sh
else
	do_validate_checksum \
		https://raw.githubusercontent.com/openwall/john-packages/release/tests/show_info.sh
	# shellcheck source=/dev/null
	source show_info.sh
fi
