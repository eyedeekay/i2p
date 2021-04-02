
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
