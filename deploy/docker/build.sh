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
# Script to automate the build of John the Ripper Docker image
# More info at https://github.com/openwall/john-packages

function install_nvidia_opencl() {
    apt-get install -y --no-install-recommends \
        nvidia-opencl-dev=*
}

function save_build_info() {
    (
    cd john || exit 1

    # Get the script that computes the package version
    wget https://raw.githubusercontent.com/openwall/john-packages/release/tests/package_version.sh
    chmod +x package_version.sh
    echo "b05ee923655f8597fe5c4266b85e450ba6cea4bf0b1922e33742032faeb6e8ed  ./package_version.sh" | sha256sum -c - || exit 1

    cat <<-EOF > run/Defaults
#   File that lists how the build (binaries) were made
[Build Configuration]
System Wide Build=Yes
Architecture="$(uname -m)"
OpenMP=No
OpenCL=Yes
Optional Libraries=Yes
Regex, OpenMPI, Experimental Code, ZTEX=No
Version="$(./package_version.sh)"
EOF

    rm -f package_version.sh
    )
}

function clean_image() {
    (
    cd john || exit 1
    wget https://raw.githubusercontent.com/openwall/john-packages/main/tests/clean_package.sh
    # shellcheck source=/dev/null
    source clean_package.sh

    rm -f clean_package.sh
    )
}

echo "Release $RELEASE"
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
    libbz2-dev=* wget=* git=* libusb-1.0-0-dev=* ca-certificates=*

if [ "$type" == "ALL" ] || [ "$type" == "GPU"  ] ; then
    install_nvidia_opencl
fi

# Build helper
wget https://raw.githubusercontent.com/openwall/john-packages/main/tests/run_build.sh
# shellcheck source=/dev/null
source run_build.sh

# Get upstream source code
git clone --depth 10 https://github.com/openwall/john.git

# Make it a reproducible build
if [ "$RELEASE" == "true" ] ; then
    (
    cd john || exit 1
    git checkout "$COMMIT"
    )
fi

(
cd john/src || exit 1

if [ "$arch" == "x86_64" ]; then
    # x86_64 CPU (OMP and SIMD binaries)
    do_configure "$X86_NO_OPENMP" --enable-simd=sse2     && do_build ../run/john-sse2
    do_configure "$X86_REGULAR"   --enable-simd=sse2     && do_build ../run/john-sse2-omp
    do_configure "$X86_NO_OPENMP" --enable-simd=avx      && do_build ../run/john-avx
    do_configure "$X86_REGULAR"   --enable-simd=avx      && do_build ../run/john-avx-omp
    do_configure "$X86_NO_OPENMP" --enable-simd=avx2     && do_build ../run/john-avx2
    do_configure "$X86_REGULAR"   --enable-simd=avx2     && do_build ../run/john-avx2-omp
    do_configure "$X86_NO_OPENMP" --enable-simd=avx512f  && do_build ../run/john-avx512f
    do_configure "$X86_REGULAR"   --enable-simd=avx512f  && do_build ../run/john-avx512f-omp
    do_configure "$X86_NO_OPENMP" --enable-simd=avx512bw && do_build ../run/john-avx512bw
    do_configure "$X86_REGULAR"   --enable-simd=avx512bw && do_build ../run/john-avx512bw-omp
else
    # Non X86 CPU (OMP fallback)
    do_configure "$OTHER_NO_OPENMP"                      && do_build "../run/john-$arch"
    do_configure "$OTHER_REGULAR"                        && do_build ../run/john-omp
fi
)

save_build_info
clean_image
