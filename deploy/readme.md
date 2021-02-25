# Deployments

We use premium build providers like Azure Cloud, Launchpad, and GitLab.

![Donation](https://img.shields.io/badge/Donate-Yes-brightgreen?style=flat&logo=github-sponsors) Please donate. You can make a real difference and help our work by donating to support the infra.

## John the Ripper 1.9.0 Jumbo 2 release build environments

#### Docker Image

- gcc 7.5.0-3ubuntu1~18.04

```text
docker image ubuntu:18.04
sha256:ea188fdc5be9b25ca048f1e882b33f1bc763fb976a8a4fea446b38ed0efcbeba
```

#### Flatpak

- gcc (GCC) 8.3.0

```text
docker image claudioandre/john:fedora.32.flatpak
sha256:b031ea0904dffbbf18aeed943ac1ef7cf6f29a193b747448a4e609a
VERSION="18.08.39 (Flatpak runtime)"
```

#### Snap

- gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0

```text
DISTRIB_DESCRIPTION="Ubuntu 18.04.5 LTS"
snapcraft 4.5.1 from Canonical* installed
Setting up snapd (2.48.3+18.04)
```

#### Windows

- gcc (GCC) 10.2.0

```text
OS Name:                   Microsoft Windows Server 2016 Datacenter
OS Version:                10.0.14393 N/A Build 14393
ImageVersion                   20210209.1
Chocolatey v0.10.15
Cygwin 3.1.7
```
