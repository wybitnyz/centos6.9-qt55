#!/bin/bash

git clone ${1} repository
cd repository
git checkout ${2}
sed -i -e 's : / ' -e 's git@ http:// ' .gitmodules
git submodule update --init
./build.sh
cp release/* /out
exit 0
