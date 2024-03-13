# Contributing

When contributing to this repository, please first discuss the change you wish to make via issue, email,
or any other method with the owners of this repository before making a change.
- If you have questions, please ask them first in the mailing list john-users at lists.openwall.com;
- Use GitHub issues to keep track of ideas, enhancements, tasks, and bugs. NEVER as a support forum;
- We prefer signed (and verified) commits just because:
  - The author is the person whose name is on the commit.
  - The code change is really what the author wrote.

Please note we have a code of conduct, please follow it in all your interactions with the project.

By the way, we have a bot that automatically closes issues after a certain amount of time unless someone
specifically mark them "keep open". Reopened issues will receive attention.

Contributors donate their free time to work on the project because they enjoy it. If nobody cares about
a problem it will likely remain open forever, lost in a list of issues that no one minds. The
contributors have other things to do, like live their lives.

I think it's reasonable to expect users to try a little harder to help, if they care about something.

## Bug Reports

Try to be clear about your environment and what you are doing. Do your best and share a sample hash or
file that can be used to reproduce.

## Scope and Goals

The project aims to create and maintain packages for John the Ripper executables. Also, maintain tools to
support the development and use of John the Ripper software.

The `*2john` tools need a Docker image containing Python 2 and Python 3 and other dependencies
properly installed and configured; however, this repository is not suitable for that.

The keywords are: cloud, Docker, hardening, sandboxing, IDE, Continuous Delivery.

## Our Responsibilities

Project maintainers are responsible for clarifying the standards of acceptable
behavior and are expected to take appropriate and fair corrective action in
response to any instances of unacceptable behavior.

Project maintainers have the right and responsibility to remove, edit, or
reject comments, commits, code, wiki edits, issues, and other contributions
that are not aligned to the Code of Conduct, or to ban temporarily or
permanently any contributor for other behaviors that they deem inappropriate,
threatening, offensive, or harmful.

## Other sources of information

For various tips and tricks, also see [the docs folder](https://github.com/openwall/john-packages/tree/main/docs),
[our wiki](https://github.com/openwall/john-packages/wiki/), and [Openwall's wiki](https://openwall.info/wiki/john).

## Patterns

We adhere to standards used by the community.

We use linters and static code analyzers that will complain about rule violations. Furthermore, we recommend
that, if possible, before submitting your contribution you run the `pre-commit run --all-files` command.

The row length should be between 80 and 120 columns, which is good for use on modern monitors, including
laptops. However, there are some cases where the rule must be overcome by common sense.

## The PR review process

After you open a pull request, you as the author are responsible for resolving:

- Handle CI failures from the automated tests.
- Resolve merge conflicts with the main branch.
- Be responsive to feedback. This means being prepared to make changes to the pull request based on the review.
- Be patient during the review process.
- Don't reopen closed pull requests. If you must create a new pull request, it can reference the closed one.

We are going to do our best to follow [these advices.](https://phauer.com/2018/code-review-guidelines/#code-reviews-guidelines-for-the-reviewer)

## PR acceptance criteria

- The submitted code is correct.
- The resulting behavior is desired and considered useful for the project.
- Maintainers and committers agree to maintain the added code.

### During review, Pull Requests should be checked against these requirements

- The change provides enough value to be worth merging, and is coherent with the rest of the project.
- The code is clear enough, and it includes all the necessary comments to understand it.
- The PR complies with the contribution guidelines, including:
  - The PR targets right branch.
  - The nature of the change and the author’s reasoning is clear.
  - The PR is clear about whether the change should be included in the NEWS file.
  - The change address the issue the PR is intended to fix/implement.
  - The PR stays within scope to address only that issue.
  - The PR provides clear instructions to verify that the change works as expected.
  - All the files include the right licence headers.
  - Any and all breaking changes have been described in the PR body.
  - Any and all deprecations have been described in the code and in the PR body.
  - The changes are covered by automated tests (where possible), and those tests cover all relevant edge cases.
  - The changes don’t introduce evident regressions nor degrade the software quality in any way. If a
    compromise is being done, it has been documented.

## Merging procedures

We prefer fast-forward merges, and in the case of GitHub, this requires the CLI. But this only makes sense
for signed (and verified) commits, otherwise the approver should use the GitHub GUI.

The author and the approver should run these commands. The PR on GitHub will close automatically.

Author:
```bash
  # git checkout <branch>
  # -- the PR author must have his/her branch updated --
  # if upstream repo: git pull --rebase origin main
  # if forked repo:   git pull --rebase git@github.com:openwall/john-packages.git
  # commit using -S and --signoff
```

PR approver:
```bash
  # Using upstream repository and an up-to-date local copy of the PR branch.
  git checkout main
  git pull --rebase origin main
  git merge --ff-only <branch>
  git push -u origin main
```

When releasing a new version, create a signed tag, then access and use the GitHub GUI:
```bash
  git tag <tag> -m "release: <tag>" # e.g., rolling-2310
  git tag --verify <tag>
  git push --tags
```

To create signed GitHub releases:
```bash
# Create a release
# Download the tarball <name>.tar.gz generated by GitHub, then
gpg --armor --detach-sign THE-DOWNLOADED-TARBALL-RELEASE-FILE.tar.gz
```

## License

The content of this repository is released under GNU GPL v2.
