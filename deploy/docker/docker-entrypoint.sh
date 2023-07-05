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
# Script that serves as the entrypoint for the Docker image of john the ripper
# More info at https://github.com/openwall/john-packages

set -e
echo "$@"
ids="sse2-omp sse2 avx-omp avx xop-omp xop avx2-omp avx2
          avx512f-omp avx512f avx512bw-omp avx512bw
          ztex-omp ztex best
          "
binaries="/john/run/john-avx512bw-omp /john/run/john-avx512f-omp /john/run/john-avx2-omp
          /john/run/john-xop-omp /john/run/john-avx-omp /john/run/john-sse2-omp
          "
requested="$1"

# If a valid ID was requested.
if [[ $# -gt 0 && "$ids" == *"$requested"* ]]; then
    shift
fi

if [[ "$requested" = 'sse2-omp' || "$requested" = 'sse2' ]]; then
    exec "/john/run/john-$requested" "$@"
elif [[ "$requested" = 'avx-omp' || "$requested" = 'avx' || "$requested" = 'avx2-omp' || "$requested" = 'avx2' ]]; then
    exec "/john/run/john-$requested" "$@"
elif [[ "$requested" = 'xop-omp' || "$requested" = 'xop' ]]; then
    exec "/john/run/john-$requested" "$@"
elif [[ "$requested" = 'avx512f-omp'  || "$requested" = 'avx512f'  || "$requested" = 'avx512bw-omp'  || "$requested" = 'avx512bw' ]]; then
    exec "/john/run/john-$requested" "$@"
elif [[ "$requested" = 'ztex-omp' || "$requested" = 'ztex' ]]; then
    echo "Binary /john/run/john-$requested  disabled (please, open a bug report)"
elif [[ "$requested" = 'best' ]]; then

    for john in $binaries; do
        if $john | grep -q ^Usage:; then
            echo "Will use $john"
            exec $john "$@"
            exit
        fi
    done
    echo 'No suitable john binary found'
else
    if [[ -f /john/run/john-sse2-omp ]]; then
        exec /john/run/john-sse2-omp "$@"
    else
        exec /john/run/john-avx2-omp "$@"
    fi
fi
message='### See you soon! ###'
printf "%*s\n" $(((${#message} + $(tput cols)) / 2)) "$message"
