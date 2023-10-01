# News and Plans

Welcome to October’s edition of the Newsletter!

I think that **everyone should upgrade to rolling-2310** or its corresponding upstream commit:
- it contains several bugfixes, including some important ones related to formats bugs and OpenCL NVIDIA on Windows;
- is stable and reliable at this time:
  - only small and tested changes were committed recently;
  - it was recently tested by the "Crack Me If You Can 2023" team.

Important note: _create a backup of your pot and session files_ before updating:
- these files reside in the `.john` folder within your home folder;
- for snap package users, find the `.john` folder inside `$HOME/snap/john-the-ripper`.

BTW: FlatHub's `john` package has also been updated to be paired with **rolling-2310**.

## Project Next Steps: what will happen

* Migrate to Flatpak 23.08 runtime; [after the release of rolling-2310]
* Remove macOS Intel build package and references; [until December 2023]
  * will probably be removed after the next john-dev release (if there is one this year);
  * in fact, it is already broken;
* Remove 32-bit snap armhf build; i386 is already deprecated in ubuntu-core. [soon]

## Project Expectations: what will probably (is expect to) happen

* Stop building SSE2 binaries. Spare hardware and build time; [soon]
  * AVX is already required for a list of well-known consumer software.
* Remove Solaris references (sort of a consequence of macOS deprecation).

## Recommendation

Install (or update your installation to) **rolling-2310** or to the upstream commit
[39db7dd](https://github.com/openwall/john/commit/39db7dd63e3fefb343c3dbb72eaa5c7599b6c298).
