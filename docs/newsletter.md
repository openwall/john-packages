# News and Plans

Welcome to September’s edition of the Newsletter!

**Everyone should upgrade to `1.9J1+2404`** or its corresponding upstream commit:

- it contains several bugfixes, including some important ones related to formats bugs and OpenCL NVIDIA on Windows;
- it contains several important improvements such as "opportunistic dupe suppression".

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

- end users should **NOT** use the "bleeding" prerelease for day-to-day tasks;
  - instead, they should use the latest released version. See [more here](release-process.md#the-bleeding-release);
  - if you want to use a development version of `john`, use:
    - the snap from the edge channel OR;
    - the docker image labeled bleeding (`ghcr.io/openwall/john:bleeding`);
  - for the time being, we will avoid releasing bleeding versions for Windows or macOS.
- we are trying to attract contributors. We need pull request (PR) reviewers;
  - easy task to do:
    - if you find something: good;
    - if not: we'll find out later.
  - see [issue/#186](https://github.com/openwall/john-packages/issues/186).
- we stopped merging unreviewed (non-essential) commits;
  - if a commit is not essential for maintaining the repository, it will wait for a reviewer.
  - pull requests related to this rule/criteria are labeled 'help wanted'.

## Project Next Steps: what will happen

- [NOTHING yet].

## Project Expectations: what will probably (is expect to) happen

- [NOTHING yet].

## Recommendation

Install (or update your installation to) `1.9J1+2404` (**rolling-2404**) or to the upstream commit
[126b2a4](https://github.com/openwall/john/commit/126b2a4814f24f2ff6486e2c050ecb17072be7ba).
