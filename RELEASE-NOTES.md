# Release Notes

The X86_64 binaries require either AVX, AVX2, AVX512F or AVX512BW.

## Release [1.9.1-ce](https://github.com/openwall/john-packages/releases/tag/v1.9.1-ce) (2024-06-20)

Version `1.9.1-ce`. This is a bugfix, renovate, and update release intended to provide a
modernized version to end users and packagers:

### Breaking Changes

- From now on, we have stopped building SSE2 binaries;
- From now on, we will discontinue all builds for 32-bit architectures.

### Bugfixes

- Minor and important bugfixes.

### Improvements

- Add new formats and/or implementations;
  - Add a new SM3 hash function.
- Add SLSA level 1 to GitHub Releases;
- Add more details and traceability to the produced build logs;
- Update dependencies and pin dependency versions to improve repeatability and security;
- Add `Combinator` external mode (combines words in pairs);
- Provide packages via `zip` archive and avoid the risk and need of using `7zip`.

### Binaries Available

- Docker (for X86_64 and aarch64) with NVIDIA GPU support (via OpenCL);
- Flatpak;
  - bundle (for X86_64);
  - via FlatHub (for X86_64 and aarch64).
- macOS (for M1 and above);
- Snap (for X86_64, armhf, i386, arm64, ppc64el, riscv64, and s390x);
- Windows (for X86_64).

All except s390x and riscv64 binaries support SIMD.

---

## Release Notes for Previous Versions

- [Jumbo 1 release](Releases/1.9.0.J1/RELEASE-NOTES.md)
- [Rolling releases](Releases/rolling/RELEASE-NOTES.md)

---

## Monitoring and Controlling Phase

All the features we were interested in implementing were implemented. We consider it done!

Therefore, the repository now enters a **frozen stage**. Nothing new will be developed.

The bots will continue to select and submit updates for all dependencies, and a human will
evaluate and integrate them. But only this.

Rolling releases will no longer be published: it is not correct to choose a version at random;
this kind of thing needs to happen in the upstream repository.
