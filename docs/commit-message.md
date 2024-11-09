# How a commit message should be

[Conventional Commits](https://www.conventionalcommits.org/) is a specification that aims to
improve commit messages in general. It defines a standard format for commit messages.

Our Conventional Commits should have the following format:

```text
<type>[(optional <scope>)]: <title> (#PR)

[optional <description>]

[optional <footer(s)>]
```

- Some parts are optional.
- The pull request ID (#PR) is strongly recommended, but not mandatory.
- The first line (title) should ideally be no longer than 50 characters.
  - The title completes the sentence: if applied, this commit will `<title>`.
  - Use the imperative, present tense, not capitalized, no period in the end.
- The pull request ID (#PR) relates the commits to the pull request that contains them.
  - There may have been some discussion that needs to be easily referenced in each commit.
- The body or description should be restricted to 72 characters per line.
  - It should explain the motivation for the change.
- Footers can provide additional metadata for a commit; it can be used to alert readers and
  tools to significant changes such as breaking changes; or can link commits to issues or pull
  requests. They are written using the format:

```text
<token>: <value>
```

A commit message must refer to its purpose and to the problem that motivated its development:

- If the issue a commit refers to is a bug report, add the following text to the
  commit message:
  - Fix: #VALUE.
- If the issue a commit refers to is a feature request, add the following text to
  the commit message:
  - Close: #VALUE.
- Commits may not be exactly a fix or implementation of a feature, but they can be
  related to any issue, in this case, add the following text to the commit message:
  - See: #VALUE.

Examples:

```text
ci: fix package_version.sh script

BREAKING CHANGE: add the version field as a mandatory field to be [...].
```

Or even better:

```text
ci(package_version.sh): fix version string

[...].
```

```text
feat(lang): add french language
```

## Commit Types

The type of a commit message specifies that the change was made for a specific issue or
subsystem. For example, we fixed a bug or added a feature, or perhaps documentation.

To automate the release note or changelog production process we need to ensure rules
are applied. For example:

- A fix commit can increase the patch version number.
- A feat commit can increment the minor version number and reset the patch number.
- A BREAKING CHANGE footer can increment the major version number.

Types are used to automatically classify commits and place them into categories:

|   Type    | Meaning                                                                                       |
| :-------: | :-------------------------------------------------------------------------------------------- |
|   build   | Alters the build tool or external dependencies.                                               |
|   chore   | Includes a technical or preventative maintenance task to the product or the repository. [1]   |
|    ci     | Changes to continuous integration or continuous delivery scripts or configuration files.      |
| deprecate | Deprecates existing functionality, but does not remove it from the product.                   |
|   docs    | The commit adds, updates, or revises documentation.                                           |
|   feat    | The commit implements a new feature.                                                          |
|    fix    | The commit fixes a defect in the application.                                                 |
|   perf    | Improves the performance of algorithms or general execution time of the product. [2]          |
| refactor  | Refactors existing code in the product, but does not change existing behavior in the product. |
|  remove   | Removes a feature from the product. Typically features are deprecated first.                  |
|  revert   | Reverts one or more commits that were previously included.                                    |
| security  | Improves the security of the product or resolves a security issue.                            |
|   style   | Updates or reformats the style of the source code only.                                       |
|   test    | Enhances, adds to, revised, or otherwise changes the suite of automated tests.                |

[1] For example, releasing can be considered a chore. Regenerating generated code could be a chore.\
[2] Does not fundamentally change an existing feature.

## Commit Scopes

<!-- textlint-disable -->

|  Scope  | Meaning                                   |
| :-----: | :---------------------------------------- |
|   ci    | Related to CI/CD features.                |
|  cloud  | Changes to the cloud tool.                |
| docker  | Changes to the Docker recipe or package.  |
| flatpak | Changes to the flapak recipe or package.  |
|   IDE   | Changes to the IDE's folder or files.     |
|  repo   | Related to Git or GitHub's own material.  |
|  snap   | Changes to the snap recipe or package.    |
| windows | Changes to the Windows recipe or package. |

<!-- textlint-enable -->

## Final thoughts

- It is mandatory to use only the **types** seen in the list;
  - Never use a text like `obscure-resource: [MESSAGE]` as the classes/subsystems are only those listed above.
- Other scopes are possible, especially when someone is very interested in citing an `obscure-resource`
  as in the example:

```text
feat(obscure-resource.pl): augment incremental mode
```

- If you have any doubts or would like to see more examples, at [1] and [2] you can find goals and examples that
  explain the reasons behind this effort to standardize.

[1] <https://docs.google.com/document/d/1QrDFcIiPjSLDn3EL15IJygNPiHORgU1_OOAqWjiDU5Y/>\
[2] <https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#type>
