# Continuous Integration and Continuous Delivery

The usage of Continuous Integration and Continuous Delivery is a method to frequently deliver software to users by introducing automation into the stages of application development.

## Testing

Using multiple providers, we've created a DevOps infrastructure. We are mostly interested
in quality assurance, CI (continuous integration), and CD (continuous delivery). To achieve
this goal, our testing scheme builds and inspects the source code of John the Ripper
using:

### Operating Systems (OS)

- Microsoft Windows:
  - Windows Server 2016 Datacenter (10.0.14393 N/A Build 14393);
  - Windows Server 2019 Datacenter (10.0.17763 N/A Build 17763);
  - Windows Server 2022 Datacenter (10.0.20348 N/A Build 20348);
- Unix®-like BSD:
  - FreeBSD 12 (12.4-STABLE);
  - FreeBSD 13 (13.2-STABLE);
  - FreeBSD 14 (14.0-CURRENT);
- Solaris:
  - SunOS Release 5.11 Version 11.4.0.15.0 64-bit;
- Linux:
  - CentOS 7 and Fedora 38;
  - Ubuntu 16.04 (Intel OpenCL for CPUs), Ubuntu 22.04, and Ubuntu devel (the under development version);
  - flatpak (runtime: org.freedesktop.Platform 23.08);
  - snap (runtime: core22);
  - Android NDK r23 LTS (ANDROID_NDK_VERSION=r23b)
- macOS:
  - macOS 13.5.1 22G90:
    - Darwin 22.6.0 arm64 arm;

### Toolchains

- Compilers:
  - gcc 4.8 (CentOS), gcc 5.4 (Ubuntu 16), gcc 7.4 (Win 2016), gcc 9.4 (Android);
  - gcc 11.4 (Ubuntu 22, Snap), gcc 11.4 (Win 2019/2022);
  - gcc 12.2 (Flatpak, fuzzing), gcc 13.2 (Ubuntu Dev, Fedora 38);
  - Solaris gcc (GCC) 7.3.0;
  - FreeBSD clang version 13.0.0;
  - FreeBSD clang version: 16.0.6;
  - FreeBSD clang version: 16.0.6;
  - Apple clang version 15.0.0 (clang-1500.0.40.1);

### Testing and Commissioning

- Builds:
  - LE (Little Endian) and BE (Big Endian) builds;
  - ASAN (address sanitizer) and UBSAN (undefined behavior sanitizer);
  - Fuzzing (<https://en.wikipedia.org/wiki/Fuzzing>);
  - CygWin on Windows Server;
  - OpenCL on CPU using Intel, and POCL (<http://portablecl.org/>) runtimes;
  - OpenCL on GPU using Azure cloud (_work in progress_);
  - And a final assessment using ARMv7 (armhf), ARMv8 (aarch64), PowerPC64 Little-Endian,
and IBM System z.

- Plans and future vision:
  - Develop a fully automated build and release pipeline using Azure DevOps Services
    to create the CI/CD pipeline and Azure Services for deploying to development/staging and
    production.
    See the [release workflow here](https://github.com/openwall/john-packages/blob/main/tests/CI-workflow.pdf);
  - Add support to ClusterFuzz (OSS-Fuzz);
  - Add support to static code quality analyzer.

#### Supported SIMD Extensions

| Architecture | Tested SIMD |
| :-: | :-: |
| ARM v7 | NEON |
| ARM v8 | ASIMD |
| PowerPC | Altivec |
| RISC-V 64 | SIMD is not supported |
| S390x | SIMD is not supported |
| x86| AVX512BW, AVX512F, AVX2, AVX |

| Architecture | Supported but not tested |
| :-: | :-: |
| x86| XOP, SSE4.2, SSE4.1, SSSE3, SSE2 |

#### CI Builds and Artifacts

| Provider   | OS | Artifacts |
| ------------- | ------------- | ----- |
| AppVeyor CI | Windows | ✓ Build artifacts available |
| Azure | Linux | ✗ No build artifacts |
| Azure | Windows | ✗ No build artifacts |
| Azure | OpenCL on GPU | ∅ Under development |
| Bitrise Mobile DevOps | Android | ✓ Build artifacts available |
| Circle CI | Linux | ✗ No build artifacts |
| Cirrus CI | FreeBSD | ✗ No build artifacts |
| GitHub Actions | Solaris | ✗ No build artifacts |

#### Delivery Builds and Artifacts

| Provider   | OS | Artifacts |
| ------------- | ------------- | ----- |
| Azure | Windows | ✓ Deployed to GitHub Releases |
| Cirrus CI | macOS M1 | ✓ Deployed to GitHub Releases |
| GitLab CI | Linux (FlatPak app) | ✓ Deployed to GitHub Releases |
| GitHub Actions | Linux (Docker image) | ✓ Deployed to GitHub Packages |
| LaunchPad | Linux (Snap app) | ✓ Deployed to Snap Store |

## Obsolete Architectures

We can no longer build and test for these environments:

* Any 32-bit build (e.g. i386, i686, and powerpc);
* Windows 8 or older (64-bit);
* Windows Server 2012 or older (64-bit);
* Intel-based macOS;

If you need such a build, use a previous stable or rolling release.
