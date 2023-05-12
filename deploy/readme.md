# Deployments

We use premium build providers like Azure Cloud, Launchpad, and GitLab.

![Donation](https://img.shields.io/badge/Donate-Yes-brightgreen?style=flat&logo=github-sponsors) Please donate. You can make a real difference and help our work by donating to support the infra.

At the time of this writing, `john` is known to build and work on:

* Linux (kernel 6 or later recommended)
* Android NDK r23b (on ARM and X86)
* FreeBSD (tested with 12 and later on X86)
* Solaris (tested with 11 on X86)
* Mac OS (on ARM and X86)

Also in the following Windows environments:
* Microsoft Windows (Windows 10 / Windows Server 2016 or later)
* Mingw + Wine (32-bit and 64-bit), using an ancient Fedora Docker image
* Cygwin

## Release Process

![Release Process](https://mermaid.ink/img/pako:eNqFk29vmzAQxr_Kya82qaGKVFVThJgSWNuoZUFjVSeFvDjgQizARsbOtoZ89xlSbUuENl492Pe75_7AgWUyJzZjhcJmB1-DRIB95usIsxILLooNTCZet2zBX4IsP3aweOemygtRGKwg1qi0afoTx3Hen-hFj8Biur4nDbE0KiPwrU0fdadkDc9NqxVhvXmLnw6Af4iU3POcVHs8XfiD9z3XT5ha_w6C9RZnW5zk1JZaNjBkrFBHWG7-Rp7QiGzXYN7BpxEkFthsLiweTArzTHMp2g7uRqBAZiWpXi1rLOiMn78aRRDQfhXFHTyM0C9c5PJ728vbm5TrP7jj2N47LvbUal5gX0EHj2v60ZDiNQmN1Vvw4-C14FrxliCUKa9Opo0tORwxnYtcSZ4P8ksIBN8-3PYvLvdc4wkJzbBlcq-N515z78zH5yqz-fuxfx7JHWK2inthc15yyrQDt_oXZys64y53EI0tTlZom4fp1Ln5Pcr_dMSuWE2qRp7bz_zQOyZM76imhM2szGmLptIJS8TRhqLRMv4pMjbTytAVM02OmgKO9gepma2naun4C2ECC48?type=png)

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

## Deprecation Note (Obsolete Software or Hardware)

We can no longer build and package for these environments:

* Any 32-bit build (e.g. i386, i686, and powerpc);
* Windows 8 or older (64-bit);
* Windows Server 2012 or older (64-bit);

If you need such a build, use a previous stable or rolling release.
