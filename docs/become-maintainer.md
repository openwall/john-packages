# How to Become a Package Maintainer

The recipes for creating all packages contained and released by this repository are in the
[deploy](../deploy/) folder.
To use them you will need an umbrella process (a pipeline/a treadmill), but all build steps are
contained in these recipes.

To make information about this repository transparent, how the release process happens and how
to participate in it, I offer the instructions below:

## [Flathub](https://flathub.org/apps/com.openwall.John)

Go to [Flathub](https://flathub.org/apps/com.openwall.John) and ask the Flathub team to become a committer.
Once you create a PR and merge it, a new version of the package will be released to the public.

So you can easily be added to our team.

## [Canonical Store](https://snapcraft.io/john-the-ripper)

You need to create a Launchpad account and a new Snap Store organization (probably named Openwall) and
request to transfer the package `john-the-ripper` (and alias `john`) to this new organization.

There is some information that needs to be stored in the account profile, but nothing too technical.
If the transfer has been made, everything or almost everything is ready.

I'm assuming you will build using Canonical hardware, but this is not necessary. Either way, at the very
least you need an "organization" that is capable of posting packages to the Snap Store.

New members can be added to this organization, but the team changes once the first person in charge
has changed.

## [macOS package](https://github.com/openwall/john-packages/releases/)

You need hardware to build and create the package. Once the package creation is ready, you'll need
to adjust the [package release process](../.github/workflows/release.yml) to:

- create a release (nowadays this is done by Azure);
- import and attach assets to the newly created GitHub Release.

You can use GitHub hosted runners to do that. Conceptually this is a simple task.

The team and the person responsible for it have changed.

## [Windows package](https://github.com/openwall/john-packages/releases/)

You must be able to build binaries, so the same as above applies. Once the package creation is ready,
you'll need to adjust the [package release process](../.github/workflows/release.yml) to:

- create a release;
- import and attach assets to the newly created GitHub Release.

You can use GitHub hosted runners to do that.

The team and the person responsible for it have changed.
