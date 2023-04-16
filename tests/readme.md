# Continuous Integration and Continuous Delivery

The usage of Continuous Integration and Continuous Delivery is a method to frequently deliver software to users by introducing automation into the stages of application development.

![Donation](https://img.shields.io/badge/Donate-Yes-brightgreen?style=flat&logo=github-sponsors) Please donate. You can make a real difference and help our work by donating to support the CI infra.

## Testing

Using multiple providers, we've created a DevOps infrastructure. We are mostly interested
in quality assurance, CI (continuous integration), and CD (continuous delivery). To achieve
this goal, our testing scheme builds and inspects the source code of John the Ripper
using:

> As Travis.org is gone, I'm giving up on Travis (I asked for OSS credits and received none).

- Microsoft Windows:
  - Windows Server 2019 Datacenter (10.0.17763 N/A Build 17763);
  - Windows Server 2022 Datacenter (10.0.20348 N/A Build 20348);
  - Windows Server 2016 Datacenter (10.0.14393 N/A Build 14393);
- Unix®-like BSD:
  - FreeBSD 12 (12.4-STABLE);
  - FreeBSD 13 (13.2-STABLE);
  - FreeBSD 14 (14.0-CURRENT);
- Linux:
  - CentOS 7 and Fedora 37;
  - Ubuntu 16.04, Ubuntu 18.04, and Ubuntu devel (the under development version);
- Compilers:
  - gcc 4.8 (CentOS), gcc 5.4 (Ubuntu 16), gcc 7.2 (fuzzing), gcc 7.4 (Win 2016), gcc 7.5 (ubuntu 18), gcc 11.3 (Win 2019/2022), and gcc 12.2 (Fedora 37, Ubuntu Dev, Flatpak);
  - FreeBSD clang version 13.0.0
  - FreeBSD clang version 14.0.5
  - FreeBSD clang version 15.0.7
- Builds:
  - LE (Little Endian) and BE (Big Endian) builds;
  - ASAN (address sanitizer) and UBSAN (undefined behavior sanitizer);
  - Fuzzing (<https://en.wikipedia.org/wiki/Fuzzing>);
  - CygWin on Windows Server;
  - OpenCL on CPU using Intel, and POCL (<http://portablecl.org/>) runtimes;
  - OpenCL on GPU using Azure cloud (_work in progress_);
  - And a final assessment using ARMv7 (armhf), ARMv8 (aarch64), PowerPC64 Little-Endian,
and IBM System z.

Plans and future vision:

- Develop a fully automated build and release pipeline using Azure DevOps Services
  to create the CI/CD pipeline and Azure Services for deploying to development/staging and
  production.
  See the [release workflow here](https://github.com/openwall/john-packages/blob/master/tests/CI-workflow.pdf).

#### Supported and Tested SIMD Extensions

| Architecture | SIMD |
| :-: | :-: |
| ARM v7<br>ARV v8 | NEON<br>ASIMD |
| PowerPC | Altivec |
| RISC-V 64 | SIMD is not supported |
| S390x | SIMD is not supported |
| x86| AVX512BW, AVX512F, AVX2, AVX, SSE2<br>Not tested anymore: XOP, SSE4.2, SSE4.1, SSSE3 |

#### Builds and Artifacts

| Provider   | OS | Artifacts |
| ------------- | ------------- | ----- |
| AppVeyor CI | Windows | ✓ Build artifacts available |
| Azure | Linux | ✗ No build artifacts |
| Azure | Windows | ✓ Deployed to GitHub Releases |
| Azure | OpenCL on GPU | ∅ Under development |
| Circle CI | Linux | ✗ No build artifacts |
| Circle CI | MacOS | ✓ Deployed to GitHub Releases |
| Cirrus CI | FreeBSD | ✗ No build artifacts |
| GitLab CI | Linux (FlatPak app) | ✓ Deployed to GitHub Releases |
| LaunchPad | Linux (Snap app) | ✓ Deployed to Snap Store |
| GitHub Actions | Linux (Docker image) | ✓ Deployed to GitHub Releases |

## Obsolete Architectures

We can no longer build and package for these environments:

* Intel/AMD X86 32 bits (i386);
* PowerPC 32 bits (powerpc).