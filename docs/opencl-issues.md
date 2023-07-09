# Advices To Anyone Facing Opencl Windows Problems

## If `john` is not recognizing your GPU card

- make sure all required GPU drivers are installed;
- restart your PC, if you have just installed the drivers;
- if the previous items do not apply or if the problem persists:
  - using the `detect-OpenCL.ps1` script contained in the docs folder:
    ```powershell
     # I downloaded and extracted "john" to C:\Users\Me\JtR.
     # Then, opened the `detect-OpenCL.ps1` script and copied the command I need to use;
     #   For security reasons, powershell script execution is disabled by default
     PS C:\Users\Me> cd .\JtR\

     PS C:\Users\Me\JtR> run\john --list=opencl-devices
     Error: No OpenCL-capable platforms were detected by the installed OpenCL driver.
     Error: No OpenCL-capable devices were detected by the installed OpenCL driver.

     PS C:\Users\Me\JtR> Get-Childitem -Path c:\Windows\System32 -Include amdocl64.dll -File -Recurse -ErrorAction SilentlyContinue | %{$_.FullName} | Out-File -NoNewline -encoding ascii -FilePath etc\OpenCL\vendors\AMD-found.icd

     PS C:\Users\Me\JtR> run\john --list=opencl-devices
     Platform #0 name: AMD Accelerated Parallel Processing, version: OpenCL 2.1 AMD-APP (3075.13)
         Device #0 (1) name:     gfx902
         Board name:             AMD Radeon(TM) Vega 8 Graphics
         Device vendor:          Advanced Micro Devices, Inc.
         Device type:            GPU (LE)
         Device version:         OpenCL 2.0 AMD-APP (3075.13)
         OpenCL version support: OpenCL C 2.0
         Driver version:         3075.13 (PAL,HSAIL) - AMDGPU-Pro
         Native vector widths:   char 4, short 2, int 1, long 1
         Preferred vector width: char 4, short 2, int 1, long 1
         Global Memory:          5672 MiB
         Global Memory Cache:    16 KiB
         Local Memory:           32 KiB (Local)
         Constant Buffer size:   3081 MiB
         Max memory alloc. size: 3081 MiB
         Max clock (MHz):        1200
         Profiling timer res.:   1 ns
         Max Work Group Size:    256
         Parallel compute cores: 8
         Stream processors:      512  (8 x 64)
         Speed index:            614400
         SIMD width:             16
         Wavefront width:        64
         ADL:                    Overdrive0, device id -1
         PCI device topology:    05:00.0
    ```

  - replacing cygwin's OpenCL library `cygOpenCL-1.dll` in the `run` directory with `OpenCL.dll` installed
  in the `c:\Windows\System32` folder. Copy in the `OpenCL.dll`, and rename the copied file `cygOpenCL-1.dll`. Example:
    ```powershell
     # I downloaded and installed john in C:\Users\Me\JtR
     C:\Users\Me\JtR> run\john --list=opencl-devices
       Error: No OpenCL-capable platforms were detected by the installed OpenCL driver.
       Error: No OpenCL-capable devices were detected by the installed OpenCL driver.

     C:\Users\Me\JtR> run\john --test=5 --format=nt-opencl
     No OpenCL devices found

     # If you find too many OpenCL.dll files, try them all one at a time:
     # - copy, rename, test; copy another file, rename and ...
     C:\Users\Me\JtR> copy c:\Windows\System32\OpenCL.dll run\cygOpenCL-1.dll
         1 file(s) copied.

     C:\Users\Me\JtR> run\john --test=5 --format=nt-opencl
     Device 1: gfx902 [AMD Radeon(TM) Vega 8 Graphics]
     Benchmarking: NT-opencl [MD4 OpenCL/mask accel]... LWS=64 GWS=512 (8 blocks) x2470 DONE
     Raw:    287571K c/s real, 2857M c/s virtual
    ```

## OpenCL compilation erros

- if you get errors like `Error building kernel /run/opencl/cryptsha512_kernel_GPU.cl`
  try running john from the subdirectory `opencl` (e.g. from `JtR\run\opencl` run `..\john.exe`).
