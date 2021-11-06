
VERSION=`date +%m%d%y`
AIO_VERSION="1.05.1"
LATEST_VERSION=latest

args="-r -p 7673 -n eephttpd-jpackage"
samhost=localhost
samport=7656
eephttpd=eephttpd-jpackage

version-sh:
	echo VERSION=$(AIO_VERSION) > version.sh

index: version-sh README osx
	@echo "<!DOCTYPE html>" > index.html
	@echo "<html>" >> index.html
	@echo "<head>" >> index.html
	@echo "  <title>Experimental I2P Jpackage Installers</title>" >> index.html
	@echo "  <link rel=\"stylesheet\" type=\"text/css\" href =\"home.css\" />" >> index.html
	@echo "</head>" >> index.html
	@echo "<body>" >> index.html
	markdown README.md | tee -a index.html
	@echo "</body>" >> index.html
	@echo "</html>" >> index.html

osx:
	@echo "<!DOCTYPE html>" > osx.html
	@echo "<html>" >> osx.html
	@echo "<head>" >> osx.html
	@echo "  <title>Experimental I2P Jpackage Installers</title>" >> osx.html
	@echo "  <link rel=\"stylesheet\" type=\"text/css\" href =\"home.css\" />" >> osx.html
	@echo "</head>" >> osx.html
	@echo "<body>" >> osx.html
	markdown OSX.md | tee -a osx.html
	@echo "</body>" >> osx.html
	@echo "</html>" >> osx.html

README:


##==------------------------------------------------------------------------==##
#    IMPORTANT! Before you run these targets, ensure that ~/i2p.firefox is     #
#     synced with the i2p.firefox build directory on your Windows build        #
#     environment.                                                             #
##==------------------------------------------------------------------------==##

update: version-sh latest-version version

latest-version: version-sh latest upload-linux upload-windows 

version: version-sh new upload-linux-new upload-windows-new

latest:
	gothub delete -u eyedeekay -r i2p -t $(LATEST_VERSION); true
	gothub release -p -u eyedeekay -r i2p -t $(LATEST_VERSION) -n "Update Packages for `date`" -d "I2P+Jpackage Updates for `date`"; true

upload-linux:
	#gothub upload -R -u eyedeekay -r i2p -t $(LATEST_VERSION) -n "I2P-Profile.tgz" -f "$(HOME)/Workspace/GIT_WORK/i2p.firefox/profile-$(AIO_VERSION).tgz"
	#gothub upload -R -u eyedeekay -r i2p -t $(LATEST_VERSION) -n "I2P-App-Profile.tgz" -f "$(HOME)/Workspace/GIT_WORK/i2p.firefox/app-profile-$(AIO_VERSION).tgz"

lexesum=`sha256sum "$(HOME)/i2p.firefox/I2P-Profile-Installer-$(AIO_VERSION).exe" | sed "s|$(HOME)||g"`
lexesumsigned=`sha256sum "$(HOME)/i2p.firefox/I2P-Profile-Installer-$(AIO_VERSION)-signed.exe" | sed "s|$(HOME)||g"`
lsu3sum=`sha256sum "$(HOME)/i2p.firefox/I2P-Profile-Installer-$(AIO_VERSION)-signed.su3" | sed "s|$(HOME)||g"`

sums:
	@echo "$(lexesum)"
	@echo "$(lexesumsigned)"
	@echo "$(lsu3sum)"

upload-windows:
	gothub upload -R -u eyedeekay -r i2p -t $(LATEST_VERSION) -n "I2P-Profile-Installer-unsigned.exe" -l "$(lexesum)" -f "$(HOME)/i2p.firefox/I2P-Profile-Installer-$(AIO_VERSION).exe"
	gothub upload -R -u eyedeekay -r i2p -t $(LATEST_VERSION) -n "I2P-Profile-Installer.exe" -l "$(lexesumsigned)" -f "$(HOME)/i2p.firefox/I2P-Profile-Installer-$(AIO_VERSION)-signed.exe"
	
upload-windows-su3:
	gothub upload -R -u eyedeekay -r i2p -t $(LATEST_VERSION) -n "i2pwinupdate.su3" -l "$(lsu3sum)" -f "$(HOME)/i2p.firefox/I2P-Profile-Installer-$(AIO_VERSION)-signed.su3"

new:
	gothub release -p -u eyedeekay -r i2p -t $(VERSION) -n "Update Packages for `date`" -d "I2P+Jpackage Updates for `date`"; true

upload-linux-new:
	#gothub upload -R -u eyedeekay -r i2p -t $(VERSION) -n "I2P-Profile.tgz" -f "$(HOME)/Workspace/GIT_WORK/i2p.firefox/profile-$(AIO_VERSION).tgz"
	#gothub upload -R -u eyedeekay -r i2p -t $(VERSION) -n "I2P-App-Profile.tgz" -f "$(HOME)/Workspace/GIT_WORK/i2p.firefox/app-profile-$(AIO_VERSION).tgz"

upload-windows-new:
	gothub upload -R -u eyedeekay -r i2p -t $(VERSION) -n "I2P-Profile-Installer-unsigned.exe" -l "$(lexesum)" -f "$(HOME)/i2p.firefox/I2P-Profile-Installer-$(AIO_VERSION).exe"

upload-windows-new-signed:	
	gothub upload -R -u eyedeekay -r i2p -t $(VERSION) -n "I2P-Profile-Installer.exe" -l "$(lexesumsigned)" -f "$(HOME)/i2p.firefox/I2P-Profile-Installer-$(AIO_VERSION)-signed.exe"

upload-windows-su3-new:
	gothub upload -R -u eyedeekay -r i2p -t $(VERSION) -n "i2pwinupdate.su3" -l "$(lsu3sum)" -f "$(HOME)/i2p.firefox/I2P-Profile-Installer-$(AIO_VERSION)-signed.su3"

run:
	docker rm -f $(eephttpd); true
	docker run -i -t -d \
		--env samhost="localhost" \
		--env samport=$(samport) \
		--env args=$(args) \
		--network host \
		--hostname $(eephttpd) \
		--name $(eephttpd) \
		--restart always \
		--volume $(PWD):/opt/eephttpd/www \
		eyedeekay/eephttpd
