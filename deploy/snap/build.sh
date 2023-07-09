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
# Script to automate the build of John the Ripper snap
# More info at https://github.com/openwall/john-packages

function save_build_info() {
    (
    cd .. || true

    # Get the script that computes the package version
    wget https://raw.githubusercontent.com/openwall/john-packages/main/tests/package_version.sh
    chmod +x package_version.sh

    cat <<-EOF > run/Defaults
#   File that lists how the build (binaries) were made
[Build Configuration]
System Wide Build=Yes
Architecture="$(uname -m)"
OpenMP=No
OpenCL=Yes # ONLY on x86_64, otherwise No
Optional Libraries=Yes
Regex, OpenMPI, Experimental Code, ZTEX=No
Version="$(./package_version.sh)"
EOF

    rm -f package_version.sh
    )
}

function clean_image() {
    (
    cd .. || true
    wget https://raw.githubusercontent.com/openwall/john-packages/main/tests/clean_package.sh
    # shellcheck source=/dev/null
    source clean_package.sh

    rm -f clean_package.sh
    )
}

# Required defines
TEST=';full;extra;' # Controls how the test will happen
arch=$(uname -m)
JTR_BIN='../run/john'
JTR_CL="$JTR_BIN"
export TEST
export JTR_CL

# Build options (system wide, disable checks, etc.)
SYSTEM_WIDE='--with-systemwide'
X86_REGULAR="--disable-native-tests $SYSTEM_WIDE"
X86_NO_OPENMP="--disable-native-tests $SYSTEM_WIDE --disable-openmp"

OTHER_REGULAR="$SYSTEM_WIDE"
OTHER_NO_OPENMP="$SYSTEM_WIDE --disable-openmp"

if [[ "$1" == "PULL" ]]; then
    # Get JtR source code and adjust it to create a SNAP package
    rm -rf tmp
    git clone --depth 10 https://github.com/openwall/john.git tmp
    cp -r tmp/. .

    # Uncomment for a release
    #RELEASE="15b3b7c25fc8ac34f2504d53f0c94bbf4ec12596"

    # Make it a reproducible build
    if [[ -n "$RELEASE" ]]; then
        echo "Deploying the release $RELEASE"
        git pull --unshallow
        git checkout "$RELEASE"
    fi

    # Get the script that computes the package version
    wget https://raw.githubusercontent.com/openwall/john-packages/main/tests/package_version.sh
    chmod +x package_version.sh
    cp package_version.sh ../../../package_version.sh

    exit 0
fi

# We are in packages folder, change to JtR folder
cd src || true

wget https://raw.githubusercontent.com/openwall/john-packages/master/patches/0001-Handle-self-confined-system-wide-build.patch
patch < 0001-Handle-self-confined-system-wide-build.patch

wget https://raw.githubusercontent.com/claudioandre-br/JohnTheRipper/bleeding-jumbo/be.patch; _BE_TEST=$?

if [[ "$_BE_TEST" == 0 ]]; then
    echo "Applying a testing purpose patch called 'be.patch' from claudioandre-br/JohnTheRipper"
    git apply be.patch
fi

# Force CFLAGS with -O2
export CFLAGS="-O2 $CFLAGS"

# Show environment information
wget https://raw.githubusercontent.com/claudioandre-br/JtR-CI/master/tests/show_info.sh
# shellcheck source=/dev/null
source show_info.sh

# Build helper
wget https://raw.githubusercontent.com/openwall/john-packages/main/tests/run_build.sh
# shellcheck source=/dev/null
source run_build.sh

echo ""
echo "---------------------------- BUILDING -----------------------------"

if [[ "$arch" == "x86_64" ]]; then
    # x86_64 CPU (OMP and SIMD fallback)
    do_configure "$X86_NO_OPENMP" --enable-simd=sse2   CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-sse2
    do_configure "$X86_REGULAR"   --enable-simd=sse2   CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-sse2\\\"\"" && do_build ../run/john-sse2-omp
    do_configure "$X86_NO_OPENMP" --enable-simd=avx    CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-avx
    do_configure "$X86_REGULAR"   --enable-simd=avx    CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx\\\"\" -DCPU_FALLBACK_BINARY=\"\\\"john-sse2-omp\\\"\"" && do_build ../run/john-avx-omp
    do_configure "$X86_NO_OPENMP" --enable-simd=avx2   CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-avx2
    do_configure "$X86_REGULAR"   --enable-simd=avx2   CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx2\\\"\" -DCPU_FALLBACK_BINARY=\"\\\"john-avx-omp\\\"\"" && do_build ../run/john-avx2-omp
    do_configure "$X86_NO_OPENMP" --enable-simd=avx512f  CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-avx512f
    do_configure "$X86_REGULAR"   --enable-simd=avx512f  CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx512f\\\"\" -DCPU_FALLBACK_BINARY=\"\\\"john-avx2-omp\\\"\"" && do_build ../run/john-avx512f-omp
    do_configure "$X86_NO_OPENMP" --enable-simd=avx512bw CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-avx512bw
    do_configure "$X86_REGULAR"   --enable-simd=avx512bw CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-avx512bw\\\"\" -DCPU_FALLBACK_BINARY=\"\\\"john-avx512f-omp\\\"\"" && do_build ../run/john-avx512bw-omp

    #Create a 'john' executable
    (
        cd ../run || true
        ln -s john-avx512bw-omp john
    )
else
    # Non X86 CPU (OMP fallback)
    do_configure "$OTHER_NO_OPENMP"   CPPFLAGS="-D_SNAP -D_BOXED" && do_build "../run/john-$arch"
    do_configure "$OTHER_REGULAR"     CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK_BINARY=\"\\\"john-$arch\\\"\"" && do_build ../run/john-omp

    #Create a 'john' executable
    (
        cd ../run || true
        ln -s john-omp john
    )
fi

# To be able to run testing
sudo apt-get install -y language-pack-en

# "---------------------------- TESTING -----------------------------"
# Allow to test a system wide build
mkdir --parents /snap/john-the-ripper/current/
ln -s "$(realpath ../run)" /snap/john-the-ripper/current/run

# Adjust the testing environment, import and run some testing
wget https://raw.githubusercontent.com/claudioandre-br/JtR-CI/master/tests/disable_formats.sh
# shellcheck source=/dev/null
source disable_formats.sh

wget https://raw.githubusercontent.com/openwall/john-packages/main/tests/run_tests.sh
# shellcheck source=/dev/null
source run_tests.sh

save_build_info
clean_image
