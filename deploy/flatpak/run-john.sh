#!/bin/bash

# Copyright (c) 2019-2024 Claudio André <dev at claudioandre.slmail.me>

# shellcheck disable=SC2034,SC2162
john --list=build-info; printf "%s " "Press enter to continue..."; read ans
