# John the Ripper Packages

<div id="header" align="center">

[![john-the-ripper](https://snapcraft.io/john-the-ripper/badge.svg)](https://snapcraft.io/john-the-ripper)
[![License](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://github.com/openwall/john-packages/blob/master/LICENSE.txt)

[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/openwall/john-packages/badge)](https://api.securityscorecards.dev/projects/github.com/openwall/john-packages)
[![Best Practices](https://bestpractices.coreinfrastructure.org/projects/7525/badge)](https://bestpractices.coreinfrastructure.org/projects/7525)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/openwall/john-packages?label=Grade&logo=codefactor&logoColor=ffffff&style=flat-square "CodeFactor Grade")](https://www.codefactor.io/repository/github/openwall/john-packages)

</div>

[Openwall's](http://openwall.com/) John the Ripper (JtR) is a fast password cracker,
currently available for many flavors of Unix and for Windows. Its primary
purpose is to detect weak Unix passwords. Besides several crypt(3) password hash
types most commonly found on various Unix systems, supported out of the box are
Windows LM hashes, various macOS password hashes, as well as many
non-hashes such as SSH private keys, encrypted filesystems such as macOS .dmg files
and "sparse bundles", encrypted archives such as ZIP, RAR, and 7z,
encrypted document files such as PDF and Microsoft Office's, plus lots of
other hashes and ciphers.

## Table of Contents

<img align="right" src="https://www.openwall.com/logo.png" width="182" height="80">

1. [Introduction](#introduction)
   1. [Continuous Delivery Status](#continuous-delivery-status)
   2. [Package Build Environments](#package-building-environments)
   3. [Testing, Continuous Integration, and Continuous Delivery](#testing-and-continuous-integration)
   4. [Packaging and Application Distribution](#packaging-and-application-distribution)
   5. [The commits feed of this repository ![New Commits Feed](https://upload.wikimedia.org/wikipedia/en/thumb/4/43/Feed-icon.svg/16px-Feed-icon.svg.png)](https://github.com/openwall/john-packages/commits/main.atom)
   6. [The feed of John the Ripper releases ![New Releases Feed](https://upload.wikimedia.org/wikipedia/en/thumb/4/43/Feed-icon.svg/16px-Feed-icon.svg.png)](https://github.com/openwall/john-packages/releases.atom)
2. [Windows Package](#-windows)
3. [Snap Package](#-snap)
4. [macOS Package](#-macos)
5. [Flatpak Package](#-flatpak)
6. [Docker Image](#-docker-image)
7. [Checksums](#packages-checksums)
8. [Package Security](#-security)
9. [Contribute](#contribute)
10. [License](#license)

## Introduction

### Continuous Delivery Status

We produce software in short cycles, ensuring that the software can be reliably released at any time, following a pipeline through a "production-like environment".

<div id="CD" align="center">

[![Docker image](https://github.com/openwall/john-packages/actions/workflows/docker.yml/badge.svg)](https://github.com/openwall/john-packages/actions/workflows/docker.yml)
[![Flatpak Build](https://gitlab.com/claudioandre-br/JtR-CI/badges/master/pipeline.svg?key_text=Flatpak)](https://gitlab.com/claudioandre-br/JtR-CI/pipelines)
[![Build Status](https://dev.azure.com/claudioandre-br/JohnTheRipper/_apis/build/status/JohnTheRipper?label=Windows)](https://dev.azure.com/claudioandre-br/JohnTheRipper/_build/latest?definitionId=2)

[![Launchpad](https://media.launchpad.net/lp-badge-kit/launchpad-badge-w120px.png)](https://launchpad.net/~claudioandre.br/john/+snap/john-the-ripper)

[![Virus Scan](https://github.com/openwall/john-packages/actions/workflows/virusscan.yml/badge.svg)](https://github.com/openwall/john-packages/actions/workflows/virusscan.yml)

| **Releases** | **Latest** (![GitHub Latest Release Date](https://img.shields.io/github/release-date/openwall/john-packages?label=&style=flat-square "GitHub Latest Release Date")) | **Prerelease** (![GitHub Latest Prerelease Date](https://img.shields.io/github/release-date-pre/openwall/john-packages?label=&style=flat-square "GitHub Latest Prerelease Date")) |
|:-:|:-:|:-:|
 [![GitHub](https://img.shields.io/badge/Downloads-gray "Downloads")](https://github.com/openwall/john-packages/releases) ![GitHub Total Downloads](https://img.shields.io/github/downloads/openwall/john-packages/total?label=&style=flat-square "GitHub Total Downloads") | ![GitHub Latest Release Version](https://img.shields.io/github/release/openwall/john-packages?sort=date&label=&style=flat-square&color=blue "GitHub Latest Release Version") | ![GitHub Latest Prerelease Version](https://img.shields.io/github/release/openwall/john-packages?include_prereleases&sort=date&label=&style=flat-square&color=blue "GitHub Latest Prerelease Version") |

</div>

### Package Building Environments

Click on the link to learn more about our packages [Building Environments](https://github.com/openwall/john-packages/tree/master/deploy#deployments).

### Testing and Continuous Integration

All continuous integration (CI) and continuous delivery (CD) procedures are fully automated, builds and tests are
performed whenever requested by the packager. Manual procedures are required just to
start the process.

Click on the link to learn more about our [Continuous Integration and Continuous Delivery](https://github.com/openwall/john-packages/tree/master/tests#continuous-integration-and-continuous-delivery) procedures.

[![Graph](https://mermaid.ink/img/pako:eNqVk01vGjEQhv_KyKdEDTlWFaoiLWzTRCkFAVUjQQ6Dd1gsvLblD1pg-e-xFyJIuz10D6v98PPOzDsze8Z1QazLSotmBdN8riBe2eyHcd4SVtDXVSX8C3Q6dzVfEV-DC8LjQkjhtzX0rsZBAUKhf6kTYWmBjsBrKMmDXxFI9OQ88BWqktz1MUYvSUJ_n3ihPi_sHYzQopQkD8cT_SZoZsyGttpC_7GGfLbE7hI7Bbm11wYS9lOoGN3F_y-XXF9YLqmhvrRQueZrsi2QDa6B7luge0vUm-R_UtkuWIKcNsPRpIaHNjDsdkKVMI0-pPcP6faonCHuI2ik3qYvI-RrLOksfnsbPaqF2kROlOiFVjU8zei3ISsqUh7l6fBTY2fdE94KR0lsoGOTjmkZV8O3lrQyVVgtinM9J5UL7wYtWIV8OIHnTx__ot7M-_5PKhsP3lNfhX8IC8h4Ki7mOWxBJ1piLOuc5_96HKVBL5shO7qdvLt0vOljhSqgBDTG6g3KGp6v3lqbGJeANM9jkhRH_Ppdm-qCeNoV52IwKmoYteQ4tbg51sFuWEW2QlHE7dsnpTmL2hXNWTc-FrTEIP2czdUhHsXg9WSrOOt6G-iGBVPEncoFxr2tWIwiHR1eAamZRMU?type=png)](tests#continuous-integration-and-continuous-delivery)


### Packaging and Application Distribution

[Snap](https://snapcraft.io/) and [Flatpak](https://flatpak.org/) are cool new ways
of distributing Linux applications among a wide range of different distros. They
are technologies to deploy applications in a secure, sandboxed and containerised way.

A [Docker](https://www.docker.com/) image is a read-only template used to execute code in a Docker container. An image is an immutable file that contains the binaries, configuration files, libraries, dependencies, tools, and other files needed for John the Ripper application to run.

When the Docker user runs an image, it becomes one instance (it becomes a container, in other words, a running instance of the application).

## 📂 Windows

> Delivered using Microsoft-hosted Windows 2019 Server in Azure [ supports up to AVX512BW ]

To install John the Ripper by downloading the .7z file and installing it manually,
follow these steps:

- Download the compressed file to your machine.
- Navigate to where you downloaded the file and double click the compressed file.
- Extract it to a directory such as `C:\john-the-ripper`.
- Start a command prompt.
- Navigate to the directory you extracted the compressed file, e.g., `cd C:\john-the-ripper\run`.
- Run JtR:

```powershell
 C:\john-the-ripper\run>john --list=build-info
 C:\john-the-ripper\run>john --test --format=SHA512crypt
```

| 📑 **More examples of** [running John The Ripper on Windows](docs/examples-windows.md#more-examples-of-running-john-the-ripper-on-windows).

The highlights (👀):

- fallback for CPU[*] and OMP;
- prince mode available;
- OpenCL available (GPU driver installation is needed);
- generic crypt(3) format available;
- security feature Address Space Layout Randomisation (ASLR) enabled;
- security feature Data Execution Prevention (DEP) enabled;
- the rolling version of John 1.9.0 Jumbo 1+:
  - is available for X86_64;
- the stable John 1.9.0 Jumbo 1:
  - is available for X86_64 and i386;
- a development version:
  - is available for X86_64.

[*] John the Ripper runs using the best SIMD instructions available on the host
it's running on.

### Windows Deployments

[![Windows Downloads](https://img.shields.io/badge/Download-Windows%20Build-blue.svg)](https://github.com/openwall/john-packages/releases)

Using the above instructions you can install the rolling version of John
the Ripper Jumbo 1+, the hot and bleeding version, or a previous stable
version in your system.

The package contains all the executables and libraries needed to run a fresh
John the Ripper installation.

### Running a non-OpenMP build on Windows

In some situations a non-OpenMP build may be faster. You can ask to fallback to
a non-OpenMP build specifying the value of OMP_NUM_THREADS in the command line.
You avail the best SIMD instructions at one's disposal without any OpenMP stuff. E.g.:

```powershell
 PS C:\john-the-ripper\run> set OMP_NUM_THREADS=1
 PS C:\john-the-ripper\run> .\john --list=build-info
```

### Acessing OpenCL on Windows

Some adjustments may be necessary to allow John the Ripper detect your GPU
hardware. If you are facing problems, please read:

| 📑 **Workarounds for** [OpenCL issues on Windows](docs/opencl-issues.md#advices-to-anyone-facing-opencl-windows-problems).

## 📂 Snap

> Delivered using Launchpad [ supports up to AVX512BW ]

[**A Snap**](https://snapcraft.io/) is a gpg signed squashfs file containing an application
together with its dependencies, and a description of how it should safely be run
on your system.

You can install `john` by following the instructions at
[https://snapcraft.io/john-the-ripper](https://snapcraft.io/john-the-ripper). For distributions without snap
pre-installed, users should [enable snap support](https://docs.snapcraft.io/core/install), then install:

```bash
 sudo snap install john-the-ripper
```

Just dance now:
```bash
 $ john-the-ripper -list=build-info
 [...]
 Build: linux-gnu 64-bit x86_64 AVX2 AC OMP OPENCL
 SIMD: AVX2, interleaving: MD4:3 MD5:3 SHA1:1 SHA256:1 SHA512:1
 Deploy: sandboxed as a Snap app
 [...]
```

You can also run the software using the official `john` alias:
```bash
 john -list=build-info
```

John runs confined under a restrictive security sandbox by default. Nevertheless,
you can access and audit any file located in your home. Below, an usage example:

```bash
 john -list=format-tests | cut -f3 > ~/alltests.in
 john -form=SHA512crypt ~/alltests.in
```

For your convenience, the snap installed on your system contains the file
`/snap/john-the-ripper/current/snap/manifest.yaml` which field `build_url`
points to its build log.

The highlights (👀):

- fallback for CPU[*] and OMP;
- prince mode available;
- OpenCL available (GPU driver installation is needed);
- John the Ripper is a "featured software" in the security category on Canonical Snap Store;
- John the Ripper is a software with 4-star (⭐⭐⭐⭐) user reviews on Canonical Snap Store;
- John the Ripper is tagged as safe, confined and auditable software on Canonical Snap Store;
- John the Ripper supports and has a package for all architectures supported by Ubuntu itself.
- also available via the alias **john**, e.g. `john -list=build-info`;
- the rolling version of John 1.9.0 Jumbo 1+:
  - is available for X86_64, armhf, arm64, ppc64el, i386, riscv64, and s390x;
- the stable John 1.9.0 Jumbo 1:
  - is available for X86_64, armhf, arm64, ppc64el, i386, powerpc, and s390x;
  - has regular expression mode available;
- a development version:
  - is available for X86_64, arm64, ppc64el, and s390x.

[*] John the Ripper runs using the best SIMD instructions available on the host
it's running on.

```Text
John the Ripper snap package has approximately eight thousand active users [*].
```

[*] 7 Day Active Users: the number of unique users who had at least one session within a 7 day period.

### Enabling Aliases

You are free to pick and set up aliases. To enable the usage of aliases with John
the Ripper snap, run `sudo snap alias john-the-ripper <alias>`. For example:

```bash
 sudo snap alias john-the-ripper john-snap
 sudo snap alias john-the-ripper.dmg2john dmg2john
```

Once enabled, John itself plus the *2john tools can be invoked using the aliases.
In the example, to run John type `john-snap`.

| 📑 **More examples of** [enabling alias for John The Ripper snap](docs/examples-snap-alias.md#more-examples-of-enabling-alias-for-john-the-ripper-snap).

### Running a non-OpenMP build

In some situations a non-OpenMP build may be faster. You can ask to fallback to a
non-OpenMP build specifying `OMP_NUM_THREADS=1 john <options>` in the command line.
You avail the best SIMD instructions at one's disposal without any OpenMP stuff. E.g.:

```bash
 OMP_NUM_THREADS=1 john --list=build-info
```

### Acessing OpenCL on Snap

As noted at [https://forum.snapcraft.io/t/snaps-and-opencl/8509/17](https://forum.snapcraft.io/t/snaps-and-opencl/8509/17), the use of
OpenCL by snaps is a problem. Support for NVIDIA cards is under development.

As a "general" solution (or in the case of AMD hardware), the user can run john
out of the sandbox, unconfined (e.g., run `/snap/john-the-ripper/current/run/john`).

### Snap Deployments

[![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-white.svg)](https://snapcraft.io/john-the-ripper)

If you followed the above instructions, you installed the stable (or rolling) version of John
the Ripper Jumbo 1+ in your system. If you want to access the hot and bleeding
developing version of JtR, you must follow a development channel. For a clean
installation:

```bash
 sudo snap install --channel=edge john-the-ripper
```

If you already has JtR installed:

```bash
 sudo snap refresh --channel=edge john-the-ripper
```

If you do so, you will be running the development version available on GitHub.

## 📂 macOS

> Delivered using Circle CI and Cirrus CI [ supports ASIMD (on ARM), AVX and AVX2 (on x86) ]

To install John the Ripper by downloading the .7z file and installing it manually,
follow these steps:

- Download the compressed file to your machine.
- Extract it to a directory such as `/Users/Me/bleeding`.
- Start a command prompt.
- Navigate to the directory you extracted the compressed file, e.g., `cd /Users/Me/bleeding`.
- Run the software:

Install required Homebrew packages (if not already installed):

```bash
 brew update
 brew install libomp openssl gmp
```

Execute John the Ripper:

```bash
 run/john -list=build-info
```

The highlights (👀):

- fallback for CPU[*] (if that makes sense) and OMP;
- prince mode available;
- OpenCL available;
- built using clang from the official XCode toolchain plus non-system libraries from Homebrew;
- a development version:
  - is available for X86_64 (on Intel).
  - is available for ARM (on M1 and M2).

[*] John the Ripper runs using the best SIMD instructions available on the host
it's running on.

### macOS Deployments

[![macOS Downloads](https://img.shields.io/badge/Download-Mac%20Build-blue.svg)](https://github.com/openwall/john-packages/releases)

Using the above instructions you can install the hot and bleeding version
in your system.

The package contains the necessary executables to run a fresh install of John the Ripper.
You must install required Homebrew libraries.

### Running a non-OpenMP build on macOS

In some situations a non-OpenMP build may be faster. You can ask to fallback to
a non-OpenMP build specifying the value of OMP_NUM_THREADS in the command line.
You avail the best SIMD instructions at one's disposal without any OpenMP stuff. E.g.:

```bash
OMP_NUM_THREADS=1 run/john --list=build-info
```

## 📂 Flatpak

> Delivered using GitLab CI [ supports up to AVX512BW ]

[**Flatpak**](http://flatpak.org//) is a new framework for desktop applications
on Linux, built to be distribution agnostic and allow deployment on any Linux
operating system out there.

Flatpak is available for the [most common Linux distributions](http://flatpak.org/getting.html).

To install JtR download the john.flatpak file and run:

```bash
 # Note that root privileges are required for some operations.
 sudo dnf install -y flatpak # or 'yum install', 'apt-get install', etc.
 sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo # flatpak repository
 sudo flatpak install -y flathub org.freedesktop.Platform//22.08 # install the runtime (base "container")
 flatpak --user install --bundle john.flatpak # per-user installation (not system wide)
```

John runs confined under a restrictive security sandbox by default. Nevertheless,
you can access and audit any file located in your home. Below, an usage example:

```bash
 flatpak run com.openwall.John -list=build-info
 flatpak run com.openwall.John -list=format-tests | cut -f3 > ~/alltests.in
 flatpak run com.openwall.John -form=SHA512crypt ~/alltests.in
```

The highlights (👀):

- fallback for CPU[*] and OMP;
- prince mode available.
- the rolling version of John 1.9.0 Jumbo 1+:
  - is available for X86_64;
- the stable John 1.9.0 Jumbo 1:
  - is available for X86_64, arm, aarch64, and i386;
  - has regular expression mode available;
- a development version:
  - is available for X86_64.

[*] John the Ripper runs using the best SIMD instructions available on the host
it's running on.

### Flatpak Deployments

[![Flatpak Download](https://img.shields.io/badge/Download-Flatpak%20Package-blue)](https://github.com/openwall/john-packages/releases)

Using the above instructions you can install the rolling version of John
the Ripper Jumbo 1+, the hot and bleeding version, or a previous stable
version in your system.

## 📂 Docker Image

> Delivered using GitHub Actions [ supports up to AVX512BW ]

For testing and future reference, we have a Docker image of John the Ripper.
To use it:

```bash
 # CPU only formats
 docker run -it ghcr.io/openwall/john:latest <binary id> <john options>

 # To run ztex formats
 docker run --device=/dev/ttyUSB0 ghcr.io/openwall/john:v1.9.0J1 ztex <john options>
```

Run John the Ripper and check if it is working:

```bash
 docker run ghcr.io/openwall/john # => uses the best SIMD available, tag 'latest' can be ommited
 docker run ghcr.io/openwall/john:rolling # => uses the latest rolling release
 docker run ghcr.io/openwall/john:latest best # => uses the best SIMD available
```

| 📑 **More examples of** [running John The Ripper on Docker](docs/examples-docker.md#more-examples-of-running-john-the-ripper-on-docker).

The highlights (👀):

- prince mode available;
- the rolling version of John 1.9.0 Jumbo 1+ (`ghcr.io/openwall/john:rolling`):
  - has auto-selection of the best SIMD if user specifies `best` as the `<binary id>`.
- the stable John 1.9.0 Jumbo 1 (`ghcr.io/openwall/john:v1.9.0J1`):
  - has ztex formats available.
- the development version (`ghcr.io/openwall/john:latest`):
  - has auto-selection of the best SIMD if user specifies `best` as the `<binary id>`.

### Docker Image Deployments

[![Docker Image Downloads](https://img.shields.io/badge/Download-Docker%20Build-blue.svg)](https://github.com/openwall/john-packages/pkgs/container/john)

Using the above instructions you can install the rolling version of John
the Ripper Jumbo 1+, the hot and bleeding version, or a previous stable
version in your system.

## Packages Checksums

> Released packages checksums computed by Build Servers

File verification is the process of using an algorithm for verifying the integrity
of a computer file. A popular approach is to store checksums (hashes) of files,
also known as message digests, for later comparison. All john packages checksums (hashes)
are computed by the CI servers.

By accessing the build logs for each release on GitHub releases you can view the hashes of all
relevant files.

## ⚠ Security

Please inspect all packages prior to running any of them to ensure safety.
We already know they're safe, but you should verify the security and contents of any
binary from the internet you are not familiar with.

We take security very seriously.

## Contribute

We love contributions in the form of issues and pull requests. Read the [Contributor Guide](CONTRIBUTING.md) before contributing.

## License

GNU General Public License v2.0
