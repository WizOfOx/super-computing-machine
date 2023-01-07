# syntax=docker/dockerfile:1
FROM worc4021/ipopt:latest as ipopt-builder

FROM mathworks/matlab:latest

COPY --from=ipopt-builder /build /build

ENV PKG_CONFIG_PATH=/build/lib/pkgconfig

USER root

RUN apt update && \
    apt install -y  git \
                    net-tools \
                    iproute2 \
                    libeigen3-dev \
                    gfortran \
                    metis \
                    libopenblas-dev

COPY --chown=matlab license.lic.gpg /home/matlab/license.lic.gpg

USER matlab

ENV MLM_LICENSE_FILE=/home/matlab/license.lic

COPY --chown=matlab . /home/matlab/workspace

WORKDIR /home/matlab/workspace

RUN chmod +x ./make.sh && \ 
    ./make.sh && \
    rm -rf /home/matlab/workspace

WORKDIR /home/matlab