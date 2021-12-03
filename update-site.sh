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
wget -O i2p-firefox_"$VERSION"-1_amd64.deb https://github.com/eyedeekay/i2p/releases/download/latest/i2p-firefox_1.05.0-1_amd64.deb

cp i2pwinupdate-"$VERSION"-signed.su3 i2pwinupdate.su3
cp I2P-Profile-Installer-"$VERSION"-signed.exe I2P-Profile-Installer.exe

wget https://github.com/eyedeekay/i2p/releases/download/latest/I2P-Profile.tgz
wget https://github.com/eyedeekay/i2p/releases/download/latest/I2P-App-Profile.tgz

mkdir -p "$HOME/eephttpd-jpackage-data"
chown -R 1000:1000 "$HOME/eephttpd-jpackage-data"
docker pull eyedeekay/eephttpd
docker rm -f eephttpd-jpackage; true
docker run -i -t -d \
	--env samhost="localhost" \
	--env samport="7656" \
	--env args="-r -p 7673 -n eephttpd-jpackage" \
	--user 1000:1000 \
	--network host \
	--hostname eephttpd-jpackage \
	--name eephttpd-jpackage \
	--restart always \
	--volume "$HOME/eephttpd-jpackage-data":/opt/eephttpd/keys:rw \
	--volume "$dir":/opt/eephttpd/www \
	eyedeekay/eephttpd
sleep 5s
ls "$HOME/eephttpd-jpackage-data"
