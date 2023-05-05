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
# Script to automate the detection of OpenCL on Windows
# More info at https://github.com/openwall/john-packages

# Maybe use -Force in the command line commands below?
$vendor=$args[0]

if ($vendor -ieq "amd") {
  Get-Childitem -Path c:\Windows\System32 -Include amdocl64.dll -File -Recurse -ErrorAction SilentlyContinue | %{$_.FullName} | Out-File -NoNewline -encoding ascii -FilePath etc\OpenCL\vendors\AMD-found.icd
} elseif ($vendor -ieq "intel") {
  Get-Childitem -Path c:\Windows\System32 -Include IntelOpenCL64.dll -File -Recurse -ErrorAction SilentlyContinue | %{$_.FullName} | Out-File -NoNewline -encoding ascii -FilePath etc\OpenCL\vendors\Intel-found.icd
} elseif ($vendor -ieq "nvidia") {
  Get-Childitem -Path c:\Windows\System32 -Include nvopencl.dll -File -Recurse -ErrorAction SilentlyContinue | %{$_.FullName} | Out-File -NoNewline -encoding ascii -FilePath etc\OpenCL\vendors\Nvidia-found.icd
} else {
  Write-Output "Invalid command line parameters."
}
