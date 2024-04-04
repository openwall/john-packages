# Security Policy

Important notes:
* `john` isn't to be used on untrusted input and should be run with the lowest privileges necessary;
  * it is unrealistic to have zero bugs, it is a consequence of how many formats and different parsers it has.
* prefer sandboxed versions of packages (snap, flatpak or Docker) whenever you need "hardening";
* reminder:
  * the MPI library (not used by packages from this repository) tends to open and listening ports,
    so it can expose itself, `john`, and the underlying system to direct network-based attacks as well;
  * use the `--format` option to reduce parsing of input files;
  * if you are compiling `john` yourself, you can also reduce dependencies by removing plugin formats or
    ignoring optional libraries/features, thus minimizing the attack surface for potential security threats.

## Supported Versions

The `john` community releases patches for security vulnerabilities. Which versions are eligible for
receiving such patches depends on the version:

| Version | Supported          | Note                                      |
| ------- | ------------------ | ----------------------------------------- |
| upstream bleeding code | :heavy_check_mark: | Under development version  |
| rolling 1.9J1+2404     | :heavy_check_mark: | Most recent release        |
| jumbo 1 or older       | :x: | No longer maintained                      |

## Reporting a Vulnerability

Please just report issues in public right away:
* if you are worried about a package or its dependencies, create a bug report [here](https://github.com/openwall/john-packages/issues);
* otherwise, at [https://github.com/openwall/john/issues](https://github.com/openwall/john/issues).

If the issue is confirmed, `john` community will release a patch as soon as possible depending on complexity.

Please note that for security purposes all inputs are considered trusted by upstream `john`, and it should
be assumed that input can control the program in arbitrary ways. In cases where greater robustness is desired,
use the snap, the flatpak or the Docker version; you can also use the `--format` option to reduce parsing
of input files.

## When to report a vulnerability

When you think John The Ripper has a potential security vulnerability.

When you know of or suspect a potential vulnerability on another project that is used by `john`.
For example, in a packaged dependency.
