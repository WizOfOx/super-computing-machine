#!/usr/bin/env bash

MATLABVERSION=$(stat /usr/local/bin/matlab | grep -Eo "R[0-9]{4}[ab]")

echo "MATLAB version: $MATLABVERSION"

MATLABROOT="/opt/matlab/${MATLABVERSION}"

ARGS="-v -output ipopt -outdir ${HOME}/Documents/MATLAB/+bin -R2018a -I/build/include/coin-or -I/build/include -I/build/include/coin-or/mumps /build/lib/libipopt.a /build/lib/libcoinhsl.a /build/lib/libcoinmumps.a /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblas.a -lm -lpthread -lgfortran main.cpp"

mkdir -vp $HOME/Documents/MATLAB/+bin

echo $MATLABROOT/bin/mex $ARGS
$MATLABROOT/bin/mex $ARGS