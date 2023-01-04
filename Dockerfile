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

USER matlab