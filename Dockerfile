# syntax=docker/dockerfile:1
FROM worc4021/ipopt:latest as ipopt-builder

FROM mathworks/matlab:latest

COPY --from=ipopt-builder /build /build

ENV MLM_LICENSE_FILE=/home/matlab/license.lic

ENV PKG_CONFIG_PATH=/build/lib/pkgconfig

USER root

RUN --mount=type=secret,id=matlab_license \
    file /run/secrets/matlab_license && \
    ls -lA /run/secrets && \
    cp /run/secrets/matlab_license /home/matlab/license.lic && \
    cat /home/matlab/license.lic

RUN apt update && \
    apt install -y  git \
                    net-tools \
                    iproute2 \
                    libeigen3-dev \
                    gfortran \
                    metis \
                    libopenblas-dev

USER matlab