# Deployments

We use premium build providers like Azure Cloud, Launchpad, and GitLab.

![Donation](https://img.shields.io/badge/Donate-Yes-brightgreen?style=flat&logo=github-sponsors) Please donate. You can make a real difference and help our work by donating to support the infra.

## Release Process

![Release Process](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggVERcbiAgICBBW1BhY2thZ2luZ10gLS0-fElzIENJIG9rP3wgQig8YnI-TWFudWFsIFN0YXJ0dXA8YnI-Li4uKVxuICAgIEIgLS0-IEIxW0dldCBTb3VyY2UgQ29kZTxicj5Gcm9tIFVwc3RyZWFtXVxuICAgIEIxIC0tPiBDe1Byb3ZpZGVyc31cbiAgICBDIC0tPnxHaXRMYWIgQ0l8IERbZmE6ZmEtZGVza3RvcCA8YnI-RmxhdFBha11cbiAgICBDIC0tPnxMYXVuY2hwYWR8IEVbZmE6ZmEtZGVza3RvcCA8YnI-U25hcF1cbiAgICBDIC0tPnxUcmF2aXMgQ0l8IEZbZmE6ZmEtZGVza3RvcCA8YnI-RG9ja2VyPGJyPlBhY2thZ2VdXG4gICAgQyAtLT58QXBwVmV5b3IgQ0l8IEdbZmE6ZmEtZGVza3RvcCA8YnI-V2luZG93czxicj4zMmJpdF1cbiAgICBDIC0tPnxBenVyZSBEZXZPUFN8IEhbZmE6ZmEtZGVza3RvcCA8YnI-V2luZG93czxicj42NGJpdF1cbiIsIm1lcm1haWQiOnt9LCJ1cGRhdGVFZGl0b3IiOmZhbHNlfQ)

## John the Ripper rolling 2210 (1.9.0 Jumbo 1+) release build environments

#### Docker Image

- gcc version: 9.4.0

```text
docker image ubuntu:20.04
sha256:9300e6e6433ce2313d96fcbd8c6957f778703ce260f9d4e087b921b0840d94ad
```

#### Flatpak

- gcc version: 11.3.0

```text
docker image ghcr.io/claudioandre-br/john-ci:fedora.35.flatpak
sha256:a1b5e8225c1bdeec090d1f63f6d505b012ea5de33c12f06f046470f54ef6c990
VERSION="21.08.14 (Flatpak runtime)"
```

#### Snap

- gcc version: 7.5.0

```text
DISTRIB_DESCRIPTION="Ubuntu 18.04.6 LTS"
snapcraft 7.1.3 from Canonical* installed
Setting up snapd (2.55.5+18.04)
```

#### Windows

- gcc (GCC) 11.3.0

```text
OS Name:                   Microsoft Windows Server 2019 Datacenter
OS Version:                10.0.17763 N/A Build 17763
ImageVersion                   20220925.1
Chocolatey v1.1.0
Cygwin 3.3.6
```
