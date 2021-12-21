FROM debian

LABEL maintainer="mindevis.by@gmail.com" version="1.0" description="Compiling TrinityCore in Docker container"
SHELL [ "/bin/bash", "-c" ]
USER root:root

# Update system and clear caches
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget git clang cmake make gcc g++ libmariadb-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev libboost-all-dev mariadb-server p7zip default-libmysqlclient-dev
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang 100
RUN apt-get autoclean -y && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

WORKDIR "/root"
RUN wget https://raw.githubusercontent.com/mindevis/dcr-trinitycore/main/compile.sh && chmod +x compile.sh
ENTRYPOINT [ "./compile.sh" ]