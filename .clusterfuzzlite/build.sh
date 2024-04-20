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
# Copyright (c) 2023 Claudio André <claudioandre.br at gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
###############################################################################
# Script for building John the Ripper (for fuzzing)
# More info at https://github.com/openwall/john-packages

cd /upstream/src || exit 1

# shellcheck source=/dev/null
source ../helper.sh

if [[ "$SANITIZER" == "address" ]]; then
	# Asan
	./configure --enable-asan
	make -sj4

	cp ../run/john "$OUT"/

	echo "------------------ Disable problematic formats -------------------"
	echo '[Local:Disabled:Formats]' >>../run/john-local.conf
	echo 'crypt = Y' >>../run/john-local.conf

	echo "-------------------------- ASAN fuzzing --------------------------"
	echo "$ JtR ASAN --test=0"
	../run/john --test=0
fi

if [[ "$SANITIZER" == "undefined" ]]; then
	# Ubsan
	./configure --enable-ubsan
	make -sj4

	echo "------------------------- UBSAN fuzzing --------------------------"
	echo "$ JtR UBSAN --test=0"
	../run/john --test=0
fi

#                                   ##########
# This task targets libFuzzer fuzz, but libFuzzer is broken upstream;
# To use libFuzzer properly, we should do something like this (for each fuzz target).
#
# ./configure --enable-libfuzzer
# make clean && make wpapcap2john # && ./wpapcap2john => just copy to $OUT
# => the execution is done by the action itself.
