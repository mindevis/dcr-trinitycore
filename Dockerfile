FROM debian

LABEL maintainer="mindevis.by@gmail.com" version="0.1" description="Compiling TrinityCore in Docker container"
SHELL [ "/bin/bash", "-c" ]
USER root:root

# Update system and clear caches
RUN apt-get update && \
apt-get upgrade -y && \
apt-get install -y git clang cmake make gcc g++ libmariadbclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev libboost-all-dev mariadb-server p7zip default-libmysqlclient-dev && \
update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 && \
update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang 100 && \
apt-get autoclean -y && apt-get autoremove -y && \
rm -rf /var/lib/apt/lists/* && \
cd /root && git clone -b master git://github.com/TrinityCore/TrinityCore.git && \
cd TrinityCore && mkdir build && cd build && \ 
cmake ../ -DSCRIPTS="static" -DTOOLS=1 -DSERVERS=1 -DCMAKE_INSTALL_PREFIX=/root/srv -DWITH_WARNINGS=0 -DUSE_COREPCH=1 -DUSE_SCRIPTPCH=1 -DCONF_DIR=/root/srv/conf -DLIBSDIR=/root/srv/lib && \
make -j $(nproc) && make install && \
cd /root && tar -cvzf core.tar.gz srv && rm -rf srv && rm -rf TrinityCore