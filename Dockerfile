######################################################################
# Copyright (c) 2019 Claudio André <claudioandre.br at gmail.com>
#
# This program comes with ABSOLUTELY NO WARRANTY; express or implied.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, as expressed in version 2, seen at
# http://www.gnu.org/licenses/gpl-2.0.html
######################################################################

FROM ubuntu:18.04
LABEL maintainer Claudio André (c) 2017-2020 1.9.0J1+
LABEL software John the Ripper 1.9.0 Jumbo 1+

COPY john/ /john
COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s /usr/local/bin/docker-entrypoint.sh / # backwards compat

RUN apt-get update -qq && \
    apt-get install -y \
        build-essential libssl-dev zlib1g-dev yasm libgmp-dev libpcap-dev pkg-config \
        libbz2-dev wget git libusb-1.0-0-dev && \
    useradd -U -m JtR && \
    # Build John the Ripper
    cd john/src && \
      ./configure --disable-native-tests --disable-openmp CPPFLAGS='-msse2'   && make -s clean && make -sj2 && mv ../run/john ../run/john-sse2-no-omp && \
      ./configure --disable-native-tests                  CPPFLAGS='-msse2'   && make -s clean && make -sj2 && mv ../run/john ../run/john-sse2 && \
      ./configure --disable-native-tests --disable-openmp CPPFLAGS='-mssse3'  && make -s clean && make -sj2 && mv ../run/john ../run/john-ssse3-no-omp && \
      ./configure --disable-native-tests                  CPPFLAGS='-mssse3'  && make -s clean && make -sj2 && mv ../run/john ../run/john-ssse3 && \
      ./configure --disable-native-tests --disable-openmp CPPFLAGS='-msse4.1' && make -s clean && make -sj2 && mv ../run/john ../run/john-sse4.1-no-omp && \
      ./configure --disable-native-tests                  CPPFLAGS='-msse4.1' && make -s clean && make -sj2 && mv ../run/john ../run/john-sse4.1 && \
      ./configure --disable-native-tests --disable-openmp CPPFLAGS='-msse4.2' && make -s clean && make -sj2 && mv ../run/john ../run/john-sse4.2-no-omp && \
      ./configure --disable-native-tests                  CPPFLAGS='-msse4.2' && make -s clean && make -sj2 && mv ../run/john ../run/john-sse4.2 && \
      ./configure --disable-native-tests --disable-openmp CPPFLAGS='-mavx'    && make -s clean && make -sj2 && mv ../run/john ../run/john-avx-no-omp && \
      ./configure --disable-native-tests                  CPPFLAGS='-mavx'    && make -s clean && make -sj2 && mv ../run/john ../run/john-avx && \
      ./configure --disable-native-tests --disable-openmp CPPFLAGS='-mxop'    && make -s clean && make -sj2 && mv ../run/john ../run/john-xop-no-omp && \
      ./configure --disable-native-tests                  CPPFLAGS='-mxop'    && make -s clean && make -sj2 && mv ../run/john ../run/john-xop && \
      ./configure --disable-native-tests --disable-openmp CPPFLAGS='-mavx2'   && make -s clean && make -sj2 && mv ../run/john ../run/john-avx2-no-omp && \
      ./configure --disable-native-tests                  CPPFLAGS='-mavx2'   && make -s clean && make -sj2 && mv ../run/john ../run/john-avx2 && \
      ./configure --disable-native-tests --disable-openmp CPPFLAGS='-mavx512f'  && make -s clean && make -sj2 && mv ../run/john ../run/john-avx512f-no-omp && \
      ./configure --disable-native-tests                  CPPFLAGS='-mavx512f'  && make -s clean && make -sj2 && mv ../run/john ../run/john-avx512f && \
      ./configure --disable-native-tests --disable-openmp CPPFLAGS='-mavx512bw' && make -s clean && make -sj2 && mv ../run/john ../run/john-avx512bw-no-omp && \
      ./configure --disable-native-tests                  CPPFLAGS='-mavx512bw' && make -s clean && make -sj2 && mv ../run/john ../run/john-avx512bw && \
    #  ./configure --disable-native-tests --enable-ztex --disable-openmp CPPFLAGS='-msse2' && make -s clean && make -sj2 && mv ../run/john ../run/john-ztex-no-omp && \
    #  ./configure --disable-native-tests --enable-ztex                  CPPFLAGS='-msse2' && make -s clean && make -sj2 && mv ../run/john ../run/john-ztex && \
    # Clean the image
    rm *.o && rm -rf ../.git && rm -rf ../run/ztex && rm -rf ztex && \
      apt-get -y remove --purge build-essential libssl-dev zlib1g-dev yasm libgmp-dev libpcap-dev pkg-config \
           libbz2-dev wget git libusb-1.0-0-dev && \
      apt-get -y autoremove && \
      apt-get -y install libgomp1 && \
      apt-get -y clean && \
      rm -rf /var/lib/apt/lists/*

USER JtR
ENV BASE ubuntu
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sse2"]
