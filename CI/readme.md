# Continuous Integration and Continuous Delivery

The usage of Continuous Integration and Continuous Delivery is a method to frequently deliver
software to users by introducing automation into the stages of application development.

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
  - FreeBSD 13 (13.4-STABLE);
  - FreeBSD 14 (14.2-PRERELEASE);
  - FreeBSD 15 (15.0-CURRENT);
- Solaris:
  - SunOS solaris 5.11 11.4.42.111.0 i86pc i386 i86pc kvm;
- Linux:
  - Red Hat Enterprise Linux 8 and Fedora 41;
  - Ubuntu 22.04, Ubuntu 24.04, and Ubuntu devel (the under development version);
  - flatpak (runtime: org.freedesktop.Platform 24.08);
  - snap (runtime: core24);
  - Android SDK 34 (on ARM and X86);
- macOS:
  - macOS 14.6 23G80:
    - Darwin 23.6.0 arm64 arm;
    - Homebrew 4.4.2;
- Windows:
  - Cygwin 3.5.4;
  - Chocolatey v2.3.0.

### Toolchains

- Compilers:
  - gcc 7.4 (Win 2016), gcc 8.5 (Red Hat Enterprise Linux 8);
  - gcc 11.4 (Android), gcc 11.4 (Ubuntu 22 - Intel CPU);
  - gcc 12.4 (Win 2019/2022);
  - gcc 13.2 (Ubuntu 24, snap, fuzzing);
  - gcc 14.2 (Fedora 41, Ubuntu Dev), gcc 14.2 (Flatpak);
  - Apple clang version 16.0.0 (clang-1600.0.26.3);
  - FreeBSD clang version 18.1.6 (FreeBSD 13, FreeBSD 14);
  - FreeBSD clang version 19.1.2 (FreeBSD 15);
  - Solaris (GCC) 11.2.0.

### Testing and Commissioning

- Builds:

  - LE (Little Endian) and BE (Big Endian) builds;
  - ASAN (address sanitizer) and UBSAN (undefined behavior sanitizer);
  - Fuzzing (<https://en.wikipedia.org/wiki/Fuzzing>);
  - Cygwin on Windows Server;
  - OpenCL on CPU using Intel, and POCL (<http://portablecl.org/>) runtimes;
  - OpenCL on GPU using Azure cloud (_work in progress_);
  - And a final assessment using ARMv8 (aarch64), PowerPC64 Little-Endian,
    RISC-V 64-bit, and IBM System z.

- Plans and future vision:
  - Develop a fully automated build and release pipeline using Azure DevOps Services
    to create the CI/CD pipeline and Azure Services for deploying to development/staging and
    production.
    See the [release workflow here](https://github.com/openwall/john-packages/blob/main/CI/workflow.pdf);
  - Add support to ClusterFuzz (OSS-Fuzz);
  - Add support to static code quality analyzer.

#### Supported SIMD Extensions

| Architecture |      Tested SIMD      |
| :----------: | :-------------------: |
|    ARM v8    |         ASIMD         |
|   PowerPC    |        Altivec        |
|  RISC-V 64   | SIMD is not supported |
|    S390x     | SIMD is not supported |
|     x86      |  AVX512BW, AVX2, AVX  |

| Architecture |         Supported but not tested          |
| :----------: | :---------------------------------------: |
|    ARM v7    |                   NEON                    |
|     x86      | AVX512F, XOP, SSE4.2, SSE4.1, SSSE3, SSE2 |

#### CI Builds and Artifacts

| Provider              | OS            | Artifacts                   |
| --------------------- | ------------- | --------------------------- |
| AppVeyor CI           | Windows       | ✓ Build artifacts available |
| Azure                 | Linux         | ✗ No build artifacts        |
| Azure                 | Windows       | ✗ No build artifacts        |
| Azure                 | OpenCL on GPU | ∅ Under development         |
| Bitrise Mobile DevOps | Android       | ✓ Build artifacts available |
| Circle CI             | Linux         | ✗ No build artifacts        |
| Cirrus CI             | FreeBSD       | ✗ No build artifacts        |
| GitHub Actions        | Solaris       | ✗ No build artifacts        |

#### Delivery Builds and Artifacts

| Provider       | OS                   | Artifacts                     |
| -------------- | -------------------- | ----------------------------- |
| Azure          | Windows              | ✓ Deployed to GitHub Releases |
| Cirrus CI      | macOS M2             | ✓ Deployed to GitHub Releases |
| GitLab CI      | Linux (FlatPak app)  | ✓ Deployed to GitHub Releases |
| GitHub Actions | Linux (Docker image) | ✓ Deployed to GitHub Packages |
| LaunchPad      | Linux (Snap app)     | ✓ Deployed to Snap Store      |

## Obsolete Architectures

> [!IMPORTANT]
> We can no longer build and package for these environments:

- Any 32-bit build (e.g. i386, ARM v7, and powerpc);
- Windows 8 or older (64-bit);
- Windows Server 2012 or older (64-bit);
- Intel-based macOS;
- Older X86_64 CPUs (AVX required);

If you need such a build, use a previous stable or rolling release.
