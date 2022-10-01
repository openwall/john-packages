#!/bin/bash

######################################################################
# Copyright (c) 2019 Claudio André <claudioandre.br at gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
######################################################################

# Required defines
TEST=';full;extra;' # Controls how the test will happen
arch=$(uname -m)
JTR_BIN='../run/john'
JTR_CL="$JTR_BIN"

# Build options (system wide, disable checks, etc.)
SYSTEM_WIDE='--with-systemwide'
X86_REGULAR="--disable-native-tests $SYSTEM_WIDE"
X86_NO_OPENMP="--disable-native-tests $SYSTEM_WIDE --disable-openmp"

OTHER_REGULAR="$SYSTEM_WIDE"
OTHER_NO_OPENMP="$SYSTEM_WIDE --disable-openmp"

# Get JtR source code and adjust it to create a SNAP package
git clone --depth 10 https://github.com/openwall/john.git tmp
cp -r tmp/. .

# We are in packages folder, change to JtR folder
cd src

# Uncomment for a release
#_JUMBO_RELEASE="8998390b651f4a7e744758a1c41eb3068dc5084f"

# Make it a reproducible build
if [[ -n "$_JUMBO_RELEASE" ]]; then
    echo "Deploying the release $_JUMBO_RELEASE"
    git pull --unshallow
    git checkout "$_JUMBO_RELEASE"
fi

wget https://raw.githubusercontent.com/openwall/john-packages/master/patches/0001-Handle-self-confined-system-wide-build.patch
patch < 0001-Handle-self-confined-system-wide-build.patch

wget https://raw.githubusercontent.com/claudioandre-br/JohnTheRipper/bleeding-jumbo/be.patch; _BE_TEST=$?

if [[ "$_BE_TEST" == 0 ]]; then
    echo "Applying a patch be.patch from claudioandre-br/JohnTheRipper/bleeding-jumbo"
    git apply be.patch
fi

# Set package version
git rev-parse --short HEAD 2>/dev/null > ../../../../My_VERSION.TXT

# Force CFLAGS with -O2
export CFLAGS="-O2 $CFLAGS"

# Show environmen information
wget https://raw.githubusercontent.com/claudioandre-br/JtR-CI/master/tests/show_info.sh
source show_info.sh

# Build helper
wget https://raw.githubusercontent.com/claudioandre-br/JtR-CI/master/tests/run_build.sh
source run_build.sh

echo ""
echo "---------------------------- BUILDING -----------------------------"

if [[ "$arch" == "x86_64" || "$arch" == "i686" ]]; then
    # Workaround (WTF)
    sudo ln -s /usr/lib/x86_64-linux-gnu/libOpenCL.so.1 /usr/lib/x86_64-linux-gnu/libOpenCL.so

    # CPU (OMP and extensions fallback)
    ./configure $X86_NO_OPENMP --enable-simd=sse2   CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-sse2-non-omp
    ./configure $X86_REGULAR   --enable-simd=sse2   CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK -DOMP_FALLBACK_BINARY=\"\\\"john-sse2-non-omp\\\"\"" && do_build ../run/john-sse2
    ./configure $X86_NO_OPENMP --enable-simd=sse4.1 CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-sse4-non-omp
    ./configure $X86_REGULAR   --enable-simd=sse4.1 CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK -DOMP_FALLBACK_BINARY=\"\\\"john-sse4-non-omp\\\"\" -DCPU_FALLBACK -DCPU_FALLBACK_BINARY=\"\\\"john-sse2\\\"\"" && do_build ../run/john-sse4
    ./configure $X86_NO_OPENMP --enable-simd=avx    CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-avx-non-omp
    ./configure $X86_REGULAR   --enable-simd=avx    CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK -DOMP_FALLBACK_BINARY=\"\\\"john-avx-non-omp\\\"\" -DCPU_FALLBACK -DCPU_FALLBACK_BINARY=\"\\\"john-sse4\\\"\"" && do_build ../run/john-avx
    ./configure $X86_NO_OPENMP --enable-simd=xop    CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-xop-non-omp
    ./configure $X86_REGULAR   --enable-simd=xop    CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK -DOMP_FALLBACK_BINARY=\"\\\"john-xop-non-omp\\\"\" -DCPU_FALLBACK -DCPU_FALLBACK_BINARY=\"\\\"john-avx\\\"\"" && do_build ../run/john-xop
    ./configure $X86_NO_OPENMP --enable-simd=avx2   CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-non-omp
    ./configure $X86_REGULAR   --enable-simd=avx2   CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK -DOMP_FALLBACK_BINARY=\"\\\"john-non-omp\\\"\" -DCPU_FALLBACK -DCPU_FALLBACK_BINARY=\"\\\"john-xop\\\"\"" && do_build ../run/john-avx2

    if [[ "$arch" == "x86_64" ]]; then
        ./configure $X86_NO_OPENMP --enable-simd=avx512f  CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-avx512f-non-omp
        ./configure $X86_REGULAR   --enable-simd=avx512f  CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK -DOMP_FALLBACK_BINARY=\"\\\"john-avx512f-non-omp\\\"\" -DCPU_FALLBACK -DCPU_FALLBACK_BINARY=\"\\\"john-avx2\\\"\"" && do_build ../run/john-avx512f
        ./configure $X86_NO_OPENMP --enable-simd=avx512bw CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-avx512bw-non-omp
        ./configure $X86_REGULAR   --enable-simd=avx512bw CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK -DOMP_FALLBACK_BINARY=\"\\\"john-avx512bw-non-omp\\\"\" -DCPU_FALLBACK -DCPU_FALLBACK_BINARY=\"\\\"john-avx512f\\\"\"" && do_build
    else
        mv ../run/john-avx2 ../run/john
    fi

else
    # Non X86 CPU
    ./configure $OTHER_NO_OPENMP   CPPFLAGS="-D_SNAP -D_BOXED" && do_build ../run/john-non-omp
    ./configure $OTHER_REGULAR     CPPFLAGS="-D_SNAP -D_BOXED -DOMP_FALLBACK -DOMP_FALLBACK_BINARY=\"\\\"john-non-omp\\\"\"" && do_build
fi

# To be able to run testing
sudo apt-get install -y language-pack-en

# "---------------------------- TESTING -----------------------------"
# Allow to test a system wide build
mkdir --parents /snap/john-the-ripper/current/
ln -s $(realpath ../run) /snap/john-the-ripper/current/run

# Adjust the testing environment, import and run some testing
wget https://raw.githubusercontent.com/claudioandre-br/JtR-CI/master/tests/disable_formats.sh
source disable_formats.sh

wget https://raw.githubusercontent.com/claudioandre-br/JtR-CI/master/tests/run_tests.sh
source run_tests.sh

wget https://raw.githubusercontent.com/claudioandre-br/JtR-CI/master/tests/clean_package.sh
source clean_package.sh

# Get the script that computes the package version
wget https://raw.githubusercontent.com/claudioandre-br/JtR-CI/master/tests/package_version.sh
chmod +x package_version.sh
cp package_version.sh ../../../../package_version.sh
