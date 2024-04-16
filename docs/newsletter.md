# News and Plans

Welcome to April’s edition of the Newsletter!

**John the Ripper release mode is on!**. Let's welcome `john` 1.9J1+2404, the latest **rolling release**.

I emphasize that **everyone should upgrade to `1.9J1+2404` (rolling-2404)**, the latest release, or its corresponding upstream commit:

- it contains several bugfixes, including some important ones related to formats bugs and OpenCL NVIDIA on Windows;
- is stable and reliable at this time:
  - only small and "safe" changes were introduced recently.

Important note: _create a backup of your pot and session files_ before updating:

- these files reside in the `.john` folder within your home folder;
- for snap package users, find the `.john` folder inside `$HOME/snap/john-the-ripper`.

Also:

- we are trying to attract contributors. We need pull request (PR) reviewers;
  - easy task to do:
    - if you find something: good;
    - if not: we'll find out later.
  - see [issue/#186](https://github.com/openwall/john-packages/issues/186).

## Project Next Steps: what will happen

- I will rename all `jumbo-dev` or `dev pack` labels and tags to `bleeding`. It is the official name; [soon]
- Remove 32-bit snap armhf build; i386 is already deprecated in ubuntu-core; [2024]
- Stop building SSE2 binaries. Spare hardware and build time; [2024]
  - AVX is already required for a list of well-known consumer software.
- I intend to stop merging unreviewed (non-essential) commits [1]. As we produce binaries,
  it is mandatory to apply good policies. [2024]

[1] If a commit is not essential for maintaining the repository, it will wait for a reviewer.
Pull requests related to this rule/criteria are labeled 'help wanted'.

## Project Expectations: what will probably (is expect to) happen

- [NOTHING yet];

## Recommendation

Install (or update your installation to) `1.9J1+2404` (**rolling-2404**) or to the upstream commit
[f9fedd2](https://github.com/openwall/john/commit/f9fedd238b0b1d69181c1fef033b85c787e96e57).
