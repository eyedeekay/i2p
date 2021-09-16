#! /usr/bin/env sh
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd $dir
make version-sh
if [ -z $VERSION ]; then
	. ./version.sh
fi

git pull
make
rm -f i2pwinupdate.su3*
rm -f I2P-Profile-Installer.exe*
rm -f I2P-Profile.tgz*
rm -f I2P-App-Profile.tgz*

wget -O i2pwinupdate-"$VERSION"-signed.su3 https://github.com/eyedeekay/i2p/releases/download/latest/i2pwinupdate.su3
wget -O I2P-Profile-Installer-"$VERSION"-signed.exe https://github.com/eyedeekay/i2p/releases/download/latest/I2P-Profile-Installer.exe

cp i2pwinupdate-"$VERSION"-signed.su3 i2pwinupdate.su3
cp I2P-Profile-Installer-"$VERSION"-signed.exe I2P-Profile-Installer.exe

wget https://github.com/eyedeekay/i2p/releases/download/latest/I2P-Profile.tgz
wget https://github.com/eyedeekay/i2p/releases/download/latest/I2P-App-Profile.tgz
