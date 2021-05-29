# Deployments

We use premium build providers like Azure Cloud, Launchpad, and GitLab.

![Donation](https://img.shields.io/badge/Donate-Yes-brightgreen?style=flat&logo=github-sponsors) Please donate. You can make a real difference and help our work by donating to support the infra.

## Release Process

![Release Process](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggVERcbiAgICBBW1BhY2thZ2luZ10gLS0-fElzIENJIG9rP3wgQig8YnI-TWFudWFsIFN0YXJ0dXA8YnI-Li4uKVxuICAgIEIgLS0-IEIxW0dldCBTb3VyY2UgQ29kZTxicj5Gcm9tIFVwc3RyZWFtXVxuICAgIEIxIC0tPiBDe1Byb3ZpZGVyc31cbiAgICBDIC0tPnxHaXRMYWIgQ0l8IERbZmE6ZmEtZGVza3RvcCA8YnI-RmxhdFBha11cbiAgICBDIC0tPnxMYXVuY2hwYWR8IEVbZmE6ZmEtZGVza3RvcCA8YnI-U25hcF1cbiAgICBDIC0tPnxUcmF2aXMgQ0l8IEZbZmE6ZmEtZGVza3RvcCA8YnI-RG9ja2VyPGJyPlBhY2thZ2VdXG4gICAgQyAtLT58QXBwVmV5b3IgQ0l8IEdbZmE6ZmEtZGVza3RvcCA8YnI-V2luZG93czxicj4zMmJpdF1cbiAgICBDIC0tPnxBenVyZSBEZXZPUFN8IEhbZmE6ZmEtZGVza3RvcCA8YnI-V2luZG93czxicj42NGJpdF1cbiIsIm1lcm1haWQiOnt9LCJ1cGRhdGVFZGl0b3IiOmZhbHNlfQ)

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
