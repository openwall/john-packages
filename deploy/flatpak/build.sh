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
# Script to automate the build of John the Ripper flatpak
# More info at https://github.com/openwall/john-packages

# Required defines
arch=$(uname -m)
DEPLOY_PAK="No"
FLATPAK_BUILD=1
BASE="Flatpak SDK"
TASK_RUNNING="Flatpak build"
export -p DEPLOY_PAK FLATPAK_BUILD BASE TASK_RUNNING

# Build options (system wide, disable checks, etc.)
SYSTEM_WIDE='--with-systemwide --disable-opencl'
X86_REGULAR="--disable-native-tests $SYSTEM_WIDE"
X86_NO_OPENMP="--disable-native-tests $SYSTEM_WIDE --disable-openmp"

OTHER_REGULAR="$SYSTEM_WIDE"
OTHER_NO_OPENMP="$SYSTEM_WIDE --disable-openmp"

# shellcheck source=/dev/null
source ../helper.sh

do_get_version

echo ""
echo "---------------------------- BUILDING -----------------------------"

if [[ "$arch" == "x86_64" ]]; then
	# x86_64 CPU (OMP and SIMD fallback)
	do_configure "$X86_NO_OPENMP" --enable-simd=avx CPPFLAGS="-D_BOXED" && do_build ../run/john-avx
	do_configure "$X86_REGULAR" --enable-simd=avx CPPFLAGS="-D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx\\\"\" " && do_build ../run/john-avx-omp
	do_configure "$X86_NO_OPENMP" --enable-simd=avx2 CPPFLAGS="-D_BOXED" && do_build ../run/john-avx2
	do_configure "$X86_REGULAR" --enable-simd=avx2 CPPFLAGS="-D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx2\\\"\" -DCPU_FALLBACK_BINARY=\"\\\"john-avx-omp\\\"\"" && do_build ../run/john-avx2-omp
	do_configure "$X86_NO_OPENMP" --enable-simd=avx512f CPPFLAGS="-D_BOXED" && do_build ../run/john-avx512f
	do_configure "$X86_REGULAR" --enable-simd=avx512f CPPFLAGS="-D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx512f\\\"\" -DCPU_FALLBACK_BINARY=\"\\\"john-avx2-omp\\\"\"" && do_build ../run/john-avx512f-omp
	do_configure "$X86_NO_OPENMP" --enable-simd=avx512bw CPPFLAGS="-D_BOXED" && do_build ../run/john-avx512bw
	do_configure "$X86_REGULAR" --enable-simd=avx512bw CPPFLAGS="-D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx512bw\\\"\" -DCPU_FALLBACK_BINARY=\"\\\"john-avx512f-omp\\\"\"" && do_build ../run/john-avx512bw-omp
	BINARY="john-avx512bw-omp"
else
	# Non X86 CPU (OMP fallback)
	do_configure "$OTHER_NO_OPENMP" CPPFLAGS="-D_BOXED" && do_build "../run/john-$arch"
	do_configure "$OTHER_REGULAR" CPPFLAGS="-D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-$arch\\\"\"" && do_build ../run/john-omp
	BINARY="john-omp"
fi
do_release "Yes" "No" "$BINARY" # --system-wide, --support-opencl, --binary-name
do_clean_package
