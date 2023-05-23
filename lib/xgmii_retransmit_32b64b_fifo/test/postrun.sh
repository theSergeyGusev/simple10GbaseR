#!/bin/bash

result=0
result="$(grep -r ./log/$1.log -e '0 ERROR' | wc -l)" 
elapsed="$(grep -r ./log/$1.log -e 'Elapsed')" 

if [ $result -eq 1 ]
then
    echo -e '\033[0;32m'['      'PASS]'\033[0m' $1 $elapsed
else
    echo -e '\033[0;31m'['      'FAIL]'\033[0m' $1 $elapsed
fi

