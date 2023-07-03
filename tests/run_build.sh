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

#########################################################################
# Runs a build and change the file name
#
#########################################################################

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
    echo "flags: $MAKE_FLAGS"

    if [[ -n "$1" ]]; then
        $MAKE -s clean && $MAKE "$MAKE_FLAGS" && mv ../run/john "$1"
    else
        $MAKE -s clean && $MAKE "$MAKE_FLAGS"
    fi
    set +e
}

function do_configure() {
  # shellcheck disable=SC2068
  set -- $@
  ./configure "$@"
}
