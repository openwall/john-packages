# Release Notes

The x86_64 binaries require either AVX, AVX2, or AVX512BW.

Due to harmful bugs, I have no choice but to create a new emergency release (202502).

This is release version 'v0.9.9' of `john-packages' itself. February 2025 (version 0.9.9).

## Release [1.9.1-ce](https://github.com/openwall/john-packages/releases/tag/v1.9.1-ce) (2025-02-01)

Version `1.9.1-ce`. This is a bugfix, renovate, and update release intended to provide a modernized version to end users
and packagers:

### Breaking Changes

- From now on, we have stopped testing on Android;
- From now on, we have stopped building SSE2 binaries;
- From now on, we have stopped building AVX512F binaries;
- From now on, we will discontinue all builds for 32-bit architectures;
- From now on, we will not create rolling releases.

### Bugfixes

- Fix PDF format; [1]
  - Bugfix for rev. 3 documents with RC4-40 as well as rev. 2-4 documents with key length other than 40 or 128 bits.
- Fix o5logon format to support passwords longer than 16; [1]
- Minor and important bugfixes.

[1] A correction like this in a format can imply that false negatives may have occurred in the past.

### Improvements

- Add new formats and/or implementations;
  - Add a new SM3 hash function;
  - Add Astra Linux crypt variants (GOST R 34.11-94 or GOST R 34.11-2012);
  - Add PDF OpenCL;
  - KeePass: support KDBX4 database and Argon2;
  - Add support for EC SSH keys encrypted with AES-256-CBC (incomplete support).
- \*2john improvements;
  - Add a modern version of bitlocker2john (.py; Python 3);
  - Add a modern version of fvde2john (.py; Python 3);
  - Add oracle2john.py (.py; Python 3).
- Drop old AES-NI code in favor of AES code from mbedTLS;
  - Support for AES-NI (Intel) and AES-CE (Arm).
- Add SLSA level 1 to GitHub Releases;
- Add more details and traceability to the produced build logs;
- Update dependencies and pin dependency versions to improve repeatability and security;
- Add `Combinator` external mode (combines words in pairs);
- Add `Shuffle` external mode (tries permutations of characters);
- Provide packages via `zip` archive and avoid the risk and need of using `7zip`;
- Upgrade Unicode to version 16.0.0.

### Binaries Available

- Docker (for x86_64 and aarch64) with NVIDIA GPU support (via OpenCL);
- Flatpak;
  - bundle (for x86_64);
  - via FlatHub (for x86_64 and aarch64).
- macOS (for M1 and above);
- Snap (for x86_64, aarch64, ppc64el, riscv64, and s390x);
- Windows (for x86_64).

All except s390x and riscv64 binaries support SIMD.
