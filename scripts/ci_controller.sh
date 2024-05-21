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
# Copyright (c) 2019-2023 Claudio André <claudioandre.br at gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
###############################################################################
# Script to control the build of John the Ripper packages
# More info at https://github.com/openwall/john-packages

# Required defines
arch=$(uname -m)
JTR='../run/john'
TASK_RUNNING="$2"
export -p JTR TASK_RUNNING

# Mute the system Information on testing
if [[ "$2" == "TEST" ]]; then
	export MUTE_SYS_INFO="Yes"
fi

# The new J2 Docker image does not have wget installed
if [[ "$EXTRA" == "SIMD" ]]; then
	apt-get update
	apt-get -y install wget
fi

if [[ $TARGET_ARCH == *"SOLARIS"* && $2 == "BUILD" ]]; then
	pkg install --accept gcc
fi

if [[ "$TARGET_ARCH" == *"macOS"* && $2 == "INFO" ]]; then
	brew update
	brew install openssl libpcap libomp gmp coreutils p7zip
fi

# Download the required and missing file
wget https://raw.githubusercontent.com/openwall/john-packages/release/scripts/helper.sh \
	-O helper.sh
cd src || exit 1

# shellcheck source=/dev/null
source ../helper.sh

# Build and testing
if [[ "$2" == "BUILD" ]]; then
	# Make it a reproducible build
	if [[ -n "$RELEASE_COMMIT" ]]; then
		echo "Deploying the release $RELEASE_COMMIT"
		git pull --unshallow
		git checkout "$RELEASE_COMMIT"
	fi
	do_get_version

	echo ""
	echo "---------------------------- BUILDING -----------------------------"

	if [[ "$TARGET_ARCH" == *"macOS"* ]]; then
		SYSTEM_WIDE=''
		REGULAR="$SYSTEM_WIDE $ASAN $BUILD_OPTS"
		NO_OPENMP="--disable-openmp $SYSTEM_WIDE $ASAN $BUILD_OPTS"

		#Libraries and Includes
		if [[ "$TARGET_ARCH" == *"macOS X86"* ]]; then
			MAC_LOCAL_PATH="usr/local/opt"
		else
			MAC_LOCAL_PATH="opt/homebrew/opt"
		fi
		LDFLAGS_ssl="-L/$MAC_LOCAL_PATH/openssl/lib"
		LDFLAGS_gmp="-L/$MAC_LOCAL_PATH/gmp/lib"
		LDFLAGS_omp="-L/$MAC_LOCAL_PATH/libomp/lib -lomp"

		CFLAGS_ssl="-I/$MAC_LOCAL_PATH/openssl/include"
		CFLAGS_gmp="-I/$MAC_LOCAL_PATH/gmp/include"
		CFLAGS_omp="-I/$MAC_LOCAL_PATH/libomp/include"

		if [[ $TARGET_ARCH == *"macOS ARM"* ]]; then
			brew link openssl --force
		fi

		if [[ $TARGET_ARCH == *"macOS X86"* ]]; then
			do_configure "$NO_OPENMP" --enable-simd=avx && do_build ../run/john-avx
			do_configure "$REGULAR" --enable-simd=avx LDFLAGS="$LDFLAGS_omp" CPPFLAGS="-Xclang -fopenmp $CFLAGS_omp -DOMP_FALLBACK_BINARY=\"\\\"john-avx\\\"\" " && do_build ../run/john-avx-omp
			do_configure "$NO_OPENMP" --enable-simd=avx2 && do_build ../run/john-avx2
			do_configure "$REGULAR" --enable-simd=avx2 LDFLAGS="$LDFLAGS_omp" CPPFLAGS="-Xclang -fopenmp $CFLAGS_omp -DOMP_FALLBACK_BINARY=\"\\\"john-avx2\\\"\" -DCPU_FALLBACK_BINARY=\"\\\"john-avx-omp\\\"\" " && do_build ../run/john-avx2-omp
			BINARY="john-avx2-omp"
		else
			do_configure "$NO_OPENMP" LDFLAGS="$LDFLAGS_ssl $LDFLAGS_gmp" CPPFLAGS="$CFLAGS_ssl $CFLAGS_gmp" && do_build "../run/john-$arch"
			do_configure "$REGULAR" LDFLAGS="$LDFLAGS_ssl $LDFLAGS_gmp $LDFLAGS_omp" CPPFLAGS="-Xclang -fopenmp $CFLAGS_ssl $CFLAGS_gmp $CFLAGS_omp -DOMP_FALLBACK_BINARY=\"\\\"john-$arch\\\"\" " && do_build ../run/john-omp
			BINARY="john-omp"
		fi
		do_release "No" "Yes" $BINARY # --system-wide, --support-opencl, --binary-name
	fi

	if [[ $TARGET_ARCH == *"SOLARIS"* ]]; then
		do_configure "$ASAN $BUILD_OPTS"
		do_build
	fi

	if [[ $TARGET_ARCH == *"NIX"* ]]; then
		do_configure "$ASAN $BUILD_OPTS"
		do_build
	fi
	echo
	echo '-- Build Info --'
	$JTR --list=build-info || true

elif [[ "$2" == "TEST" ]]; then
	# Required defines
	JTR_BIN="$JTR"
	TEST=";$EXTRA;" # Controls how the test will happen

	if [[ "$TARGET_ARCH" == "DOCKER" ]]; then
		JTR_BIN="/john/run/john-avx"
	fi
	export -p JTR_BIN TEST

	do_validate_checksum \
		https://raw.githubusercontent.com/openwall/john-packages/release/scripts/run_tests.sh
	# shellcheck source=/dev/null
	source run_tests.sh
fi
