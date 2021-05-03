# Continuous Integration and Continuous Delivery

The usage of Continuous Integration and Continuous Delivery is a method to frequently deliver software to users by introducing automation into the stages of application development.

![Donation](https://img.shields.io/badge/Donate-Yes-brightgreen?style=flat&logo=github-sponsors) Please donate. You can make a real difference and help our work by donating to support the CI infra.

## Testing

Using multiple providers, we've created a DevOps infrastructure. We are mostly interested
in quality assurance, CI (continuous integration), and CD (continuous delivery). To achieve
this goal, our testing scheme builds and inspects the source code of John the Ripper
using:

- Microsoft Windows:
  - Windows Server 2012 R2 Datacenter (6.3.9600 N/A Build 9600);
  - Windows Server 2016 Datacenter (10.0.14393 N/A Build 14393);
  - Windows Server 2019 Datacenter (10.0.17763 N/A Build 17763);
- Unix®-like BSD:
  - FreeBSD 11 (11.3-STABLE);
  - FreeBSD 12 (12.1-STABLE);
  - FreeBSD 13 (13.0-CURRENT);
- MacOS:
  - macOS 10.13 (Darwin Kernel Version 17.4.0);
  - macOS 10.14 (Darwin Kernel Version 18.5.0);
  - macOS Universal Apps (Darwin Kernel Version 19.5.0);
- Linux:
  - CentOS 7 and Fedora 32;
  - Ubuntu 12.04, Ubuntu 14.04, Ubuntu 16.04, Ubuntu 18.04, Ubuntu 20.04, and Ubuntu 21.04;
- Compilers:
  - gcc 4.6, gcc 4.8, gcc 5.4, gcc 7.2, gcc 7.4, gcc 7.5, gcc 9.2, gcc 9.3, gcc 10.2, and gcc 11.0;
  - clang 5.0, clang 7.0, and clang 10.0;
  - FreeBSD clang version 8.0.1
  - FreeBSD clang version 10.0.0 
  - FreeBSD clang version 11.0.1
  - Xcode 10.3; Apple LLVM version 10.0.1 (clang-1001.0.46.4)
  - Xcode 11.6; Apple clang version 11.0.3 (clang-1103.0.32.62)
  - Xcode-12.2; Apple clang version 12.0.0 (clang-1200.0.32.27)
- Builds:
  - SIMD and non-SIMD builds;
  - OpenMP and non-OpenMP builds;
  - LE (Little Endian) and BE (Big Endian) builds;
  - ASAN (address sanitizer) and UBSAN (undefined behavior sanitizer);
  - Fuzzing (<https://en.wikipedia.org/wiki/Fuzzing>);
  - MinGW and Wine on Fedora Linux;
  - CygWin on Windows Server;
  - OpenCL on CPU using Apple, Intel, and POCL (<http://portablecl.org/>) runtimes;
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
