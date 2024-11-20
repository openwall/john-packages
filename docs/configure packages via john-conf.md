# Configuring packages via john.conf

Some John packages file systems are intentionally read-only. So, in order to adjust the `john` settings file
`john.conf`, you will need to:

## Snap

You just have to think about how the upstream itself works:

1. you cannot use `john-local.conf` (at least I haven't found a way to use it since `john` doesn't have a built-in
   variable that points to your runtime `Private home`);
2. so, you must have a full `john.conf` in the snap (environment) proper HOME folder. It is
   `$HOME/snap/john-the-ripper`;

So let's see how it works using an example:

DO NOT REMOVE YOUR `john.pot` IF IT MATTERS TO YOU. Save it first, at least.

---

- It works the same whether you are using the edge channel or the stable channel.

```shell
$ cd ~

$ john --list=build-info
Version: 1.9.0-jumbo-1+bleeding-9950d782a7 2024-06-08 16:38:48 +0200
Build: linux-gnu 64-bit x86_64 AVX2 AC OMP OPENCL
SIMD: AVX2, interleaving: MD4:3 MD5:3 SHA1:1 SHA256:1 SHA512:1
Deploy: sandboxed as a Snap app
System-wide exec: /snap/john-the-ripper/current/bin
System-wide home: /snap/john-the-ripper/current/bin
Private home: ~/.john
[...]
$JOHN is /snap/john-the-ripper/current/bin/
[...]
```

```bash
$ john --format=sha512crypt -list=format-tests | cut -f3 > ~/allTests.in
# Create some sample hashes
```

- Crack it using the "regular" packaged `john`

```bash
$ rm -f ~/snap/john-the-ripper/current/.john/john.pot; john ~/allTests.in --max-run=10 --mask
Warning: detected hash type "sha512crypt", but the string is also recognized as "sha512crypt-opencl"
Use the "--format=sha512crypt-opencl" option to force loading these as that type instead
Using default input encoding: UTF-8
Loaded 6 password hashes with 4 different salts (1.5x same-salt boost) (sha512crypt, crypt(3) $6$ [SHA512 256/256 AVX2 4x])
Cost 1 (iteration count) is 5000 for all loaded hashes
Will run 8 OpenMP threads
Using default mask: ?1?2?2?2?2?2?2?3?3?3?3?d?d?d?d    ## <===== HERE ******************************************************
Press 'q' or Ctrl-C to abort, 'h' for help, almost any other key for status
0g 0:00:00:00  (2) 0g/s 0p/s 0c/s 0C/s
                 (?)
1g 0:00:00:02 2.49% (3) (ETA: 12:08:28) 0g/s 728.8p/s 2550c/s 4008C/s e5..5ya
1g 0:00:00:10 8.70% (3) (ETA: 12:09:01) 0g/s 702.1p/s 2306c/s 3710C/s Eli..lzi
Use the "--show" option to display all of the cracked passwords reliably
Session stopped (max run-time reached)
```

- Use your personal/edited `john.conf`

```bash
$ cp /snap/john-the-ripper/current/bin/john.conf ~/snap/john-the-ripper/current/.john/john.conf
# File copied.

$ sed -i 's/DefaultMask = ?1?2?2?2?2?2?2?3?3?3?3?d?d?d?d/DefaultMask = Hello?awor?l?l?a/g' ~/snap/john-the-ripper/current/.john/john.conf
# File edited.
```

- Try it again (compare the mask value used)

```bash
$ rm -f ~/snap/john-the-ripper/current/.john/john.pot; john ~/allTests.in --max-run=10 --mask
[...]
Using default mask: Hello?awor?l?l?a   ## <===== HERE *********************************************************************
[...]
1g 0:00:00:02 3.09% (11) (ETA: 12:09:26) 0g/s 726.2p/s 2541c/s 3994C/s Hello.worg..Hello7woria
1g 0:00:00:10 10.82% (11) (ETA: 12:09:54) 0g/s 700.7p/s 2302c/s 3703C/s HelloIworje..Hello9worni
Use the "--show" option to display all of the cracked passwords reliably
Session stopped (max run-time reached)
```

## Docker

Create a suitable `$(pwd)/.john/john.conf` file in your 'host'.

```bash
$ cp YOUR-FILE/john.conf $(pwd)/.john/john.conf
# Use your personal/edited `john.conf`
```

Then connect the 'host' file system to the running container (linking the host current folder to `/home/JtR`).

You will need add the following option to the `docker run` command-line:

```bash
-v "$(pwd)":/home/JtR
```

Example:

```bash
$ docker run -v "$(pwd)":/home/JtR ghcr.io/openwall/john best --format=SHA512crypt --incremental:digits /home/JtR/allTests.in --max-run=20
# john is executed in a Docker container
```
