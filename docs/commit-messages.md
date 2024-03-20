# How a commit message should be

The commit message must follow the format:

`git commit -m "<title>" -m "<description>"`

* The description is optional.
* The first line (title) should ideally be no longer than 50 characters.
  * The title completes the sentence: if applied, this commit will `<title>`.
  * Use the imperative, present tense, not capitalized, no period in the end.
* The body or description should be restricted to 72 characters per line.
  * It should explain the motivation for the change.

Examples:
```text
tests: fix package_version.sh script

BREAKING CHANGE: add the version field as a mandatory field to be [...].
```

```text
feat(lang): add french language
```

## Commit Types

The type of a commit message specifies that the change was made for a specific issue.
For example, we fixed a bug or added a feature, or perhaps documentation. The type would be “fix”,
“feat”, or “docs”.

| ID | Meaning |
| :-: | :-: |
| CI: | CI tasks. E.g, commit to allow the Docker image to be built without being deployed |
| cloud:| any changes to the cloud tool |
| deploy: | e.g, add the recipe to create a new macOS build/deploy |
| Docker: | any changes to the Docker recipe or package |
| docs: | any changes to .md files or mermaid files |
| flatpak: | any changes to the flapak recipe or package |
| IDE: | any changes to the IDE's folder or files |
| maint:  | general maintenance tasks. E.g., linters |
| packages: | e.g., when you create a new GitHub Action or a patch to apply to all packages |
| release: | when a new version is created |
| snap: | any changes to the snap recipe or package |
| tests: | any changes to test scripts or strategy |
| virustotal: | any changes to virustotal procedures |

Should we add, e.g., "fix"?

I prefer to use something like `Docker: fix build.sh script`
