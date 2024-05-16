# How a commit message should be

The commit message must follow the format:

`git commit -m "<title>" -m "<description>"`

- The description is optional.
- The first line (title) should ideally be no longer than 50 characters.
  - The title completes the sentence: if applied, this commit will `<title>`.
  - Use the imperative, present tense, not capitalized, no period in the end.
- The body or description should be restricted to 72 characters per line.
  - It should explain the motivation for the change.

Examples:

```text
tests: fix package_version.sh script

BREAKING CHANGE: add the version field as a mandatory field to be [...].
```

```text
feat(lang): add french language
```

## Commit Types

The type of a commit message specifies that the change was made for a specific issue or
subsystem. For example, we fixed a bug or added a feature, or perhaps documentation; for
this list of cases the type would be “fix”, “feat” or “docs”.

To automate the release note or changelog production process we need to ensure that only
the IDs seen in the list below will be used to identify commits.

IDs are used to automatically classify commits and place them into categories that will
be listed in the release.

|    ID    |                 Meaning                  |                          Example                          |
| :------: | :--------------------------------------: | :-------------------------------------------------------: |
|   CI:    |                 CI tasks                 | allow the Docker image to be built without being deployed |
|   IDE:   |   changes to the IDE's folder or files   |                                                           |
|  cloud:  |        changes to the cloud tool         |                                                           |
|  docs:   |  changes to .md files or mermaid files   |                                                           |
|  maint:  |        general maintenance tasks         |                          linters                          |
|  snap:   |  changes to the snap recipe or package   |                                                           |
|  tests:  |   changes to test scripts or strategy    |                                                           |
| deploy:  | changes to the delivery/release process  |     add the recipe to create a new macOS build/deploy     |
| Docker:  | changes to the Docker recipe or package  |                                                           |
| flatpak: | changes to the flapak recipe or package  |                                                           |
| release: |  when a new release version is created   |                                                           |
| Windows: | changes to the Windows recipe or package |                                                           |

Final thoughts:

- It is mandatory to use only the IDs seen in the list;
- Never use a text like `obscure-resource.TYPE: [MESSAGE]` as the classes/subsystems are only those listed above;
- Should we add, e.g., "fix" or “feat”?
  - I prefer to use something like `Docker: fix build.sh script`.
