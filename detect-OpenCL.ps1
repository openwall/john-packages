######################################################################
# Copyright (c) 2023 Claudio André <claudioandre.br at gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
######################################################################
# Maybe use -Force in the command line commands?

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
