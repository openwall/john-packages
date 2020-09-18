# John the Ripper Packages

[![License](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://github.com/openwall/john-packages/blob/master/LICENSE.txt)

[Snap](http://snapcraft.io/) and [Flatpak](http://flatpak.org/) are cool new ways
of distributing Linux applications among a wide range of different distros. They
are technologies to deploy applications in a secure, sandboxed and containerised way.

```Text
John the Ripper password cracker
```

[Openwall](http://openwall.com/) John the Ripper (JtR) is a fast password cracker,
currently available for many flavors of Unix, Windows, DOS, and OpenVMS. Its primary
purpose is to detect weak Unix passwords. Besides several crypt(3) password hash
types most commonly found on various Unix systems, supported out of the box are
Windows LM hashes, plus lots of other hashes and ciphers.

Know our [Continuous Integration and Continuous Delivery](https://github.com/openwall/john-packages/tree/master/tests#continuous-integration-and-continuous-delivery) procedures.

## Snap

> Built and deployed using Launchpad

[**A Snap**](https://snapcraft.io/) is a fancy zip file containing an application
together with its dependencies, and a description of how it should safely be run
on your system.

You can install JtR by following the instructions at
[https://snapcraft.io/john-the-ripper](https://snapcraft.io/john-the-ripper).

Terminal-based users should [enable snap support](https://docs.snapcraft.io/core/install),
then install JtR like this:

```bash
 sudo snap install john-the-ripper
```

John runs confined under a restrictive security sandbox by default. Nevertheless,
you can access and audit any file located in your home. Below, an usage example:

```bash
 john-the-ripper -list=build-info
 john-the-ripper -list=format-tests | cut -f3 > ~/alltests.in
 john-the-ripper -form=SHA512crypt ~/alltests.in
```

For your convenience, the snap installed on your system contains the file
`/snap/john-the-ripper/current/snap/manifest.yaml` which field `build_url`
points to its build log.

The highlights:

- fallback for CPU[*] and OMP;
- prince mode available;
- OpenCL available (GPU driver installation is needed);
- also available via the alias **john**, e.g. `john -list=build-info`;
- the stable John 1.9.0 Jumbo 1:
  - is available for X86_64, armhf, arm64, ppc64el, i386, powerpc, and s390x;
  - has regex mode available;
- a development version:
  - is available for X86_64, arm64, ppc64el, and s390x.

[*] John the Ripper runs using the best SIMD instructions available on the host
it's running on.

```Text
John the Ripper snap package achieved 5 thousand active users [*].
```

[*] 7 Day Active Users: the number of unique users who had at least one session within a 7 day period.

### Running a non-OpenMP build

In some situations a non-OpenMP build may be faster. You can ask to fallback to a
non-OpenMP build specifying `OMP_NUM_THREADS=1 john <options>` in the command line.
You avail the best SIMD instructions at one's disposal without any OpenMP stuff. E.g.:

```bash
OMP_NUM_THREADS=1 john --list=build-info
```

### Enabling Aliases

You are free to pick and set up aliases. To enable the usage of aliases with John
the Ripper snap, run `sudo snap alias john-the-ripper <alias>`. For example:

```bash
 sudo snap alias john-the-ripper my-john
 sudo snap alias john-the-ripper.dmg2john dmg2john
 sudo snap alias john-the-ripper.hccap2john hccap2john
 sudo snap alias john-the-ripper.racf2john racf2john
 sudo snap alias john-the-ripper.vncpcap2john vncpcap2john
 sudo snap alias john-the-ripper.zip2john zip2john
 sudo snap alias john-the-ripper.gpg2john gpg2john
 sudo snap alias john-the-ripper.keepass2john keepass2john
 sudo snap alias john-the-ripper.putty2john putty2john
 sudo snap alias john-the-ripper.rar2john rar2john
 sudo snap alias john-the-ripper.uaf2john uaf2john
 sudo snap alias john-the-ripper.wpapcap2john wpapcap2john
```

Once enabled, John itself plus the *2john tools can be invoked using the aliases.
In the example, to run John type `my-john`.

### Acessing OpenCL

To run JtR OpenCL version you must install the snap using `developer mode`. It
enables users to install snaps without enforcing security policies. To do this,
you must install John using (**UNTESTED**):

```bash
 sudo snap install john-the-ripper --devmode
```

When installed this way, snaps behave similarly to traditional *.deb* packages in
terms of accessing system resources.

To run JtR OpenCL binary:

```bash
 john-the-ripper.opencl -list=build-info
 john-the-ripper.opencl -list=opencl-devices
```

### Snap Deployments

If you followed the above instructions, you installed the stable version of John
the Ripper Jumbo 1.9.0.J1 in your system. If you want to access the hot and bleeding
developing version of JtR, you must follow a development channel. For a clean
installation:

```bash
 sudo snap install --channel=edge john-the-ripper
```

If you already has JtR installed:

```bash
 sudo snap refresh --channel=edge john-the-ripper
```

If you do so, you will be running the development version available on GitHub.
The average gap expected is 1 week.

## Flatpak

> Built and deployed using FlatHub and GitLab CI

[**Flatpak**](http://flatpak.org//) is a new framework for desktop applications
on Linux, built to be distribution agnostic and allow deployment on any Linux
operating system out there.

Flatpak is available for the [most common Linux distributions](http://flatpak.org/getting.html).

To install JtR, simply run:

```bash
 dnf install -y flatpak # or 'yum install', 'apt-get install', etc.
 flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo # flatpak repository
 flatpak install flathub com.openwall.John
```

~~You can install JtR by following the instructions at
[https://flathub.org/apps/details/com.openwall.John](https://flathub.org/apps/details/com.openwall.John).~~

John runs confined under a restrictive security sandbox by default. Nevertheless,
you can access and audit any file located in your home. Below, an usage example:

```bash
 flatpak run com.openwall.John -list=build-info
 flatpak run com.openwall.John -list=format-tests | cut -f3 > ~/alltests.in
 flatpak run com.openwall.John -form=SHA512crypt ~/alltests.in
```

The highlights:

- fallback for CPU[*] and OMP;
- prince mode available.
- the stable John 1.9.0 Jumbo 1:
  - is available for X86_64, arm, aarch64, and i386;
  - has regex mode available;
- a development version:
  - is available for X86_64.

[*] John the Ripper runs using the best SIMD instructions available on the host
it's running on.

### Flatpak Deployments

If you followed the above instructions, you installed the stable version of John
the Ripper Jumbo 1.9.0.J1 in your system. If you want to access the hot and bleeding
developing version of JtR, you must install a bundle.

John the Ripper single-file flatpak bundle was built and tested on
[GitLab](https://gitlab.com/claudioandre-br/JtR-CI/pipelines). You can get it
[here](https://github.com/openwall/john-packages/releases/tag/jumbo-dev).

The necessary steps to install the package are listed below. They were tested on
a clean Fedora 29 docker image, but they should work for every supported distro
out there. Don't worry, it can't hurt your Linux environment.

Install and configure flatpak itself:

```bash
 dnf install -y flatpak # or 'yum install', 'apt-get install', etc.
 flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo # flatpak repository
 flatpak install -y flathub org.freedesktop.Platform//18.08 # install the runtime (base "container")
```

Navigate to where you downloaded the john.flatpak file. Now, let's install the
software:

```bash
 flatpak --user install --bundle john.flatpak # per-user installation (not system wide)
```

Run John the Ripper and check if it is working:

```bash
 flatpak run com.openwall.John
 flatpak run com.openwall.John --list=build-info
```

## Windows

> Tested in AppVeyor CI and Azure DevOps. Deployed using Microsoft-hosted Windows 2016 Server in Azure

To install John the Ripper by downloading the .zip file and installing manually,
follow these steps:

- Download the ZIP file to your machine.
- Navigate to where you downloaded the file and double click the compressed file.
- Extract it to a directory such as `C:\john-the-ripper`.
- Start a command prompt.
- Navigate to the directory you extracted the .zip file, e.g., `cd C:\john-the-ripper\run`.
- Run JtR:

```powershell
C:\john-the-ripper\run>john --list=build-info
C:\john-the-ripper\run>john --test --format=SHA512crypt
```

The highlights:

- fallback for CPU[*] and OMP;
- prince mode available;
- OpenCL available (GPU driver installation is needed);
- generic crypt(3) format available;
- security feature Address Space Layout Randomisation (ASLR) enabled;
- security feature Data Execution Prevention (DEP) enabled;
- the stable John 1.9.0 Jumbo 1:
  - is available for X86_64 and i386;
- a development version:
  - is available for X86_64.

[*] John the Ripper runs using the best SIMD instructions available on the host
it's running on.

### Windows Deployments

The links below contain all the executables and libraries needed to run a fresh
John the Ripper installation.

- the stable John 1.9.0 Jumbo 1:
  - The [32bit version](https://github.com/claudioandre-br/packages/releases/download/1.9.0-jumbo-1/x32_win.zip)
[(libs)](https://github.com/claudioandre-br/packages/releases/download/1.9.0-jumbo-1/x32_optional.zip)
[(logs)](https://github.com/claudioandre-br/packages/releases/download/1.9.0-jumbo-1/x32_log.txt);
  - The [64bit version](https://github.com/claudioandre-br/packages/releases/download/1.9.0-jumbo-1/x64_win.zip)
[(libs)](https://github.com/claudioandre-br/packages/releases/download/1.9.0-jumbo-1/x64_optional.zip)
[(logs)](https://github.com/claudioandre-br/packages/releases/download/1.9.0-jumbo-1/x64_log.txt);
- a development [64bit version](https://github.com/openwall/john-packages/releases/tag/jumbo-dev).

Libs **may** be needed on some systems.

### Running a non-OpenMP build on Windows

In some situations a non-OpenMP build may be faster. You can ask to fallback to
a non-OpenMP build specifying the value of OMP_NUM_THREADS in the command line.
You avail the best SIMD instructions at one's disposal without any OpenMP stuff. E.g.:

```powershell
PS C:\john-the-ripper\run> set OMP_NUM_THREADS=1
PS C:\john-the-ripper\run> .\john --list=build-info
```

### Running OpenCL

Some adjustments may be necessary to allow John the Ripper detect your GPU
hardware. If you are facing problems, please ask for support.

- That being said, a few advices to anyone facing Windows problems:
  - replacing cygwin's OpenCL library `cygOpenCL-1.dll` in the `run` directory with `OpenCL.dll` installed
  in the `c:\Windows\System32` folder should make everything _almost_ work. Make a backup of `cygOpenCL-1.dll`, copy in the `OpenCL.dll`, and rename the copied file `cygOpenCL-1.dll`.
  - if you get errors like `Error building kernel /run/opencl/cryptsha512_kernel_GPU.cl` try running john from the subdirectory `opencl` (e.g. from `JtR\run\opencl` run `..\john.exe`).

Benchmarking:

```text
PS C:\bleeding\run> .\john --test=5 --format=sha512crypt-opencl
Device 0: Juniper [AMD Radeon HD 6700 Series]
Benchmarking: sha512crypt-opencl, crypt(3) $6$ (rounds=5000) [SHA512 OpenCL]... DONE
Speed for cost 1 (iteration count) of 5000
Raw:	11522 c/s real, 819200 c/s virtual
```

Real cracking:

```powershell
PS C:\bleeding\run> .\john --format=sha512crypt-opencl d:\hash.txt
Device 0: Juniper [AMD Radeon HD 6700 Series]
Using default input encoding: UTF-8
Loaded 2 password hashes with 2 different salts (sha512crypt-opencl, crypt(3) $6$ [SHA512 OpenCL])
Cost 1 (iteration count) is 5000 for all loaded hashes
Press 'q' or Ctrl-C to abort, almost any other key for status
                 (?)
1g 0:00:00:28  3/3 0.03540g/s 5553p/s 9178c/s 9178C/s 123456
```

```powershell
PS C:\bleeding\run> .\john --format=sha512crypt-opencl d:\hash.txt --mask=Hello?awor?l?l?a
Device 0: Juniper [AMD Radeon HD 6700 Series]
Using default input encoding: UTF-8
Loaded 2 password hashes with 2 different salts (sha512crypt-opencl, crypt(3) $6$ [SHA512 OpenCL])
Remaining 1 password hash
Cost 1 (iteration count) is 5000 for all loaded hashes
Press 'q' or Ctrl-C to abort, almost any other key for status
GPU 0 probably invalid temp reading (-1°C).
Hello world!     (?)
1g 0:00:05:06 DONE (2018-01-01 15:08) 0.003265g/s 11369p/s 11369c/s 11369C/s HelloYworik_..HelloLworurU
Use the "--show" option to display all of the cracked passwords reliably
Session completed
```

#### File hash computed by the CI server

File verification is the process of using an algorithm for verifying the integrity
of a computer file. A popular approach is to store checksums (hashes) of files,
also known as message digests, for later comparison.

Accessing the build logs, you can view the hashes of all relevant
files. For example:

```text
Algorithm       Hash                                                                   Path
---------       ----                                                                   ----
SHA256          768C9D39453C9380CCCFE179FDF559BCCDE9E3AFA0C612F55FFB1823F35105E4       C:\win_x64.zip
```

## Docker Image

> Built using Travis CI and deployed using Docker Hub

For testing and future reference, we have a Docker image of John the Ripper.
To use it:

```bash
 # CPU only formats
 docker run -it claudioandre/john:v1.9.0J1 <binary id> <john options>

 # To run ztex formats
 docker run -it --device=/dev/ttyUSB0 claudioandre/john:v1.9.0J1 ztex <john options>
```

Run John the Ripper and check if it is working:

```bash
 docker run -it claudioandre/john:v1.9.0J1 # => SSE2
 docker run -it claudioandre/john:v1.9.0J1 best # => uses the best SIMD available
 docker run -it claudioandre/john:v1.9.0J1 ssse3-no-omp -list=build-info
 docker run -it claudioandre/john:v1.9.0J1 avx512bw -test=0 -format=cpu
 docker run -it claudioandre/john:v1.9.0J1 -list=format-tests | cut -f3 > ~/alltests.in
 docker run -it -v "$HOME":/host claudioandre/john:v1.9.0J1 avx -form=SHA512crypt /host/alltests.in --max-run=300
```

Compare the performance of SIMD extensions:

```bash
 docker run -it claudioandre/john:v1.9.0J1 sse2    --test=10 --format=SHA512crypt
 docker run -it claudioandre/john:v1.9.0J1 sse4.1  --test=10 --format=SHA512crypt
 docker run -it claudioandre/john:v1.9.0J1 avx     --test=10 --format=SHA512crypt
 docker run -it claudioandre/john:v1.9.0J1 avx2    --test=10 --format=SHA512crypt
```

The highlights:

- prince mode available;
- the stable John 1.9.0 Jumbo 1 (`claudioandre/john:v1.9.0J1`):
  - has ztex formats available.
- the development version (`claudioandre/john:v1.9.0J2`):
  - has auto-selection of the best SIMD if user specifies `best` as the `<binary id>`.

The available binaries (their IDs are sse2, sse2-no-omp, ssse3, etc) are:

- /john/run/john-sse2 (default binary)
- /john/run/john-sse2-no-omp
- /john/run/john-ssse3
- /john/run/john-ssse3-no-omp
- /john/run/john-sse4.1
- /john/run/john-sse4.1-no-omp
- /john/run/john-sse4.2
- /john/run/john-sse4.2-no-omp
- /john/run/john-avx
- /john/run/john-avx-no-omp
- /john/run/john-xop
- /john/run/john-xop-no-omp
- /john/run/john-avx2
- /john/run/john-avx2-no-omp
- /john/run/john-avx512f
- /john/run/john-avx512f-no-omp
- /john/run/john-avx512bw
- /john/run/john-avx512bw-no-omp
- /john/run/john-ztex (SSE2)
- /john/run/john-ztex-no-omp (SSE2)

## Packages Checksums

> Released packages checksums computed by Build Servers

### John the Ripper 1.9.0 Jumbo 1

#### Windows Packages

```text
Algorithm       Hash                                                                   Path
---------       ----                                                                   ----
SHA256          C06274B7AB3064844F4D36F9CE943492EC666FA50B97C595A02A54719DC40398       C:\win_x32.zip
SHA256          64B8DDF2B930210263546D52B796740F689C22D539652EBA0D7FE5E3CD024BAB       C:\optional.zip

Algorithm       Hash                                                                   Path
---------       ----                                                                   ----
SHA256          75C085D1625B50E70EE2906227DC9EE3722A8D24377057E7E22B5FE8579E9314       C:\win_x64.zip
SHA256          8AF77CB39B1D3E05CF6AFC317151F02C7847A61727D868F9EF49471C9BBA75DB       C:\optional.zip
```

#### Flatpak Package

```bash
$ sha256sum john.flatpak
5f330b46f4f40035714678aade47155c58d9eee819adef6951d032552c31813d  john.flatpak
```

#### Docker Digest

```bash
Digest: sha256:4ea2eb998a335cb1d482ba125fd10862f807e36e96c39e31fa96a2325579e154
```

## Security

Please inspect all packages prior to running any of them to ensure safety.
We already know they're safe, but you should verify the security and contents of any
binary from the internet you are not familiar with.

We take security very seriously.

## License

GNU General Public License v2.0
