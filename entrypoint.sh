#!/bin/bash

git clone ${1} repository
cd repository
git checkout ${2}
git2http
git submodule update --init
./build.sh
cp release/* /out
exit 0
