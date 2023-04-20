# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/master/containers

# [Choice] Ubuntu version: bionic, focal
ARG VARIANT="jammy"
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

# ** [Optional] Uncomment this section to install additional packages. **
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
           build-essential libssl-dev zlib1g-dev libgmp-dev libpcap-dev libbz2-dev \
           yasm pkg-config ocl-icd-opencl-dev opencl-headers \
           gdb cpio \
           libpocl-dev ocl-icd-libopencl1 pocl-opencl-icd \
    #wget -q http://registrationcenter-download.intel.com/akdlm/irc_nas/vcp/13793/l_opencl_p_18.1.0.013.tgz -O /tmp/opencl_runtime.tgz && \
    #tar -xzf /tmp/opencl_runtime.tgz -C /tmp && \
    #sed 's/decline/accept/g' -i /tmp/l_opencl_p_18.1.0.013/silent.cfg && \
    #/tmp/l_opencl_p_18.1.0.013/install.sh -s /tmp/l_opencl_p_18.1.0.013/silent.cfg \
    #
    # Clean up-
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

USER vscode
RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | bash -s -- -y
