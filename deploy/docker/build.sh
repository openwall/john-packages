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
# Copyright (c) 2019-2024 Claudio André <claudioandre.br at gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
###############################################################################
# Script to automate the build of John the Ripper Docker image
# More info at https://github.com/openwall/john-packages

function install_nvidia_opencl() {
	apt-get install -y --no-install-recommends \
		nvidia-opencl-dev=*
}

type="$1"
export DEPLOY_PAK="Yes"
arch=$(uname -m)

# Build options (system wide, disable checks, etc.)
SYSTEM_WIDE='--with-systemwide'
X86_REGULAR="--disable-native-tests $SYSTEM_WIDE"
X86_NO_OPENMP="--disable-native-tests $SYSTEM_WIDE --disable-openmp"

OTHER_REGULAR="$SYSTEM_WIDE"
OTHER_NO_OPENMP="$SYSTEM_WIDE --disable-openmp"

# Install build dependencies
apt-get update -qq
export DEBIAN_FRONTEND="noninteractive"
apt-get install -y --no-install-recommends \
	build-essential=* libssl-dev=* zlib1g-dev=* yasm=* libgmp-dev=* libpcap-dev=* pkg-config=* \
	libbz2-dev=* wget=* git=* libusb-1.0-0-dev=* ca-certificates=* curl=*

if [ "$type" == "ALL" ] || [ "$type" == "GPU" ]; then
	install_nvidia_opencl
fi

# Build helper
wget https://raw.githubusercontent.com/openwall/john-packages/release/tests/run_build.sh
echo "8685dea557376611040ce02b1bd6bec92062ed27b81bcdd4949fc186090b75f7  ./run_build.sh" | sha256sum -c - || exit 1
# shellcheck source=/dev/null
source run_build.sh

# Get upstream source code
git clone --depth 10 https://github.com/openwall/john.git

# Make it a reproducible build
if [ "$RELEASE" == "true" ]; then
	(
		cd john || exit 1
		git checkout "$COMMIT"
	)
fi

(
	cd john/src || exit 1
	do_get_version

	if [ "$arch" == "x86_64" ]; then
		# x86_64 CPU (OMP and SIMD binaries)
		do_configure "$X86_NO_OPENMP" --enable-simd=avx && do_build ../run/john-avx
		do_configure "$X86_REGULAR" --enable-simd=avx && do_build ../run/john-avx-omp
		do_configure "$X86_NO_OPENMP" --enable-simd=avx2 && do_build ../run/john-avx2
		do_configure "$X86_REGULAR" --enable-simd=avx2 && do_build ../run/john-avx2-omp
		do_configure "$X86_NO_OPENMP" --enable-simd=avx512f && do_build ../run/john-avx512f
		do_configure "$X86_REGULAR" --enable-simd=avx512f && do_build ../run/john-avx512f-omp
		do_configure "$X86_NO_OPENMP" --enable-simd=avx512bw && do_build ../run/john-avx512bw
		do_configure "$X86_REGULAR" --enable-simd=avx512bw && do_build ../run/john-avx512bw-omp
	else
		# Non X86 CPU (OMP fallback)
		do_configure "$OTHER_NO_OPENMP" && do_build "../run/john-$arch"
		do_configure "$OTHER_REGULAR" && do_build ../run/john-omp
	fi
	do_release "Yes" "Yes" # --system-wide, --support-opencl, --binary-name
	do_clean_package
)
