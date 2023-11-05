# More Examples Of Running John The Ripper On Docker

## Syntax

```bash
 # CPU and GPU formats
 docker run -it ghcr.io/openwall/john:latest <binary id> <john options>

 # To run ztex formats
 docker run --device=/dev/ttyUSB0 ghcr.io/openwall/john:v1.9.0J1 ztex <john options>
```

## Basic usage

```bash
 docker run ghcr.io/openwall/john # => uses the best SIMD available, tag 'latest' can be ommited
 docker run ghcr.io/openwall/john:rolling # => uses the latest rolling release
 docker run ghcr.io/openwall/john:latest best # => uses the best SIMD available
 docker run ghcr.io/openwall/john:latest avx2 -list=build-info
 docker run ghcr.io/openwall/john:latest avx2-omp -list=build-info
 docker run ghcr.io/openwall/john:latest avx512bw -test=0 -format=cpu
```

## Run a real cracking session

```bash
 docker run ghcr.io/openwall/john:latest -list=format-tests | cut -f3 > ~/alltests.in
 docker run -v "$HOME":/host ghcr.io/openwall/john:latest avx2 -form=SHA512crypt /host/alltests.in --max-run=300
```

## Run a real cracking session, saving the session information on the host

```bash
 # I'm using a demo hashes file:
 docker run ghcr.io/openwall/john:latest -list=format-tests | cut -f3 > alltests.in

 docker run -v "$(pwd)":/home/JtR ghcr.io/openwall/john best -form=SHA512crypt /home/JtR/alltests.in --max-run=30
 docker run -v "$(pwd)":/home/JtR ghcr.io/openwall/john best -form=SHA512crypt --wordlist --rules /home/JtR/alltests.in --max-run=20
 docker run -v "$(pwd)":/home/JtR ghcr.io/openwall/john best -form=SHA512crypt --incrementa:digits /home/JtR/alltests.in --max-run=20

 # On the host (inside the current folder) I can find the session files:
 $ ls -lahR
 total 3,9G
 drwxrwxr-x  5 claudio claudio 4,0K jun 20 08:59  .
 drwxr-x--- 22 claudio claudio 4,0K jun 20 08:59  ..
 -rw-rw-r--  1 claudio claudio 1,2M jun 20 08:58  alltests.in
 drwx------  2 claudio claudio 4,0K jun 20 08:59  .john
 [...]
 ./.john:
 total 24K
 drwx------ 2 claudio claudio 4,0K jun 20 08:59 .
 drwxrwxr-x 5 claudio claudio 4,0K jun 20 08:59 ..
 -rw------- 1 claudio claudio 8,4K jun 20 08:59 john.log
 -rw------- 1 claudio claudio    0 jun 20 08:59 john.pot
 -rw------- 1 claudio claudio  246 jun 20 08:59 john.rec
```

## Compare the performance of SIMD extensions

```bash
 docker run ghcr.io/openwall/john:latest avx      --test=10 --format=SHA512crypt
 docker run ghcr.io/openwall/john:latest avx2     --test=10 --format=SHA512crypt
 docker run ghcr.io/openwall/john:latest avx512bw --test=10 --format=SHA512crypt
```

## Binaries

The available linux/amd64 binaries (their IDs are avx-omp, avx, etc) are:

- /john/run/john-avx-omp (default binary)
- /john/run/john-avx
- /john/run/john-avx2-omp
- /john/run/john-avx2
- /john/run/john-avx512f-omp
- /john/run/john-avx512f
- /john/run/john-avx512bw-omp
- /john/run/john-avx512bw

The available linux/arm64 binaries (their IDs are john-omp and john-aarch64) are:

- /john/run/john-omp (default binary)
- /john/run/john-aarch64

Binaries available on Docker image John 1.9.0 Jumbo 1 (their IDs are ztex and ztex-no-omp) are:

- /john/run/john-ztex (SSE2)
- /john/run/john-ztex-no-omp (SSE2)

## Docker image verification

Anyone can verify the Docker image using the commands below:

Simple and nice IMO:

```bash
$ ./cosign-linux-amd64 tree ghcr.io/openwall/john:latest
📦 Supply Chain Security Related artifacts for an image: ghcr.io/openwall/john:latest
└── 💾 Attestations for an image tag: ghcr.io/openwall/john:sha256-c9275acf784a3f19cab3ce0aab3cedefbe986dcbe70df650e5802ec23127f4da.att
   └── 🍒 sha256:e777d619092a02e919ebe242431df428369edc22e0ccbe0a9214678343452af8
```

A more detailed list of information:

```bash
$ ./cosign-linux-amd64 verify-attestation \
      --certificate-identity https://github.com/slsa-framework/slsa-github-generator/.github/workflows/generator_container_slsa3.yml@refs/tags/v1.7.0 \
      --certificate-oidc-issuer https://token.actions.githubusercontent.com \
      --type slsaprovenance \
    ghcr.io/openwall/john:latest
# a lot of info will be printed here
```
