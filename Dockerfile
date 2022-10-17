######################################################################
# Copyright (c) 2019-2022 Claudio André <claudioandre.br at gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
######################################################################

# Jumbo 1 release (docker build [...] --build-arg release=true)
ARG release=false
ARG commit=8998390b651f4a7e744758a1c41eb3068dc5084f

FROM ubuntu:22.04
WORKDIR /build/

RUN apt-get update -qq && \
    export DEBIAN_FRONTEND="noninteractive" && \
    apt-get install -y \
        build-essential libssl-dev zlib1g-dev yasm libgmp-dev libpcap-dev pkg-config \
        libbz2-dev wget git libusb-1.0-0-dev && \
    # Build John the Ripper
    git clone --depth 10 https://github.com/openwall/john.git && \
    # Make it a reproducible build
    if [ "$release" == "true" ] ; then cd john; git checkout $commit; cd ..; fi && \
    cd john/src && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=sse2   && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-sse2-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=sse2   && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-sse2 && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=ssse3  && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-ssse3-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=ssse3  && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-ssse3 && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=sse4.1 && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-sse4.1-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=sse4.1 && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-sse4.1 && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=sse4.2 && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-sse4.2-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=sse4.2 && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-sse4.2 && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=avx    && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=avx    && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=xop    && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-xop-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=xop    && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-xop && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=avx2   && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx2-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=avx2   && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx2 && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=avx512f  && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx512f-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=avx512f  && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx512f && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=avx512bw && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx512bw-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=avx512bw && make -s clean && make -sj2 && make strip && mv ../run/john ../run/john-avx512bw && \
    # Clean the image
    rm *.o && cd .. && rm -rf src .git .ci .circleci .editorconfig .gitattributes .github .gitignore .mailmap .pre-commit.sh .travis .travis.yml && rm -rf run/ztex

FROM ubuntu:22.04
LABEL maintainer Claudio André (c) 2017-2022

ARG VERSION_NAME
LABEL software "John the Ripper ${VERSION_NAME}"

LABEL org.opencontainers.image.revision "bleeding"

ARG BUILD_DATE
LABEL org.opencontainers.image.created "${BUILD_DATE}"

ARG VERSION
LABEL org.opencontainers.image.version="${VERSION}"

LABEL \
    org.opencontainers.image.authors="Claudio André <claudioandre.br at gmail com>" \
    org.opencontainers.image.url="https://github.com/openwall/john-packages.git" \
    org.opencontainers.image.vendor="Openwall" \
    org.opencontainers.image.licenses="GPL-2.0" \
    org.opencontainers.image.title="John the Ripper 'Jumbo' CE password cracker" \
    org.opencontainers.image.description="John the Ripper is an Open Source password security auditing and password recovery tool. See https://www.openwall.com/john/"

COPY --from=0 /build/john /john
COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s /usr/local/bin/docker-entrypoint.sh && \
    useradd -U -m JtR && \
    apt-get update -qq && \
    export DEBIAN_FRONTEND="noninteractive" && \
    apt-get install -y libssl1.1 libgomp1 && \
    # Clean the image
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

USER JtR
ENV BASE ubuntu
ENV VERSION="${VERSION}"
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["best"]
