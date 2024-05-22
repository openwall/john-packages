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
# Script to automate the build of John the Ripper snap
# More info at https://github.com/openwall/john-packages

# Required defines
arch=$(uname -m)
DEPLOY_PAK="Yes"
JTR_BIN='/snap/john-the-ripper/current/run/john'
JTR_CL="$JTR_BIN"
TEST=';full;extra;' # Controls how the test will happen
BASE="Ubuntu"
TASK_RUNNING="Snap build"
export -p DEPLOY_PAK JTR_BIN JTR_CL TEST BASE TASK_RUNNING

# Build options (system wide, disable checks, etc.)
SYSTEM_WIDE='--with-systemwide'
X86_REGULAR="--disable-native-tests $SYSTEM_WIDE"
X86_NO_OPENMP="--disable-native-tests $SYSTEM_WIDE --disable-openmp"

if [[ "$arch" == "riscv64" ]]; then
	SYSTEM_WIDE="--build=riscv64-unknown-linux-gnu $SYSTEM_WIDE"
fi
OTHER_REGULAR="$SYSTEM_WIDE"
OTHER_NO_OPENMP="$SYSTEM_WIDE --disable-openmp"

# Download the required and missing file
wget https://raw.githubusercontent.com/openwall/john-packages/release/scripts/helper.sh \
	-O helper.sh
mkdir -p src
cd src || exit 1

# shellcheck source=/dev/null
source ../helper.sh
do_get_version

cp version.txt ..

do_validate_checksum \
	https://raw.githubusercontent.com/openwall/john-packages/release/patches/Handle-self-confined-system-wide-build.patch
patch <Handle-self-confined-system-wide-build.patch

# Testing only purposes
# wget https://raw.githubusercontent.com/claudioandre-br/JohnTheRipper/bleeding-jumbo/test.patch; #_BE_TEST=$?

if [[ "$_BE_TEST" == 0 ]]; then
	echo "Applying a testing purpose patch called 'test.patch'"
	git apply test.patch
fi

echo ""
echo "---------------------------- BUILDING -----------------------------"

if [[ "$arch" == "x86_64" ]]; then
	# x86_64 CPU (OMP and SIMD fallback)
	do_configure "$X86_NO_OPENMP" --enable-simd=avx CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-avx
	do_configure "$X86_REGULAR" --enable-simd=avx CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx\\\"\"" && do_build ../run/john-avx-omp
	do_configure "$X86_NO_OPENMP" --enable-simd=avx2 CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-avx2
	do_configure "$X86_REGULAR" --enable-simd=avx2 CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx2\\\"\" -DCPU_FALLBACK_BINARY=\"\\\"john-avx-omp\\\"\"" && do_build ../run/john-avx2-omp
	do_configure "$X86_NO_OPENMP" --enable-simd=avx512f CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-avx512f
	do_configure "$X86_REGULAR" --enable-simd=avx512f CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx512f\\\"\" -DCPU_FALLBACK_BINARY=\"\\\"john-avx2-omp\\\"\"" && do_build ../run/john-avx512f-omp
	do_configure "$X86_NO_OPENMP" --enable-simd=avx512bw CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-avx512bw
	do_configure "$X86_REGULAR" --enable-simd=avx512bw CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx512bw\\\"\" -DCPU_FALLBACK_BINARY=\"\\\"john-avx512f-omp\\\"\"" && do_build ../run/john-avx512bw-omp
	BINARY="john-avx512bw-omp"
	OPENCL_SUPPORT="Yes"
else
	# Non X86 CPU (OMP fallback)
	do_configure "$OTHER_NO_OPENMP" CPPFLAGS="-D_SNAP -D_BOXED" && do_build "../run/john-$arch"
	do_configure "$OTHER_REGULAR" CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-$arch\\\"\"" && do_build ../run/john-omp
	BINARY="john-omp"
	OPENCL_SUPPORT="No"
fi
do_release "Yes" "$OPENCL_SUPPORT" "$BINARY" # --system-wide, --support-opencl, --binary-name

# "------------------- Run CI -------------------"
# Default to bypass test procedures
wget --spider https://raw.githubusercontent.com/claudioandre-br/JohnTheRipper/bleeding-jumbo/run-CI.patch
CI_TEST=$?

if [[ $CI_TEST -eq 0 ]]; then
	# Needed to be able to run testing
	sudo apt-get install -y language-pack-en

	echo "---------------------------- TESTING -----------------------------"
	# Allow to test a system wide build
	mkdir --parents /snap/john-the-ripper/current/
	ln -s "$(realpath ../run)" /snap/john-the-ripper/current/run

	# Adjust the testing environment, import and run some testing
	wget https://raw.githubusercontent.com/claudioandre-br/JtR-CI/main/tests/disable_formats.sh
	# shellcheck source=/dev/null
	source disable_formats.sh

	wget https://raw.githubusercontent.com/openwall/john-packages/main/scripts/run_tests.sh
	# shellcheck source=/dev/null
	source run_tests.sh
fi
do_clean_package
