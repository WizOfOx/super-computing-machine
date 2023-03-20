# syntax=docker/dockerfile-upstream:master-labs
ARG MATLAB_VER="latest"
FROM debian:stable-slim as debian-builder

RUN apt update && \
    apt install -y build-essential gfortran git \
    libopenblas-dev libtool wget metis pkg-config 

ADD https://github.com/coin-or-tools/ThirdParty-Metis.git /metis-src

WORKDIR /metis-src

RUN ./get.Metis && \
    ./configure --prefix=/build --enable-static --disable-shared && \
    make -j$(nproc) install

ADD  https://github.com/WizOfOx/curly-sniffle.git#master /hsl-src

WORKDIR /hsl-src

RUN ./configure --prefix=/build \
    --enable-static --disable-shared && \
    make && \
    make install

ENV PKG_CONFIG_PATH=/build/lib/pkgconfig

ADD https://github.com/coin-or-tools/ThirdParty-Mumps.git#stable/3.0 /mumps-src

WORKDIR /mumps-src

RUN ./get.Mumps && \
    ./configure --prefix=/build \
    --with-lapack="$(pkg-config --libs openblas | cut -d " " -f 1) -l:libopenblas.a -lgfortran -lm -lpthread" \
    --with-metis-cflags="$(pkg-config --cflags coinmetis)" \
    --with-metis-lflags="$(pkg-config --libs coinmetis | cut -d ' ' -f 1) -l:libcoinmetis.a -lm" \
    --enable-static \
    --disable-shared \
    && make \
    && make test \
    && make install

ADD https://github.com/coin-or/Ipopt.git#stable/3.14 /ipopt-src

WORKDIR /ipopt-src


RUN ./configure --prefix=/build --disable-linear-solver-loader --disable-sipopt --disable-java --enable-static --disable-shared --with-hsl-cflags="$(pkg-config --cflags coinhsl coinmumps)" --with-hsl-lflags="$(pkg-config --libs coinmetis | cut -d " " -f 1) $(pkg-config --libs openblas | cut -d " " -f 1) -l:libcoinhsl.a -l:libcoinmetis.a -l:libopenblas.a -lgfortran -lm -lpthread" --with-mumps-cflags="$(pkg-config --cflags coinmumps)" --with-mumps-lflags="$(pkg-config --libs coinmetis | cut -d " " -f 1) $(pkg-config --libs openblas | cut -d " " -f 1) -l:libcoinmumps.a -l:libcoinmetis.a -l:libopenblas.a -lgfortran -lm -lpthread" --with-lapack="$(pkg-config --libs openblas | cut -d " " -f 1) -l:libopenblas.a -lgfortran -lm -lpthread" \
&& make -j$(nproc) \
&& make test \
&& make install



FROM mathworks/matlab:${MATLAB_VER} as mex-builder
ARG MATLAB_VER="latest"

COPY --from=debian-builder --chown=matlab /build /build

USER root

RUN apt update && \
    apt install -y build-essential gfortran \
    libopenblas-dev metis pkg-config 


ENV PKG_CONFIG_PATH=/build/lib/pkgconfig

COPY --chown=matlab . /mex-src

USER matlab

RUN MATLABVERSION=$(stat /usr/local/bin/matlab | grep -Eo "R[0-9]{4}[ab]") && \
    MATLABROOT=/opt/matlab/$MATLABVERSION && \
    $MATLABROOT/bin/mex -v -output ipopt \
        -outdir /build \
        -R2018a $(pkg-config --cflags ipopt) \
        $(pkg-config --libs ipopt) /mex-src/main.cpp 

FROM mathworks/matlab:${MATLAB_VER} as mex-runner

COPY --from=mex-builder /build/ipopt.mexa64 /home/matlab/Documents/MATLAB/ipopt.mexa64
COPY --chown=matlab ${MATLAB_VER}.lic.gpg /home/matlab/license.lic.gpg
COPY --chown=matlab setup.sh /home/matlab/setup.sh
# ENV MLM_LICENSE_FILE=/home/matlab/license.lic

USER root
RUN apt update && \
    apt install -y build-essential git && \
    chmod +x /home/matlab/setup.sh
USER matlab