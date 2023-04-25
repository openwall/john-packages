# Deployments

We use premium build providers like Azure Cloud, Launchpad, and GitLab.

![Donation](https://img.shields.io/badge/Donate-Yes-brightgreen?style=flat&logo=github-sponsors) Please donate. You can make a real difference and help our work by donating to support the infra.

## Release Process

![Release Process](https://mermaid.ink/img/pako:eNp9km1r2zAQx7_KoVcrNCmBUkowHondh7CEhXljgzgvztYlEbYlIUvdQ5zvXskpZS2mevWXdL_7n053ZKXixKZsb1Af4HuaS_BrtlljWeFeyP0WRqO4W7SQLEBVnzuYf4oKE69QOqwhs2is0-FkPB5fnOl5QGA-2TyQhUw5UxIk3iZE3RvVwA_dWkPYbF_iJz2QHNdGPQlOpj2dL5Le-0HYJRbev4N0s8PpDkec2soqDX3GGu0aq-3_yBKdLA8aeQd3A0gmUW_fWTy6AmalFUq2HdwPQKkqKzJBLRrc0xt-9s8ZgpSevq6zDh4H6J9CcvW7DfLmuhD2DU5_NBnRkLRYh4i5sEa0BCtViPqcV_uqvgzknUlulOC9_LYCgl-3N2ETiThysVSg-4-k6MrF0ZWIP_RNhClrCo1eDnVN1ejLgslkfP36jg-92CVryDQouJ-wY3DOmT1QQzmbeslph662OcvlyYeisyr7K0s2tcbRJXOao6VUoJ_Nhvlq6pZOz8BT4jk?type=png)

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
