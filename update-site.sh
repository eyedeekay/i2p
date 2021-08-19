#! /usr/bin/env sh
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd $dir
git pull
make
rm -f i2pwinupdate.su3*
rm -f I2P-Profile-Installer.exe
wget https://github.com/eyedeekay/i2p/releases/download/latest/i2pwinupdate.su3
wget https://github.com/eyedeekay/i2p/releases/download/latest/I2P-Profile-Installer.exe