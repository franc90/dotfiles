#!/usr/bin/env bash

readonly directory=$1

if [[ -d $directory ]]; then
    if [[ "$(ls -A $directory)" ]]; then
        chmod +x $directory/*
    fi
fi