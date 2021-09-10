######################################################################
# Copyright (c) 2019-2021 Claudio André <claudioandre.br at gmail.com>
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
ARG commit=a16c8a76259ab870c07e5123c237b1900402d9a6

FROM ubuntu:20.04
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
      ./configure --disable-native-tests --disable-openmp --enable-simd=sse2   && make -s clean && make -sj2 && mv ../run/john ../run/john-sse2-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=sse2   && make -s clean && make -sj2 && mv ../run/john ../run/john-sse2 && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=ssse3  && make -s clean && make -sj2 && mv ../run/john ../run/john-ssse3-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=ssse3  && make -s clean && make -sj2 && mv ../run/john ../run/john-ssse3 && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=sse4.1 && make -s clean && make -sj2 && mv ../run/john ../run/john-sse4.1-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=sse4.1 && make -s clean && make -sj2 && mv ../run/john ../run/john-sse4.1 && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=sse4.2 && make -s clean && make -sj2 && mv ../run/john ../run/john-sse4.2-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=sse4.2 && make -s clean && make -sj2 && mv ../run/john ../run/john-sse4.2 && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=avx    && make -s clean && make -sj2 && mv ../run/john ../run/john-avx-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=avx    && make -s clean && make -sj2 && mv ../run/john ../run/john-avx && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=xop    && make -s clean && make -sj2 && mv ../run/john ../run/john-xop-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=xop    && make -s clean && make -sj2 && mv ../run/john ../run/john-xop && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=avx2   && make -s clean && make -sj2 && mv ../run/john ../run/john-avx2-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=avx2   && make -s clean && make -sj2 && mv ../run/john ../run/john-avx2 && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=avx512f  && make -s clean && make -sj2 && mv ../run/john ../run/john-avx512f-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=avx512f  && make -s clean && make -sj2 && mv ../run/john ../run/john-avx512f && \
      ./configure --disable-native-tests --disable-openmp --enable-simd=avx512bw && make -s clean && make -sj2 && mv ../run/john ../run/john-avx512bw-no-omp && \
      ./configure --disable-native-tests                  --enable-simd=avx512bw && make -s clean && make -sj2 && mv ../run/john ../run/john-avx512bw && \
    # Clean the image
    rm *.o && cd .. && rm -rf src .git .ci .circleci .editorconfig .gitattributes .github .gitignore .mailmap .pre-commit.sh .travis .travis.yml && rm -rf run/ztex

FROM ubuntu:20.04
LABEL maintainer Claudio André (c) 2017-2021 1.9.0J1+
LABEL software John the Ripper 1.9.0 Jumbo 1+

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
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["best"]