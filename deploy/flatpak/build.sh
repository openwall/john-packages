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
TEST=';full;extra;' # Controls how the test will happen
arch=$(uname -m)
JTR_BIN='/app/bin/john'
JTR_CL="$JTR_BIN"

# Build options (system wide, disable checks, etc.)
SYSTEM_WIDE='--with-systemwide'
X86_REGULAR="--disable-native-tests $SYSTEM_WIDE"
X86_NO_OPENMP="--disable-native-tests $SYSTEM_WIDE --disable-openmp"

OTHER_REGULAR="$SYSTEM_WIDE"
OTHER_NO_OPENMP="$SYSTEM_WIDE --disable-openmp"

# Show environmen information
source ../show_info.sh

# Build helper
source ../run_build.sh

if [[ -z "$TASK" ]]; then
    # The script that computes the package version
    echo -n "Flatpak Commit "
    source ../package_version.sh

    echo ""
    echo "---------------------------- BUILDING -----------------------------"

    if [[ "$arch" == "x86_64" ]]; then
        # x86_64 CPU (OMP and SIMD fallback)
        ./configure $X86_NO_OPENMP --enable-simd=sse2   CPPFLAGS="-D_BOXED" && do_build ../run/john-sse2
        ./configure $X86_REGULAR   --enable-simd=sse2   CPPFLAGS="-D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-sse2\\\"\"" && do_build ../run/john-sse2-omp
        ./configure $X86_NO_OPENMP --enable-simd=avx    CPPFLAGS="-D_BOXED" && do_build ../run/john-avx
        ./configure $X86_REGULAR   --enable-simd=avx    CPPFLAGS="-D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx\\\"\" -DCPU_FALLBACK_BINARY=\"\\\"john-sse2-omp\\\"\"" && do_build ../run/john-avx-omp
        ./configure $X86_NO_OPENMP --enable-simd=avx2   CPPFLAGS="-D_BOXED" && do_build ../run/john-avx2
        ./configure $X86_REGULAR   --enable-simd=avx2   CPPFLAGS="-D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx2\\\"\" -DCPU_FALLBACK_BINARY=\"\\\"john-avx-omp\\\"\"" && do_build ../run/john-avx2-omp
        ./configure $X86_NO_OPENMP --enable-simd=avx512f  CPPFLAGS="-D_BOXED" && do_build ../run/john-avx512f
        ./configure $X86_REGULAR   --enable-simd=avx512f  CPPFLAGS="-D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx512f\\\"\" -DCPU_FALLBACK_BINARY=\"\\\"john-avx2-omp\\\"\"" && do_build ../run/john-avx512f-omp
        ./configure $X86_NO_OPENMP --enable-simd=avx512bw CPPFLAGS="-D_BOXED" && do_build ../run/john-avx512bw
        ./configure $X86_REGULAR   --enable-simd=avx512bw CPPFLAGS="-D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx512bw\\\"\" -DCPU_FALLBACK_BINARY=\"\\\"john-avx512f-omp\\\"\"" && do_build ../run/john-avx512bw-omp

        #Create a 'john' executable
        (
            cd ../run
            ln -s john-avx512bw-omp john
        )
    else
        # Non X86 CPU (OMP fallback)
        ./configure $OTHER_NO_OPENMP   CPPFLAGS="-D_BOXED" && do_build "../run/john-$arch"
        ./configure $OTHER_REGULAR     CPPFLAGS="-D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-$arch\\\"\"" && do_build ../run/john-omp

        #Create a 'john' executable
        (
            cd ../run
            ln -s john-omp john
        )
    fi
    # Save information about how the binaries were built
    echo "[Build Configuration]" > ../run/Defaults
    echo "System Wide Build=Yes" >> ../run/Defaults
    echo "Architecture=$arch" >> ../run/Defaults
    echo "OpenMP, OpenCL=No" >> ../run/Defaults
    echo "Optional Libraries=Yes" >> ../run/Defaults
    echo "Regex, OpenMPI, Experimental Code, ZTEX=No" >> ../run/Defaults
    echo "Version=$(../package_version.sh)" >> ../run/Defaults

elif [[ "$TASK" == "test" ]]; then
    # "---------------------------- TESTING -----------------------------"

    # Adjust the testing environment, import and run some testing
    source ../disable_formats.sh

    source ../run_tests.sh
fi
source ../clean_package.sh
