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

echo "Release $RELEASE"
arch=$(uname -m)

# Install build dependencies
apt-get update -qq
export DEBIAN_FRONTEND="noninteractive"
apt-get install -y --no-install-recommends \
    build-essential=* libssl-dev=* zlib1g-dev=* yasm=* libgmp-dev=* libpcap-dev=* pkg-config=* \
    libbz2-dev=* wget=* git=* libusb-1.0-0-dev=* ca-certificates=*

# Get the script that computes the package version
wget https://raw.githubusercontent.com/claudioandre-br/JtR-CI/master/tests/package_version.sh
chmod +x package_version.sh

# ==================================================================
# Build John the Ripper
# ------------------------------------------------------------------
git clone --depth 10 https://github.com/openwall/john.git

# Make it a reproducible build
if [ "$RELEASE" = "true" ] ; then (cd john || true; git checkout "$COMMIT"); fi
(
    cd john/src || true
    ./configure --disable-native-tests --with-systemwide --disable-openmp --enable-simd=sse2   && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-sse2
    ./configure --disable-native-tests --with-systemwide                  --enable-simd=sse2   && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-sse2-omp
    ./configure --disable-native-tests --with-systemwide --disable-openmp --enable-simd=avx    && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx
    ./configure --disable-native-tests --with-systemwide                  --enable-simd=avx    && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx-omp
    ./configure --disable-native-tests --with-systemwide --disable-openmp --enable-simd=avx2   && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx2
    ./configure --disable-native-tests --with-systemwide                  --enable-simd=avx2   && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx2-omp
    ./configure --disable-native-tests --with-systemwide --disable-openmp --enable-simd=avx512f  && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx512f
    ./configure --disable-native-tests --with-systemwide                  --enable-simd=avx512f  && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx512f-omp
    ./configure --disable-native-tests --with-systemwide --disable-openmp --enable-simd=avx512bw && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx512bw
    ./configure --disable-native-tests --with-systemwide                  --enable-simd=avx512bw && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx512bw-omp
)

# Clean the image
(
    cd john || true
    rm -rf src .git .ci .circleci .azure .editorconfig .gitattributes .github .gitignore .mailmap .pre-commit.sh .travis .travis.yml && rm -rf run/ztex
)

# Save information about how the binaries were built
cat <<-EOF > john/run/Defaults
#   File that lists how the build (binaries) were made
[Build Configuration]
System Wide Build=Yes
Architecture="$arch"
OpenMP, OpenCL=No
Optional Libraries=Yes
Regex, OpenMPI, Experimental Code, ZTEX=No
Version="$(../package_version.sh)"
EOF

