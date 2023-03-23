#!/bin/bash

/home/matlab/setup.sh $THE_SECRET
/bin/run.sh -batch "cd('/workspace');run('tester.m')"
cd $HOME
testresult=$(cat testresults.xml)
echo "testresult='$testresult'" >> /output
# echo $testresult