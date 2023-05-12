# Deployments

We use premium build providers like Azure Cloud, Launchpad, and GitLab.

![Donation](https://img.shields.io/badge/Donate-Yes-brightgreen?style=flat&logo=github-sponsors) Please donate. You can make a real difference and help our work by donating to support the infra.

At the time of this writing, `john` is known to build and work on:

* Linux (kernel 6 or later recommended)
* Android NDK r23b (on ARM and X86)
* FreeBSD (tested with 12 and later on X86)
* Solaris (tested with 11 on X86)
* macOS (on ARM and X86)

Also in the following Windows environments:
* Microsoft Windows (Windows 10 / Windows Server 2016 or later)
* Mingw + Wine (32-bit and 64-bit), using an ancient Fedora Docker image
* Cygwin

## Release Process

![Release Process](https://mermaid.ink/img/pako:eNp9kltLw0AQhf_KsE8KbUCQIkWUNrEXqrYYRaHJw3QzbZdkd8Nm11vT_-4mCl4o7tNh53znMDA7xnVGrM82Bsst3EeJAv8GywXyHDdCbVLodi_qaQXhFHR-WcPw6HxlLm5QOSwgtmisK5ufIAiOP-lhg8DwZDkmC7F2hhOEvqZxjYyW8FBW1hDK9Mt_0gLhbmH0s8jIVPvPQdh2j4W9xpXvryFarrG_xm5GVW51CW1igXaBefoTuUan-LbErIarA0issEz_VEzcCgbcCq2qGkYHoEjznEyjphI39IsfvDtDENHzfBHXMDlAPwqV6Zeqkb3TlbDfeBD43WdLei3JCEnKYvE1nLXZoTC8oHb92wPBEvk8bsTTWe8vZ1zVcvP_uMHdTco6TJKRKDJ_CrsmJWF2S5IS1vcyozW6wiYsUXtvRWd1_KY461vjqMNcmaGlSKA_Isl8UVHR_gPFCsKW?type=png)

## John the Ripper rolling (1.9.0 Jumbo 1+) release build environments

### Docker Image

```text
FROM docker.io/library/ubuntu:22.04
```

### Flatpak

```text
runtime: org.freedesktop.Platform 22.08
```

### macOS

```text
Darwin 21.6.0 x86_64 i386
Darwin 22.4.0 arm64 arm
```

### Snap

```text
runtime: core22
Launchpad --series=jammy
```

### Windows

```text
OS Name:                   Microsoft Windows Server 2019 Datacenter
OS Version:                10.0.17763 N/A Build 17763
Current image version: '20230417.2'
```

## Deprecation Note (Obsolete Software or Hardware)

We can no longer build and package for these environments:

* Any 32-bit build (e.g. i386, i686, and powerpc);
* Windows 8 or older (64-bit);
* Windows Server 2012 or older (64-bit);

If you need such a build, use a previous stable or rolling release.
