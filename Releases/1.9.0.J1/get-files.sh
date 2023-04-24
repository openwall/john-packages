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

wget https://launchpad.net/~claudioandre.br/+snap/john-the-ripper/+build/557702/+files/buildlog_snap_ubuntu_xenial_armhf_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/+snap/john-the-ripper/+build/557699/+files/buildlog_snap_ubuntu_xenial_i386_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/+snap/john-the-ripper/+build/557703/+files/buildlog_snap_ubuntu_xenial_arm64_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/+snap/john-the-ripper/+build/557701/+files/buildlog_snap_ubuntu_xenial_amd64_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/+snap/john-the-ripper/+build/557704/+files/buildlog_snap_ubuntu_xenial_ppc64el_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/+snap/john-the-ripper/+build/557700/+files/buildlog_snap_ubuntu_xenial_powerpc_john-the-ripper_BUILDING.txt.gz
wget https://launchpad.net/~claudioandre.br/+snap/john-the-ripper/+build/557705/+files/buildlog_snap_ubuntu_xenial_s390x_john-the-ripper_BUILDING.txt.gz

wget https://ci.appveyor.com/api/buildjobs/uauet2ejqx0742d3/artifacts/win_x64.zip  -O x64_win.zip
wget https://ci.appveyor.com/api/buildjobs/uauet2ejqx0742d3/artifacts/optional.zip -O x64_optional.zip
wget https://ci.appveyor.com/api/buildjobs/uauet2ejqx0742d3/log                    -O x64_log.txt

wget https://ci.appveyor.com/api/buildjobs/dq1hp9jbkmyo0sc4/artifacts/win_x32.zip  -O x32_win.zip
wget https://ci.appveyor.com/api/buildjobs/dq1hp9jbkmyo0sc4/artifacts/optional.zip -O x32_optional.zip
wget https://ci.appveyor.com/api/buildjobs/dq1hp9jbkmyo0sc4/log                    -O x32_log.txt

wget https://gitlab.com/claudioandre-br/packages/-/jobs/212460694/artifacts/download  -O john.flatpak.zip
wget https://gitlab.com/claudioandre-br/packages/-/jobs/212460694/raw                 -O bundle_log.txt
wget https://gitlab.com/claudioandre-br/packages/-/jobs/212460695/raw                 -O bundle_test.txt

wget https://api.travis-ci.org/v3/job/532480502/log.txt    -O docker_log.txt

unzip john.flatpak.zip
sha256sum *.zip
sha256sum john.flatpak
