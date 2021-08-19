#! /usr/bin/env sh
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd $dir
git pull
make
wget https://github.com/eyedeekay/i2p/releases/download/latest/i2pwinupdate.su3
