#!/bin/bash

/home/matlab/setup.sh $THE_SECRET
/bin/run.sh -batch "cd('$(pwd)');run('tester.m')"