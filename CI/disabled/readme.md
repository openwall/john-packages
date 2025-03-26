# List of Formats Disabled by Test

Problematic formats that need to be disabled during testing:

Platform #0 name: Intel(R) OpenCL, version: OpenCL 3.0 LINUX\
\- Driver version: 2024.18.10.0.08_160000.

```bash
# TS internal (./jtrts.pl -noprelims -internal enabled)
# CPU formats => Error processing POT
# OpenCL formats => Expected count(s) failure

disable_list="
    adxcrypt
    as400-des
    bcrypt
    descrypt
    lm
    net-ah
    nethalflm
    netlm
    pst
    racf
    rvary
    sapb
    tripcode
    vnc
    argon2-opencl
    bcrypt-opencl
    descrypt-opencl
    keepass-argon2-opencl
    krb5tgs-opencl
    lm-opencl
    o5logon-opencl
    pgpdisk-opencl
    pfx-opencl
    sha256crypt-opencl
    zip-opencl
"
```

```bash
# TS opencl (./jtrts.pl -noprelims -type opencl)
# => Expected count(s) failure

# OpenCL descrypt builds for all 4096 salts, it is unusable inside CI
disable_list="
    bcrypt-opencl
    descrypt-opencl
    krb5pa-md5-opencl
    lm-opencl
    mscash-opencl
    nt-opencl
    ntlmv2-opencl
    o5logon-opencl
    sha256crypt-opencl
    zip-opencl
"
```

```bash
# TS regular (./jtrts.pl -dynamic none)
# => Expected count(s) failure

disable_list="
    descrypt
    lm
    netlm
    pst
    sapB
    vnc
"
```

Also, in a regular `--test` session or in a cracking session:

Platform #0 name: Intel(R) OpenCL, version: OpenCL 3.0 LINUX\
\- Driver version: 2023.16.10.0.17_160000.

```bash
'RACF-KDFAES'             #SLOW
'RAR'                     #SLOW
'wpapsk-opencl'           #SLOW
'wpapsk-pmk-opencl'       #SLOW
'argon2-opencl'           #SLOW
'bitlocker-opencl'        #SLOW

# Let's say these are fragile
'o5logon-opencl'
'mscash-opencl'
'salted_sha-opencl'

'pgpdisk-opencl'          #FAILED (cmp_all(49)) Intel OpenCL CPU

# Formats failing Intel OpenCL CPU driver
'krb5tgs-opencl'
'pfx-opencl'

#Testing: mscash2-opencl, MS Cache Hash 2 (DCC2) [PBKDF2-SHA1 OpenCL]... run_tests.sh: line 304:  6634 Segmentation fault
#      (core dumped) "$JTR_BIN" -test-full=0 --format=opencl
'mscash2-opencl'

# SunMD5 on aarch64, armhf, ppc64el, and Apple Silicon
# :: Testing: SunMD5 [MD5 128/128 ASIMD 4x2]... (4xOMP) *** stack smashing detected ***: terminated
# :: *** stack smashing detected ***: terminated
# :: *** stack smashing detected ***: terminated
# :: run_tests.sh: line 97: 24449 Aborted                 (core dumped) "$JTR_BIN" -test-full=0 --format=cpu
'SunMD5'

# OpenCL Intel CPU on Azure

# Testing: KeePass-Argon2-opencl [BlaMka OpenCL]...
# run_tests.sh: line 304:  6619 Segmentation fault      (core dumped) "$JTR_BIN" -test-full=0 --format=opencl
'keepass-argon2-opencl'

# Affected by https://github.com/openwall/john/pull/5613 and openwall/john#5615
# Testing: raw-SHA512-free-opencl [SHA512 OpenCL (inefficient, development use mostly)]... FAILED (cmp_all(49))
# [...]
# 1 out of 86 tests have FAILED
# Also
# Testing: XSHA512-free-opencl, Mac OS X 10.7+ [SHA512 OpenCL (efficient at "many salts" only)]... FAILED (cmp_all(49))

'raw-SHA512-free-opencl'
'XSHA512-free-opencl'
```
