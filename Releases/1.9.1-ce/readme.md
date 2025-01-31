# Deployments

One of the most attractive things about running an application in a container (like Flatpak, Snap or Docker) is that
once it’s built successfully, you can expect it to keep working for a long time, even as you upgrade your OS. Obviously
there are limits to that.

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
