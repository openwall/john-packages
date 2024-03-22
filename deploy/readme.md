# Deployments

We use premium build providers like Azure Cloud, Launchpad, and GitLab.

At the time of this writing, `john` is known to build and work on:

* Android NDK r23b (on ARM and X86)
* FreeBSD (tested with 13 and later on X86)
* Linux (kernel 6 or later recommended)
* macOS (on ARM)
* Solaris (tested with 11 on X86)

Also in the following Windows environments:
* Microsoft Windows (Windows 10 / Windows Server 2016) or later
* Mingw + Wine (64-bit), using an ancient Fedora Docker image
* Cygwin (64-bit)

At previous version rolling-2310, `john` is also known to build and work on:

* FreeBSD 12
* macOS (on X86)
* Mingw + Wine (32-bit), using an ancient Fedora Docker image

## Release Process

![Release Process](https://mermaid.ink/img/pako:eNptkV1rwjAUhv_KIVcbqCCMXZTh0HZ-gGJZN3Zhe3GaxBpqkpImjs3635fWXczRXL0k73MewjkTqhknASkMVgd4i1IF_kx3MdISC6GKDIbDSbOqIVyBLp8bmN095WayQeXwCIlFY13V3oxGo_srPWsRmI13C24h0c5QDqHXtK250RLeq9oajjL77Y87IDzHRp8E46a-XB_Czr0Qdo259zcQ7fYY7HHIeF1aXUE38Yg2xjL7i6zRKXqokDXw0oMkCqvsn2LpcphSK7SqG5j3QJGmJTdtWkks-A0__XaGQ8RP2zhpYNlDfwjF9GfdxseHXNgbPBTGuLr74baHlUi3SRumr5uMDIjkRqJgfmvndkpK7IFLnpLAR4amTEmqLr6HzurkS1ESWOP4gLiKoeWRQL9sSbzlWPPLD54Jpsw?type=png)

## John the Ripper rolling (1.9.0 Jumbo 1+) release build environments

Build date: 2023-09-20 (rolling-2310)

### Docker Image

```text
FROM nvidia/cuda:12.2.0-base-ubuntu22.04@sha256:f8870283bea6a85ba4b4a5e1b65158dd15e8009e433539e7c83c94707e703a1b
```

### Flatpak

```text
runtime: org.freedesktop.Platform 22.08
```

### macOS

```text
Darwin 22.6.0 arm64 arm
Homebrew 4.2.10
```

### Snap

```text
runtime: core22
Launchpad --series=jammy
```

### Windows

```text
OS Name:                   Microsoft Windows Server 2019 Datacenter
OS Version:                10.0.17763 N/A Build 17763
Current image version: '20230912.1.0'
Cygwin 3.4.10
```

## Deprecation Note (Obsolete Software or Hardware)

We can no longer build and package for these environments:

* Any 32-bit build (e.g. i386, i686, and powerpc);
* Windows 8 or older (64-bit);
* Windows Server 2012 or older (64-bit);
* Intel-based macOS;
* Older X86_64 CPUs (AVX required);

If you need such a build, use a previous stable or rolling release.
