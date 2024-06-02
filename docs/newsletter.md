# News and Plans

Welcome to May’s edition of the Newsletter!

I emphasize that **everyone should upgrade to `1.9J1+2404` (rolling-2404)**, the latest release, or its corresponding upstream commit:

- it contains several bugfixes, including some important ones related to formats bugs and OpenCL NVIDIA on Windows;
- it contains several important improvements such as "opportunistic dupe suppression";
- is stable and reliable at this time:
  - only small and "safe" changes were introduced recently.

> [!IMPORTANT]
>
> _Create a backup of your pot and session files_ before updating:
>
> - these files reside in the `.john` folder within your home folder;
> - for snap package users, find the `.john` folder inside `$HOME/snap/john-the-ripper`.

Besides:

> [!CAUTION]
>
> 🔍 Please **use discretion when accessing sites that claim to be sources for John the Ripper download**.

Also:

- we are trying to attract contributors. We need pull request (PR) reviewers;
  - easy task to do:
    - if you find something: good;
    - if not: we'll find out later.
  - see [issue/#186](https://github.com/openwall/john-packages/issues/186).
- we stopped merging unreviewed (non-essential) commits;
  - if a commit is not essential for maintaining the repository, it will wait for a reviewer.
  - pull requests related to this rule/criteria are labeled 'help wanted'.

## Project Next Steps: what will happen

- Remove 32-bit snap armhf build; i386 is already deprecated in ubuntu-core; [2024]
- Stop building SSE2 binaries. Spare hardware and build time; [2024]
  - AVX is already required for a list of well-known consumer software.
- Update flatpak package runtime to Flatpak SDK 24.08. [2025]
- Update snap package runtime to Ubuntu 24.04. [2025]
- Update macOS build environment to macOS 14 Sonoma. [2025]

[1] If a commit is not essential for maintaining the repository, it will wait for a reviewer.
Pull requests related to this rule/criteria are labeled 'help wanted'.

## Project Expectations: what will probably (is expect to) happen

- [NOTHING yet];

## Recommendation

Install (or update your installation to) `1.9J1+2404` (**rolling-2404**) or to the upstream commit
[f9fedd2](https://github.com/openwall/john/commit/f9fedd238b0b1d69181c1fef033b85c787e96e57).
