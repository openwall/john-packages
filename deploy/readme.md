# Deployments

We use premium build providers like Azure Cloud, Launchpad, and GitLab.

![Donation](https://img.shields.io/badge/Donate-Yes-brightgreen?style=flat&logo=github-sponsors) Please donate. You can make a real difference and help our work by donating to support the infra.

## Release Process

![Release Process](https://mermaid.ink/img/pako:eNqFkm9r2zAQxr_KoVcbNCmBUkYwHom9tmExDfPGBnFenK1LImxLQpa6P3G--yRnjLWYTq8eSfe753SnE6sUJzZnB4P6CJ_TQoJfi-0GqxoPQh52MJnE_aqDZAWqft_D8k1UmjhD6bCB3KKxToeT6XT69kIvAwLL2faeLOTKmYog8TYh6s6oFr7ozhrCdvcnfjYAyWlj1JPgZLrz5SIZvO-FXWPp_XtIt3uc73HCqaut0jBkbNBusN79i6zRyeqokffwYQTJJerdC4sHV8KiskLJroe7EShVVU0mqFWLB3rGL345Q5DS0-Mm7-FhhP4qJFffuyBvb0phn-H0Q5MRLUmLTYhYCmtER5CpUjSXvNpX9XEk70JyowQf5KcMCL69uw2bSMSRi6UCPQySomsXR9ciftU3EaZqKDR6PWKVYfWYB-EtXk3zspvZ2AhUg_6NMJtNb_425T-FsyvWkmlRcP9hT6GCgtkjtVSwuZec9ugaW7BCnn0oOqvyn7Jic2scXTGnOVpKBfqv3jJfT9PR-Tfch_0Z?type=png)

## John the Ripper rolling (1.9.0 Jumbo 1+) release build environments

#### Docker Image

- gcc version: 12.2.0

```text
docker image ubuntu:22.04
sha256:b360d85af0582af0c4600f79b07c5f26de432af3fb4e52b6aa302ff6c9a62d4b
```

#### Flatpak

- gcc version: 11.3.0

```text
docker image ghcr.io/claudioandre-br/john-ci:fedora.37.flatpak
sha256:30c286f6f37b72d7d4e4deff3e04bcb2255dbc03cc5951d408a341903ba1a167
VERSION="22.08 (Flatpak runtime)"
```

#### Snap

- gcc version: 7.5.0

```text
DISTRIB_DESCRIPTION="Ubuntu 18.04.6 LTS"
snapcraft (7.x/stable) 7.3.1 from Canonical** installed
Setting up snapd (2.58+18.04)
```

#### Windows

- gcc (GCC) 11.3.0

```text
OS Name:                   Microsoft Windows Server 2019 Datacenter
OS Version:                10.0.17763 N/A Build 17763
Current image version: '20230326.1'
Chocolatey v1.3.1
Cygwin 3.4.6
```
