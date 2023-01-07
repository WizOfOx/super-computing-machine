#!/usr/bin/env bash

MATLABROOT=/opt/matlab/R2022b

ARGS="-v -output ipopt -outdir  $home/Documents/MATLAB/+bin -R2018a -I/build/include/coin-or -I/build/include -I/build/include/coin-or/mumps /build/lib/libipopt.a /build/lib/libcoinhsl.a /build/lib/libcoinmumps.a /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblas.a -lm -lpthread -lgfortran main.cpp"

mkdir -p $home/Documents/MATLAB/+bin

echo $MATLABROOT/bin/mex $ARGS
$MATLABROOT/bin/mex $ARGS