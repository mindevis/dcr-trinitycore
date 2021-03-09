#! /bin/bash

echo "Delete old compile directories"
rm -rf TrinityCore && rm -rf compiled
echo "Cloning TrinityCore repository"
git clone -b master git://github.com/TrinityCore/TrinityCore.git 
cd TrinityCore/ 
mkdir build && cd build/
echo "Compile and install Core"
cmake ../ -DSCRIPTS="static" -DTOOLS=1 -DSERVERS=1 -DCMAKE_INSTALL_PREFIX=/root/srv -DWITH_WARNINGS=0 -DUSE_COREPCH=1 -DUSE_SCRIPTPCH=1 -DCONF_DIR=/root/srv/conf -DLIBSDIR=/root/srv/lib
make -j $(nproc) && make install
echo "Compile successful"
echo "Create .tar.gz archive"
cd /root
tar -cvzf core.tar.gz srv && mkdir compiled && mv core.tar.gz compiled/core.tar.gz
echo "Successful created .tar.gz archive"