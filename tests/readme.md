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
  - Windows Server 2016 Datacenter (10.0.14393 N/A Build 14393);
  - Windows Server 2019 Datacenter (10.0.17763 N/A Build 17763);
- Unix®-like BSD:
  - FreeBSD 11 (11.3-STABLE);
  - FreeBSD 12 (12.1-STABLE);
  - FreeBSD 13 (13.0-CURRENT);
- Linux:
  - CentOS 7 and Fedora 34;
  - Ubuntu 16.04, Ubuntu 18.04, and Ubuntu devel (the under development version);
- Compilers:
  - gcc 5.4, gcc 7.2, gcc 7.5, gcc 10.2, and gcc 11.1;
  - FreeBSD clang version 8.0.1
  - FreeBSD clang version 10.0.0
  - FreeBSD clang version 11.0.1
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
| ARM | NEON, ASIMD |
| PowerPC | Altivec |
| S390x | SIMD is not supported |
| x86| AVX512BW, AVX512F, AVX2, XOP, AVX, SSE4.2, SSE4.1, SSSE3, SSE2 |

#### Development Builds and Artifacts

| Provider   | OS | Artifacts |
| ------------- | ------------- | ----- |
| AppVeyor CI | Windows | ✓ Build artifacts available |
| Azure | Linux and Windows | ✓ Build artifacts available |
| Azure | OpenCL on GPU | ∅ Under development |
| Circle CI | Linux | ✗ No build artifacts |
| Cirrus CI | FreeBSD | ✗ No build artifacts |
| GitLab CI | Linux (FlatPak app) | ✓ Build artifacts available |
| LaunchPad | Linux (Snap app) | ✓ Build artifacts available |
| Travis CI | Linux and macOS | ✗ No build artifacts |
| GitHub Actions | Linux | ✓ Deployed to GitHub Artifacts |