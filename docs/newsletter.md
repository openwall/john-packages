# News and Plans

Welcome to December’s edition of the Newsletter!

I emphasize that **everyone should upgrade to rolling-2310** or its corresponding upstream commit:
- it contains several bugfixes, including some important ones related to formats bugs and OpenCL NVIDIA on Windows;
- is stable and reliable at this time:
  - only small and "safe" changes were introduced recently.

Important note: _create a backup of your pot and session files_ before updating:
- these files reside in the `.john` folder within your home folder;
- for snap package users, find the `.john` folder inside `$HOME/snap/john-the-ripper`.

Also:
- we are now regularly building snap for RISC-V 64-bit (riscv64);
- we are trying to attract contributors. We need pull request (PR) reviewers;
  - easy task to do:
    - if you find something: good;
    - if not: we'll find out later.
  - see [issue/#186](https://github.com/openwall/john-packages/issues/186).

## Project Next Steps: what will happen

* Remove 32-bit snap armhf build; i386 is already deprecated in ubuntu-core; [2024]
* Stop building SSE2 binaries. Spare hardware and build time; [2024]
  * AVX is already required for a list of well-known consumer software.
* Stop using CentOS 7 (CI is complaining that the execution environment available on it is too old). [2024]

## Project Expectations: what will probably (is expect to) happen

* [NOTHING yet];

## Recommendation

Install (or update your installation to) **rolling-2310** or to the upstream commit
[39db7dd](https://github.com/openwall/john/commit/39db7dd63e3fefb343c3dbb72eaa5c7599b6c298).

* If you are using flatpak obtained via flatHub, please update to version `1.9J1+2310.1`.
* If you are using flatpak bundle, please use the `jumbo-dev` version.
