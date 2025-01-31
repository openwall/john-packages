# Release Notes

The x86_64 binaries require either AVX, AVX2, or AVX512BW.

## Release [1.9.2-ce](https://github.com/openwall/john-packages/releases/tag/v1.9.2-ce) (20xx-xx-xx)

Version `1.9.2-ce`. This is a bugfix, renovate, and update release intended to provide a modernized version to end users
and packagers:

### Improvements

- Add new formats and/or implementations;
  - Add support for EC SSH keys encrypted with AES-256-CBC.
- Optimize the Monero format.

### Binaries Available

- Docker (for x86_64 and aarch64) with NVIDIA GPU support (via OpenCL);
- Flatpak;
  - bundle (for x86_64);
  - via FlatHub (for x86_64 and aarch64).
- macOS (for M1 and above);
- Snap (for x86_64, aarch64, ppc64el, riscv64, and s390x);
- Windows (for x86_64).

All except s390x and riscv64 binaries support SIMD.

---

## Release Notes for Previous Versions

- [1.9.1 CE release](Releases/1.9.1-ce/RELEASE-NOTES.md)
- [Rolling releases](Releases/rolling/RELEASE-NOTES.md)
- [Jumbo 1 release](Releases/1.9.0.J1/RELEASE-NOTES.md)

---

## Monitoring and Controlling Phase

All the features we were interested in implementing were implemented. We consider it done!

Therefore, the repository now enters a **frozen stage**. Nothing new will be developed.

The bots will continue to select and submit updates for all dependencies, and a human will evaluate and integrate them.
But only this.

Rolling releases will no longer be published: it is not correct to choose a version at random; this kind of thing needs
to happen in the upstream repository.
