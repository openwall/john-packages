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

## Release Notes for Previous Versions

- [Jumbo 1 release](Releases/1.9.0.J1/RELEASE-NOTES.md)
- [Previous rolling releases](Releases/rolling/RELEASE-NOTES.md)
