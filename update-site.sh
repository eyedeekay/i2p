#! /usr/bin/env sh
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd $dir
git pull
make