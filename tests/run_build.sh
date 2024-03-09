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

function do_build () {
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

function do_configure() {
    param="$1"
    shift
    # shellcheck disable=SC2086
    set -- $param "$@"
    ./configure "$@"
}

function do_release () {
    set -e

    #Create a 'john' executable
    cd ../run
    ln -s "$1" john
    cd -

    # The script that computes the package version
    wget https://raw.githubusercontent.com/openwall/john-packages/main/tests/package_version.sh
    chmod +x package_version.sh
    echo "b5fa2248661fd39d9075585077111b285cc805ac10bc3157880d270951e007a4  ./package_version.sh" | sha256sum -c - || exit 1

    # Save information about how the binaries were built
    cat <<-EOF > ../run/Defaults
#   File that lists how the build (binaries) were made
[Build Configuration]
System Wide Build=No
Architecture="$(uname -m)"
OpenMP=No
OpenCL=Yes
Optional Libraries=Yes
Regex, OpenMPI, Experimental Code, ZTEX=No
Version="$(./package_version.sh)"
EOF

    set +e
}
