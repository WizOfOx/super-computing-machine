#!/bin/bash

/home/matlab/setup.sh $THE_SECRET
/bin/run.sh -batch "cd('/workspace');run('tester.m')"
testresult=$(cat $HOME/testresults.xml)
echo "testresult='$testresult'" >> "$GITHUB_OUTPUT"