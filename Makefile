
VERSION=`date +%m%d%y`
AIO_VERSION="0.04.0"
LATEST_VERSION=latest

index: README osx
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

update: new
	gothub delete -u eyedeekay -r i2p -t $(LATEST_VERSION); true
	gothub release -p -u eyedeekay -r i2p -t $(LATEST_VERSION) -n "Update Packages for `date`" -d "I2P+Jpackage Updates for `date`"; true
	gothub upload -R -u eyedeekay -r i2p -t $(LATEST_VERSION) -n "i2pwinupdate.su3" -f "$(HOME)/i2p.firefox/I2P-Profile-Installer-$(AIO_VERSION).su3"

new:
	gothub release -p -u eyedeekay -r i2p -t $(VERSION) -n "Update Packages for `date`" -d "I2P+Jpackage Updates for `date`"; true
	gothub upload -R -u eyedeekay -r i2p -t $(VERSION) -n "i2pwinupdate.su3" -f "$(HOME)/i2p.firefox/I2P-Profile-Installer-$(AIO_VERSION).su3"
	