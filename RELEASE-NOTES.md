# Release Notes

## Release [rolling-2404](https://github.com/openwall/john-packages/releases/tag/rolling-2404) (2024-04-05)

Version `1.9J1+2404`. This is a maintenance release:

April’s bugfix release.

### Breaking Changes

- Due to hardware unavailability, we have stopped building the macOS X86 (Intel CPU) package;
- Due to hardware limitations, we have stopped building SSE2 binaries (only on Linux for now).

### Bugfixes

- Some random bugfixes here and there.

### Improvements

- Add arm64 Docker image (with NVIDIA GPU support);
- Add new formats and/or implementations;
  - Armory wallet, Keplr wallet, Argon2 OpenCL.
- \*2john improvements;
  - Add a modern version of pdf2john (.py; Python 3).
- Improve OpenCL detection;
  - Start using dynamic OpenCL binding (dynamically load OpenCL library);
  - Add Khronos Group OpenCL header files (use this local copy of the OpenCL headers);
- Some random optimizations here and there;
- Minor documentations tweaks.

### Binaries Available

- Docker (for X86_64 and aarch64) with NVIDIA GPU support (via OpenCL);
- Flatpak;
  - bundle (for X86_64);
  - via FlatHub (for X86_64 and aarch64).
- macOS (for M1 and above);
- Snap (for X86_64, armhf, arm64, ppc64el, riscv64, and s390x);
- Windows (for X86_64).

All except s390x and riscv64 binaries support SIMD.

---

## Release [rolling-2310](https://github.com/openwall/john-packages/releases/tag/rolling-2310) (2023-10-05)

This is the `john-packages` (itself) 0.9 release 'v0.9.0'. October 2023 (version 0.9.0)

### Breaking Changes (2310)

- Due to changes in Cygwin, plus OS and hardware unavailability in common cloud build environments,
  we deprecate 32 bits architectures.
  - For now, Canonical snap packages for armhf can still be created.
- Intel-based macOS resources are sunsetting everywhere.
  - Probably the rolling-2310 will be the last release for this architecture.

### Bugfixes (2310)

- Important bugfixes in ZIP and Office formats;
- A lot of minor and important bugfixes everywhere.

### Improvements (2310)

- Sign all releases on GitHub releases, from now on;
- Turn John the Ripper Docker image into a digitally signed image using Sigstore;
- Add a provenance file to the Docker image;
  - Make it compliant with OpenSSF SLSA 3.
- Add a macOS package;
- Add OpenCL support to the John the Ripper Docker image;
- Add extensive use of Continuous Integration (CI). See [the CI and CD](https://github.com/openwall/john-packages/tree/main/scripts#continuous-integration-and-continuous-delivery) procedures;
- Add a lot of automatic QA checking to the john-packages repository;
- Add new formats and/or implementations;
- Improve formats detection and valid() implementations;
- Improve John the Ripper portable hi-res timer for nano-second resolution on most archs;
- Improvements on NVIDIA OpenCL BusyWaits;
- Improvements and tweaks to john's usage of autoconf;
- A lot of minor and important improvements everywhere.

### Other Changes (2310)

- None.

### Binaries Available (2310)

All except s390x and riscv64 binaries support SIMD.

- Docker (for X86_64);
- Flatpak;
  - bundle (for X86_64);
  - via FlatHub (for X86_64 and aarch64).
- macOS X86 (Intel Hardware): via AVX and AVX2;
- macOS M1 and above: via ASIMD;
- Snap (for X86_64, armhf, arm64, ppc64el, riscv64, and s390x);
- Windows (for X86_64).

---

## Old "stable" release [1.9.0-jumbo-1](https://github.com/openwall/john-packages/releases/tag/1.9.0-jumbo-1)

Notes and general information

### Windows package

- the stable John 1.9.0 Jumbo 1:
  - is available for X86_64 and i386;

### Snap package

- the stable John 1.9.0 Jumbo 1:
  - is available for X86_64, armhf, arm64, ppc64el, i386, powerpc, and s390x;
  - has regular expression mode available;

### Flatpak package

- the stable John 1.9.0 Jumbo 1:
  - is available for X86_64, arm, aarch64, and i386 (available in Flathub);
  - has regular expression mode available;

### Docker Image

- the stable John 1.9.0 Jumbo 1 (`ghcr.io/openwall/john:v1.9.0J1`):
  - has ztex formats available.

---
