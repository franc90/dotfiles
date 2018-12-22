#!/usr/bin/env bash

readonly currentDir=$(pwd)
readonly source=$1
readonly target=$2

if ([[ ! -L ~/${target} ]] || [[ ! -e ~/${target} ]]); then
    rm -f ~/${target} && ln -s ${currentDir}/${source} ~/${target}
fi