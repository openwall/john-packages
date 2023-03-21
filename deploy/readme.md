# Deployments

We use premium build providers like Azure Cloud, Launchpad, and GitLab.

![Donation](https://img.shields.io/badge/Donate-Yes-brightgreen?style=flat&logo=github-sponsors) Please donate. You can make a real difference and help our work by donating to support the infra.

## Release Process

![Release Process](https://mermaid.ink/img/pako:eNptkV1LwzAUhv_KIVcK22AgXhSZbK37gImFKl6svThNzrrQNilpMtF1_91080KluXpJ3uc8cHJiXAtiASsMNgd4jVIF_sx3MfISC6mKDMbjWbdpIdyALh87WNw85Gb2jMphBYlFY13T30wmk9srvegRWEx3K7KQaGc4Qeg1fWtpdA1vTWsNYZ399KcXIDzFRh-lINOerw_hxb2Sdou593cQ7fYY7HEsqC2tbuAysUIbY5n9RrboFD80KDp4GkAShU32T7F2Ocy5lVq1HSwHoEjzkkyfNjUW9IeffzlDENHxJU46WA_Q71IJ_dH28f4ulzZjI1aTqVEKv_1TPyxl9kA1pSzwUdAeXWVTlqqzr6KzOvlUnAXWOBox1wi0FEn0_1YzL6taOn8DO1uWKQ?type=png)

## John the Ripper rolling (1.9.0 Jumbo 1+) release build environments

#### Docker Image

- gcc version: 12.2.0

```text
docker image ubuntu:22.04
sha256:b360d85af0582af0c4600f79b07c5f26de432af3fb4e52b6aa302ff6c9a62d4b
```

#### Flatpak

- gcc version: 11.3.0

```text
docker image ghcr.io/claudioandre-br/john-ci:fedora.37.flatpak
sha256:30c286f6f37b72d7d4e4deff3e04bcb2255dbc03cc5951d408a341903ba1a167
VERSION="22.08 (Flatpak runtime)"
```

#### Snap

- gcc version: 7.5.0

```text
DISTRIB_DESCRIPTION="Ubuntu 18.04.6 LTS"
snapcraft (7.x/stable) 7.3.1 from Canonical** installed
Setting up snapd (2.58+18.04)
```

#### Windows

- gcc (GCC) 11.3.0

```text
OS Name:                   Microsoft Windows Server 2019 Datacenter
OS Version:                10.0.17763 N/A Build 17763
Current image version: '20230326.1'
Chocolatey v1.3.1
Cygwin 3.4.6
```
