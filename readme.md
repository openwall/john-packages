# John the Ripper Packages

<!-- markdownlint-disable MD033 -->

<div id="header" align="center">

[![john-the-ripper][shieldSnap]][linkSnapcraftJohn]
[![License][shieldLicense]](https://github.com/openwall/john-packages/blob/main/LICENSE.txt)

[![OpenSSF Scorecard][shieldScore]](https://api.securityscorecards.dev/projects/github.com/openwall/john-packages)
[![Best Practices][shieldPractices]](https://bestpractices.coreinfrastructure.org/projects/7525)

</div>

[Openwall's](https://openwall.com/) John the Ripper (JtR) is a fast password cracker, currently available for many
flavors of Unix and for Windows. Its primary purpose is to detect weak Unix passwords. Besides several crypt(3) password
hash types most commonly found on various Unix systems, supported out of the box are Windows LM hashes, various macOS
password hashes, as well as many non-hashes such as SSH private keys, encrypted filesystems such as macOS .dmg files and
"sparse bundles", encrypted archives such as ZIP, RAR, and 7z, encrypted document files such as PDF and Microsoft
Office's, plus lots of other hashes and ciphers.

## Table of Contents

<img align="right" src="https://www.openwall.com/logo.png" width="182" height="80" alt="Openwall logo">

1. [Introduction](#introduction)
   1. [Continuous Delivery Status](#continuous-delivery-status)
   2. [Package Build Environments](#package-building-environments)
   3. [Testing, Continuous Integration, and Continuous Delivery](#testing-and-continuous-integration)
   4. [Packaging and Application Distribution](#packaging-and-application-distribution)
   5. [The commits feed of this repository ![New Commits Feed][linkFeedIcon]](https://github.com/openwall/john-packages/commits/main.atom)
   6. [The feed of John the Ripper releases ![New Releases Feed][linkFeedIcon]](https://github.com/openwall/john-packages/releases.atom)
2. [Windows Package](#-windows)
3. [Snap Package](#-snap)
4. [macOS Package](#-macos)
5. [Flatpak Package](#-flatpak)
6. [Docker Image](#-docker-image)
7. [Checksums](#packages-checksums)
8. [Package Security](#-security)
9. [About This Project](#about-this-project)
10. [Contribute](#contribute)
11. [Acknowledgments and Contact](#acknowledgments-and-contact)
12. [License](#license)

<p align="right">(<a href="#header">back to top</a>)</p>

## Introduction

### Continuous Delivery Status

We produce software in short cycles, ensuring that the software can be reliably released at any time, following a
pipeline through a "production-like environment".

<div id="CD" align="center">

[![Docker](https://github.com/openwall/john-packages/actions/workflows/docker.yml/badge.svg)][linkRegistry]
[![Flatpak](https://gitlab.com/claudioandre-br/JtR-CI/badges/master/pipeline.svg?key_text=Flatpak)][linkReleases]
[![macOS](https://img.shields.io/cirrus/github/claudioandre-br/JohnTheRipper/bleeding-jumbo?label=macOS)][linkReleases]
[![Windows](https://dev.azure.com/claudioandre-br/JohnTheRipper/_apis/build/status/JohnTheRipper?label=Windows)][linkReleases]
[![Virus Scan](https://github.com/openwall/john-packages/actions/workflows/release.yml/badge.svg)][linkReleases]

[![Launchpad](https://media.launchpad.net/lp-badge-kit/launchpad-badge-w120px.png)][linkSnapcraftJohn]
<a href='https://flathub.org/apps/com.openwall.John'><img height='27' alt='Download on Flathub' src='https://dl.flathub.org/assets/badges/flathub-badge-i-en.svg'/></a>

### Proper Releases

|                                               | **Latest**<br> ![Release Version][linkLatestReleaseVersion] | **Prerelease**<br> ![Prerelease Version][linkLatestPrereleaseVersion] |
| :-------------------------------------------: | :---------------------------------------------------------: | :-------------------------------------------------------------------: |
| ![GitHub Total Downloads][linkTotalDownloads] |           ![Release Date][linkLatestReleaseDate]            |             ![Prerelease Date][linkLatestPrereleaseDate]              |

### Testing Packages

| Available Technology                 | Rollout Status                                       |
| ------------------------------------ | ---------------------------------------------------- |
| Docker image with the tag `bleeding` | [![Endpoint Badge][bleedingDocker]][linkRegistry]    |
| Snap package from the `edge` channel | [![Endpoint Badge][bleedingSnap]][linkSnapcraftJohn] |
| Windows 64bits package               | [![Endpoint Badge][bleedingWindows]][linkWindowsPkg] |

</div>

### Package Building Environments

Click on the link to learn more about our packages [Building Environments](deploy/readme.md#deployments).

### Testing and Continuous Integration

All continuous integration (CI) and continuous delivery (CD) procedures are fully automated, builds and tests are
performed whenever requested by the packager. Manual procedures are required just to start the process.

Click on the link to learn more about our
[Continuous Integration and Continuous Delivery](CI/readme.md#continuous-integration-and-continuous-delivery)
procedures.

[![Graph][linkProcedureCI]](CI/readme.md#continuous-integration-and-continuous-delivery)

### Packaging and Application Distribution

[Snap][linkSnapcraftSite] and [Flatpak][linkFlatpakSite] are cool new ways of distributing Linux applications among a
wide range of different distros. They are technologies to deploy applications in a secure, sandboxed and containerized
way.

A [Docker](https://www.docker.com/) image is a read-only template used to execute code in a Docker container. An image
is an immutable file that contains the binaries, configuration files, libraries, dependencies, tools, and other files
needed for John the Ripper application to run.

When the Docker user runs an image, it becomes one instance (it becomes a container, in other words, a running instance
of the application).

<p align="right">(<a href="#header">back to top</a>)</p>

## 📂 Windows

<!-- markdownlint-disable MD042 -->

> Delivered using Microsoft-hosted Windows 2022 Server in Azure \
> Supported architecture: [amd64](# "[ backed by AVX, AVX2, and AVX512BW ]")

<!-- markdownlint-enable MD042 -->

To install John the Ripper by downloading the .7z file and installing it manually, follow these steps:

- Download the compressed file to your machine.
- Navigate to where you downloaded the file and double-click the compressed file.
- Extract it to a directory such as `C:\john-the-ripper`.
- Start a command prompt.
- Navigate to the directory you extracted the compressed file, e.g., `cd C:\john-the-ripper\run`.
- Run JtR:

```powershell
 C:\john-the-ripper\run>john --list=build-info
 [...]
 Build: cygwin 64-bit x86_64 AVX2 AC OMP OPENCL
 SIMD: AVX2, interleaving: MD4:3 MD5:3 SHA1:1 SHA256:1 SHA512:1
 [...]
```

```powershell
 C:\john-the-ripper\run>john --test --format=SHA512crypt
```

| 📑 **More examples of**
[running John The Ripper on Windows](docs/examples-windows.md#more-examples-of-running-john-the-ripper-on-windows).

The highlights (👀):

- has fallback for CPU[*] and OMP;
- has OpenCL available (GPU driver installation is needed);
- generic crypt(3) format available;
- security feature Address Space Layout Randomisation (ASLR) enabled;
- security feature Data Execution Prevention (DEP) enabled.

[*] John the Ripper runs using the best SIMD instructions available on the host it's running on.

### Windows Deployments

[![Windows Downloads][linkBadgeDownloadWindows]][linkReleases]

Using the instructions above, you can install the released version of `john`, or the bleeding development version, or an
earlier stable version on your system.

The package contains all the executables and libraries needed to run a fresh John the Ripper installation.

<!--
// jscpd:ignore-start
-->
<details>
  <summary>OpenSSF SLSA</summary>

SLSA is a framework intended to codify and promote secure software supply-chain practices, it helps trace software
artifacts back to the build and source control systems that produced them.

> :warning: **NOTE:** the release assets from our GitHub Releases are level 1 compliant.

  <div align="center">
    <a href="https://github.com/openwall/john-packages/releases?q=Windows&expanded=true">
      <img src="https://slsa.dev/images/levelBadge1.svg" alt="Logo" width="80" height="80">
    </a>
    <h3>SLSA Provenance Traceability</h3>
  </div>
</details>
<!--
// jscpd:ignore-end
-->

### Running a non-OpenMP build on Windows

In some situations a non-OpenMP build may be faster. You can ask to fallback to a non-OpenMP build specifying the value
of OMP_NUM_THREADS in the command-line. You avail the best SIMD instructions at one's disposal without any OpenMP stuff.
E.g.:

```powershell
 PS C:\john-the-ripper\run> set OMP_NUM_THREADS=1
 PS C:\john-the-ripper\run> .\john --list=build-info
```

### Accessing OpenCL on Windows

If John the Ripper is not recognizing your GPU card:

- make sure all required GPU drivers are installed;
- restart your PC, if you have just installed the drivers.

<p align="right">(<a href="#header">back to top</a>)</p>

## 📂 Snap

<!-- markdownlint-disable MD042 -->

> Delivered using Launchpad \
> Supported architectures: [amd64](# "[ backed by AVX, AVX2, and AVX512BW ]"), [arm64v8](# "[ backed by ASIMD ]"),
> [ppc64le](# "[ backed by Altivec ]"), riscv64, and s390x

<!-- markdownlint-enable MD042 -->

[**A Snap**][linkSnapcraftSite] is a gpg signed squashfs file containing an application together with its dependencies,
and a description of how it should safely be run on your system.

You can install `john` by following the instructions at <https://snapcraft.io/john-the-ripper>. For distributions
without snap pre-installed, users should [enable snap support](https://docs.snapcraft.io/core/install), then install:

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

John runs confined under a restrictive security sandbox by default. Nevertheless, you can access and audit any file
located in your home. Below, an usage example:

```bash
 john -list=format-tests | cut -f3 > ~/allTests.in
 john --format=SHA512crypt ~/allTests.in
```

For your convenience, the snap installed on your system contains the file
`/snap/john-the-ripper/current/snap/manifest.yaml` which field `build_url` points to its build log.

The highlights (👀):

- has fallback for CPU[*] and OMP;
- has OpenCL available (GPU driver installation is needed);
- John the Ripper is a "featured software" in the security category on Canonical Snap Store;
- John the Ripper is a software with 4-star (⭐⭐⭐⭐) user reviews on Canonical Snap Store;
- John the Ripper is tagged as safe, confined and auditable software on Canonical Snap Store;
- John the Ripper supports and has a package for all architectures supported by Ubuntu itself.
- also available via the alias **john**, e.g. `john -list=build-info`;
- the latest released version:
  - install from the Snapcraft `stable` channel.
- a development version is also available:
  - install from the Snapcraft `edge` channel.

[*] John the Ripper runs using the best SIMD instructions available on the host it's running on.

```Text
John the Ripper snap package has approximately eight thousand active users [*].
```

[*] 7 Day Active Users: the number of unique users who had at least one session within a 7 day period.

### Enabling Aliases

You are free to pick and set up aliases. To enable the usage of aliases with John the Ripper snap, run
`sudo snap alias john-the-ripper <alias>`. For example:

```bash
 sudo snap alias john-the-ripper john-snap
 sudo snap alias john-the-ripper.dmg2john dmg2john
```

Once enabled, John itself plus the \*2john tools can be invoked using the aliases. In the example, to run John type
`john-snap`.

| 📑 **More examples of**
[enabling alias for John The Ripper snap](docs/examples-snap-alias.md#more-examples-of-enabling-alias-for-john-the-ripper-snap).

### Running a non-OpenMP build

In some situations a non-OpenMP build may be faster. You can ask to fallback to a non-OpenMP build specifying
`OMP_NUM_THREADS=1 john <options>` in the command-line. You avail the best SIMD instructions at one's disposal without
any OpenMP stuff. E.g.:

```bash
 OMP_NUM_THREADS=1 john --list=build-info
```

### Accessing OpenCL on Snap

As noted at <https://forum.snapcraft.io/t/snaps-and-opencl/8509/17>, the use of OpenCL by snaps is a problem. Support
for NVIDIA cards is under development.

As a "general" solution (or in the case of AMD hardware), the user can run john out of the sandbox, unconfined (e.g.,
run `/snap/john-the-ripper/current/bin/john`).

### Snap Deployments

[![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-white.svg)][linkSnapcraftJohn]

If you followed the instructions above, you have installed the released version of `john` on your system. If you want to
access the hot and bleeding development version of JtR, you must follow the edge channel. For a clean install:

```bash
 sudo snap install --channel=edge john-the-ripper
```

If you already have JtR installed:

```bash
 sudo snap refresh --channel=edge john-the-ripper
```

If you do so, you will be running the development version available on GitHub.

<p align="right">(<a href="#header">back to top</a>)</p>

## 📂 macOS

<!-- markdownlint-disable MD042 -->

> Delivered using Cirrus CI \
> Supported architecture: [arm64](# "[ backed by ASIMD ]")

<!-- markdownlint-enable MD042 -->

To install John the Ripper by downloading the .7z file and installing it manually, follow these steps:

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
 $ run/john -list=build-info
 [...]
 Build: darwin22.6.0 64-bit arm ASIMD AC OMP OPENCL
 SIMD: ASIMD, interleaving: MD4:2 MD5:2 SHA1:1 SHA256:1 SHA512:1
 OMP fallback binary: john-arm64
 [...]
```

The highlights (👀):

- has fallback for CPU[*] (if that makes sense) and OMP;
- has OpenCL available;
- built using clang from the official Xcode toolchain plus non-system libraries from Homebrew.

[*] John the Ripper runs using the best SIMD instructions available on the host it's running on.

### macOS Deployments

[![macOS Downloads][linkBadgeDownloadMac]][linkReleases]

Using the instructions above, you can install the released version of `john`, or the bleeding development version, or an
earlier stable version on your system.

The package contains the necessary executables to run a fresh install of John the Ripper. You must install required
Homebrew libraries.

<!--
// jscpd:ignore-start
-->
<details>
  <summary>OpenSSF SLSA</summary>

SLSA is a framework intended to codify and promote secure software supply-chain practices, it helps trace software
artifacts back to the build and source control systems that produced them.

> :warning: **NOTE:** the release assets from our GitHub Releases are level 1 compliant.

  <div align="center">
    <a href="https://github.com/openwall/john-packages/releases?q=macOS&expanded=true">
      <img src="https://slsa.dev/images/levelBadge1.svg" alt="Logo" width="80" height="80">
    </a>
    <h3>SLSA Provenance Traceability</h3>
  </div>
</details>
<!--
// jscpd:ignore-end
-->

### Running a non-OpenMP build on macOS

In some situations a non-OpenMP build may be faster. You can ask to fallback to a non-OpenMP build specifying the value
of OMP_NUM_THREADS in the command-line. You avail the best SIMD instructions at one's disposal without any OpenMP stuff.
E.g.:

```bash
OMP_NUM_THREADS=1 run/john --list=build-info
```

<p align="right">(<a href="#header">back to top</a>)</p>

## 📂 Flatpak

<!-- markdownlint-disable MD042 -->

> Delivered using GitLab CI \
> Supported architectures: [amd64](# "[ backed by AVX, AVX2, and AVX512BW ]") and [arm64v8](# "[ backed by ASIMD ]")

<!-- markdownlint-enable MD042 -->

[**Flatpak**][linkFlatpakSite] is a new framework for desktop applications on Linux, built to be distribution agnostic
and allow deployment on any Linux operating system out there.

Flatpak is available for the [most common Linux distributions](http://flatpak.org/getting.html).

To install JtR download the john.flatpak file and run:

```bash
 # Note that root privileges are required for some operations.
 sudo dnf install -y flatpak # or 'yum install', 'apt-get install', etc.
 sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo # flatpak repository
 sudo flatpak install -y flathub org.freedesktop.Platform//24.08 # install the runtime (base "container")
 flatpak --user install --bundle john.flatpak # per-user installation (not system wide)
```

John runs confined under a restrictive security sandbox by default. Nevertheless, you can access and audit any file
located in your home. Below, an usage example:

```bash
 flatpak run com.openwall.John -list=build-info
 flatpak run com.openwall.John -list=format-tests | cut -f3 > ~/allTests.in
 flatpak run com.openwall.John --format=SHA512crypt ~/allTests.in
```

The highlights (👀):

- has fallback for CPU[*] and OMP;
- also available via FlatHub at <https://flathub.org/apps/com.openwall.John>.

[*] John the Ripper runs using the best SIMD instructions available on the host it's running on.

### Flatpak Deployments

[![Flatpak Download][linkBadgeDownloadFlatpak]][linkReleases]

<!--
// jscpd:ignore-start
-->

Using the instructions above, you can install the released version of `john`, or the bleeding development version, or an
earlier stable version on your system.

<details>
  <summary>OpenSSF SLSA</summary>

SLSA is a framework intended to codify and promote secure software supply-chain practices, it helps trace software
artifacts back to the build and source control systems that produced them.

> :warning: **NOTE:** the release assets from our GitHub Releases are level 1 compliant.

  <div align="center">
    <a href="https://github.com/openwall/john-packages/releases?q=Flatpak&expanded=true">
      <img src="https://slsa.dev/images/levelBadge1.svg" alt="Logo" width="80" height="80">
    </a>
    <h3>SLSA Provenance Traceability</h3>
  </div>
</details>
<!--
// jscpd:ignore-end
-->

<p align="right">(<a href="#header">back to top</a>)</p>

## 📂 Docker Image

<!-- markdownlint-disable MD042 -->

> Delivered using GitHub Actions \
> Supported architectures: [amd64](# "[ backed by AVX, AVX2, and AVX512BW ]") and [arm64v8](# "[ backed by ASIMD ]")

<!-- markdownlint-enable MD042 -->

[**Docker**](https://www.docker.com/) provides the ability to package and run an application in a loosely isolated
environment called a container.

To use it:

```bash
 # CPU and GPU formats
 docker run -it ghcr.io/openwall/john:latest <binary id> <john options>

 # To run ztex formats
 docker run --device=/dev/ttyUSB0 ghcr.io/openwall/john:v1.9.0J1 ztex <john options>
```

Run John the Ripper and check if it is working:

```bash
 docker run ghcr.io/openwall/john # => uses the best SIMD available, tag 'latest' can be omitted
 docker run ghcr.io/openwall/john:bleeding # => uses the latest bleeding release
 docker run ghcr.io/openwall/john:latest best # => uses the best SIMD available
```

| 📑 **More examples of**
[running John The Ripper on Docker](docs/examples-docker.md#more-examples-of-running-john-the-ripper-on-docker).

The highlights (👀):

- OpenSSF SLSA 3 compliant;
- has NVIDIA OpenCL available (GPU driver is required on the host);
- has auto-selection of the best SIMD if user specifies `best` as the `<binary id>`:
  - example: `docker run ghcr.io/openwall/john:latest best -list=build-info`.
- the latest released version:
  - install from the command-line: `docker pull ghcr.io/openwall/john:latest`.
- a development version is also available:
  - install from the command-line: `docker pull ghcr.io/openwall/john:bleeding`.

### Docker Image Deployments

[![Docker Image Downloads][linkBadgeDownloadDocker]][linkRegistry]

<!--
// jscpd:ignore-start
-->

Using the instructions above, you can install the released version of `john`, or the bleeding development version, or an
earlier stable version on your system.

<details>
  <summary>OpenSSF SLSA</summary>

SLSA is a framework intended to codify and promote secure software supply-chain practices, it helps trace software
artifacts back to the build and source control systems that produced them.

> :warning: **NOTE:** the Docker images from our GitHub Packages are level 3 compliant.

  <div align="center">
    <a href="https://github.com/openwall/john-packages/pkgs/container/john">
      <img src="https://slsa.dev/images/levelBadge3.svg" alt="Logo" width="80" height="80">
    </a>
    <h3>SLSA Provenance Traceability</h3>
  </div>
</details>
<!--
// jscpd:ignore-end
-->

<p align="right">(<a href="#header">back to top</a>)</p>

## Packages Checksums

> Released packages checksums computed by Build Servers

File verification is the process of using an algorithm for verifying the integrity of a computer file. A popular
approach is to store checksums (hashes) of files, also known as message digests, for later comparison. All john packages
checksums (hashes) are computed by the CI servers.

By accessing the build logs for each release on GitHub releases you can view the hashes of all relevant files.

You can also go to <https://github.com/openwall/john-packages/attestations> for a list of our named artifacts along with
their digest.

<p align="right">(<a href="#header">back to top</a>)</p>

## ⚠ Security

Please inspect all packages prior to running any of them to ensure safety. We already know they're safe, but you should
verify the security and contents of any binary from the internet you are not familiar with.

We take security very seriously.

<p align="right">(<a href="#header">back to top</a>)</p>

<!-- ABOUT THE PROJECT -->

## About This Project

This project aims to create tools and procedures to automate the creation and enable traceability of packages for John
the Ripper software, developing a CI and CD pipeline.

<p align="right">(<a href="#header">back to top</a>)</p>

## Contribute

We love contributions in the form of issues and pull requests. Read the [Contributor Guide](CONTRIBUTING.md) before
contributing.

[![GitHub issues by-label](https://img.shields.io/github/issues/openwall/john-packages/good%20first%20issue)](https://github.com/openwall/john-packages/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22)

Please first consult our [Security Policy](SECURITY.md) if you intend to report or contribute a fix related to security
vulnerabilities.

Upstream `john` project has a big backlog! If you're new to the project, maybe you'd like to open a pull request to
address one of them.

<p align="right">(<a href="#header">back to top</a>)</p>

## Acknowledgments and Contact

John the Ripper is proudly _Powered by Open Source Community_:

- [Openwall](https://www.openwall.com/john/) and others.

<p align="right">(<a href="#header">back to top</a>)</p>

## License

GNU General Public License v2.0.

<p align="right">(<a href="#header">back to top</a>)</p>

<!-- markdownlint-enable MD033 -->

[bleedingDocker]:
  https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fopenwall%2Fjohn-packages%2Frelease%2Fdeploy%2Fdocker.json
[bleedingSnap]:
  https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fopenwall%2Fjohn-packages%2Frelease%2Fdeploy%2Fsnap.json
[bleedingWindows]:
  https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fopenwall%2Fjohn-packages%2Frelease%2Fdeploy%2Fwindows.json
[linkBadgeDownloadDocker]: https://img.shields.io/badge/Download-Docker%20Image-blue.svg?style=for-the-badge
[linkBadgeDownloadFlatpak]: https://img.shields.io/badge/Download-Flatpak%20Package-blue?style=for-the-badge
[linkBadgeDownloadMac]: https://img.shields.io/badge/Download-macOS%20Package-blue.svg?style=for-the-badge
[linkBadgeDownloadWindows]: https://img.shields.io/badge/Download-Windows%20Package-blue.svg?style=for-the-badge
[linkFeedIcon]: https://upload.wikimedia.org/wikipedia/en/thumb/4/43/Feed-icon.svg/16px-Feed-icon.svg.png
[linkFlatpakSite]: https://flatpak.org/
[linkLatestPrereleaseDate]:
  https://img.shields.io/github/release-date-pre/openwall/john-packages?label=when&color=green
  "Latest Prerelease Date"
[linkLatestPrereleaseVersion]:
  https://img.shields.io/github/release/openwall/john-packages?include_prereleases&sort=date&label=&style=flat-square&color=blue
  "Latest Prerelease Version"
[linkLatestReleaseDate]:
  https://img.shields.io/github/release-date/openwall/john-packages?label=when&color=green
  "Latest Release Date"
[linkLatestReleaseVersion]:
  https://img.shields.io/github/release/openwall/john-packages?sort=date&label=&style=flat-square&color=blue
  "Latest Release Version"
[linkRegistry]: https://github.com/openwall/john-packages/pkgs/container/john "Our Docker image registry"
[linkReleases]: https://github.com/openwall/john-packages/releases "The Release List"
[linkSnapcraftJohn]: https://snapcraft.io/john-the-ripper "John Snap Package"
[linkSnapcraftSite]: https://snapcraft.io/ "Snapcraft Main Site"
[linkTotalDownloads]:
  https://img.shields.io/github/downloads/openwall/john-packages/total?label=downloads&color=white
  "Total Downloads"
[linkProcedureCI]:
  https://mermaid.ink/img/pako:eNqVk92O2jAQhV9l5CtWXfYBULVSIN0f0S0IqKgKezE4Q7BwbMt2aIHw7rWTpbDd3DQXUezMd2Z8xnNkXGfEeiy3aDYwS5cKwpMsvhvnLWEBA10Uwr9Ct3tf8Q3xLbhSeFwJKfy-gn5nUipAyPQv9UZYWqEj8Bpy8uA3BBI9OQ98gyond9Pk6EdJGBwjL9Tnlb2HMVqUkuSpiRjUSRNjdrTXFgbPFaSLNfbW2M3Ibb02ELG5UCG7C_9fr7mBsFxSTX1poVLNt2RbIFu6GnpogR4sUX-a_kslh9ISpLQbjacVPLWB5eEgVA6z4ENcf4qvZ-UMcR9AI_U-7oyRbzGni_jdXfCoEmoXOJGjF1pVMFzQb0NWFKQ8yrfgYRNcZcRjx5wLoZRVMO_0hbfCUdR_0aFvTaXm3Id53YevLUUnKrNaZJfTDuvQa5O-tWAF8tEUksnLe-pR-KdyBQmPh3AVjFrQqZYYar1k_F8vgzTodX2ZGlejR9fO1v0qUJUoAY2xeoeygh-dcwsj4yIQ7-2EJIWrfPOuHR8cHrfUOLO4a87BbllBtkCRhSk7RqUlC9oFLVkvfGZot0u2VKcQh6XX073irOdtSbfM6jLfsCAtXViVJgtjlAoMo1r83TWofmp9Xp_-AIwXRoc?type=png
  "CI and CD Procedures"
[linkWindowsPkg]: https://ci.appveyor.com/project/claudioandre-br/johntheripper/build/artifacts "John Windows Package"
[shieldSnap]: https://snapcraft.io/john-the-ripper/badge.svg
[shieldLicense]: https://img.shields.io/badge/License-GPL%20v2-blue.svg
[shieldScore]: https://api.securityscorecards.dev/projects/github.com/openwall/john-packages/badge
[shieldPractices]: https://bestpractices.coreinfrastructure.org/projects/7525/badge
