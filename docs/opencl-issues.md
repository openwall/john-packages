# Advices To Anyone Facing Opencl Problems

## If `john` is not recognizing your GPU card

- make sure all required GPU drivers are installed;
- restart your PC, if you have just installed the drivers;
- check your environment using another OpenCL tool. For example, using `clinfo`.

## OpenCL compilation errors

- if you get errors like `Error building kernel /run/opencl/cryptsha512_kernel_GPU.cl`
  try running john from the subdirectory `opencl` (e.g. from `JtR\run\opencl` run `..\john.exe`).
