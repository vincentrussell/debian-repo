#!/bin/sh

set -x

mkdir -p $REPO_ROOT
sudo chown -R ${USER}:${GROUP} $REPO_ROOT
cd $REPO_ROOT
sudo rm -f Release
sudo rm -rf Packagages
sudo rm -rf Packagages.gz
sudo dpkg-scanpackages . /dev/null > Release
sudo dpkg-scanpackages -m . > Packages
sudo dpkg-scanpackages -m . | gzip > Packages.gz
sudo chown -R ${USER}:${GROUP} .

#if [[ ! -f /certs/repo.rsa.private.key ]]; then
#    echo "generating certs...."
#    abuild-keygen -n
#    ls -alh /home/$USER/.abuild/
#    mv /home/$USER/.abuild/*.rsa /certs/repo.rsa.private.key
#    mv /home/$USER/.abuild/*.pub $APK_ROOT
#fi

#if [[ -f $APK_ROOT/v$VERSION/main/$ARCH/APKINDEX.tar.gz ]]; then
#    sudo abuild-sign -k /certs/repo.rsa.private.key $APK_ROOT/v$VERSION/main/$ARCH/APKINDEX.tar.gz
#    sudo chown ${USER}:${GROUP} $APK_ROOT/v$VERSION/main/$ARCH/APKINDEX.tar.gz
#fi

