# Deployments

We use premium build providers like Azure Cloud, Launchpad, and GitLab.

At the time of this writing, `john` is known to build and work on:

- FreeBSD (tested with 13 and later on X86)
- Linux (kernel 6 or later recommended)
- macOS (on ARM)
- Solaris (tested with 11 on X86)

Also in the following Windows environments:

- Microsoft Windows (Windows 10 / Windows Server 2016) or later
- Mingw + Wine (64-bit), using an ancient Fedora Docker image
- Cygwin (64-bit)

In previous versions `john` is also known to build and work on:

- FreeBSD 12 and above
- macOS (on X86)
- Mingw + Wine (32-bit), using an ancient Fedora Docker image

## Builders and Stores

We deploy to Linux app stores like [Canonical Snapcraft](https://snapcraft.io/john-the-ripper) and
[Flathub](https://flathub.org/apps/com.openwall.John). Some information needs to be kept specifically there, and in most
cases a simple copy of the files is not possible. In any case, we do our best to ensure that the integration uses the
same scripts and files contained in this repository.

Unfortunately, some details only reside in the profile of each store. The same rule applies to the release process
powered by Azure.

See also [how to become a maintainer](../docs/become-maintainer.md).

## Release Process

![Release Process](https://mermaid.ink/img/pako:eNptkV1rwjAUhv_KIVcbqCCMXZTh0HZ-gGJZN3Zhe3GaxBpqkpImjs3635fWXczRXL0k73MewjkTqhknASkMVgd4i1IF_kx3MdISC6GKDIbDSbOqIVyBLp8bmN095WayQeXwCIlFY13V3oxGo_srPWsRmI13C24h0c5QDqHXtK250RLeq9oajjL77Y87IDzHRp8E46a-XB_Czr0Qdo259zcQ7fYY7HHIeF1aXUE38Yg2xjL7i6zRKXqokDXw0oMkCqvsn2LpcphSK7SqG5j3QJGmJTdtWkks-A0__XaGQ8RP2zhpYNlDfwjF9GfdxseHXNgbPBTGuLr74baHlUi3SRumr5uMDIjkRqJgfmvndkpK7IFLnpLAR4amTEmqLr6HzurkS1ESWOP4gLiKoeWRQL9sSbzlWPPLD54Jpsw?type=png)

## John the Ripper release build environments

Build date: 2025-01-29 (v1.9.1-ce)

### Docker Image

```text
FROM nvidia/cuda:12.6.3-base-ubuntu24.04@sha256:c87e78933f4c16e3272123bf2f75537306596d0fbaa395a29696a22786e5ee0e
```

### Flatpak

```text
Freedesktop.org SDK 24.08 (Flatpak runtime)
```

### macOS

```text
Darwin 23.6.0 arm64 arm;
Homebrew 4.4.19;
```

### Snap

```text
runtime: core24
```

### Windows

```text
OS Name:        Microsoft Windows Server 2022 Datacenter
ImageVersion    20250120.2.0
Cygwin          3.5.5;
```

<!--
// jscpd:ignore-start
-->

## Deprecation Note (Obsolete Software or Hardware)

> [!IMPORTANT]
>
> We can no longer build and package for these environments:

- Any 32-bit build (e.g. i386, ARM v7, and powerpc);
- Windows 8 or older (64-bit);
- Windows Server 2012 or older (64-bit);
- Intel-based macOS;
- Older X86_64 CPUs (AVX required);

If you need such a build, use a previous stable or rolling release.

<!--
// jscpd:ignore-end
-->

One of the most attractive things about running an application in a container (like Flatpak, Snap or Docker) is that
once it’s built successfully, you can expect it to keep working for a long time, even as you upgrade your OS. Obviously
there are limits to that.
