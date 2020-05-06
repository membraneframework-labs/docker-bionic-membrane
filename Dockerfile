FROM ubuntu:20.04

SHELL ["/bin/bash", "-c"]

RUN \
    # common
    touch ~/.init && \
    echo -e "\n. ~/.init\n" >> ~/.bash_profile && \
    echo -e "\n. ~/.init\n" >> ~/.bashrc && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -y install build-essential git wget locales software-properties-common && \
    locale-gen en_US.UTF-8 && \
    echo -e 'export LC_ALL=en_US.UTF-8\n' >> ~/.init && \
    # gcc
    add-apt-repository ppa:ubuntu-toolchain-r/test -y && apt-get update && \
    apt-get install gcc-9 -y && \
    # asdf
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.1 && \
    chmod u+x ~/.asdf/asdf.sh && \
    . ~/.asdf/asdf.sh && \
    echo -e '. $HOME/.asdf/asdf.sh\n' >> ~/.init && \
    apt -y install \
    automake autoconf libreadline-dev \
    libncurses-dev libssl-dev libyaml-dev \
    libxslt-dev libffi-dev libtool unixodbc-dev \
    unzip curl

RUN . ~/.init && \
    # erlang
    apt-get update && \
    asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git && \
    apt-get -y install \
    build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev \
    libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev \
    xsltproc fop && \
    asdf install erlang 22.3 && \
    asdf global erlang 22.3 && \
    echo -e 'asdf global erlang 22.3\n' >> ~/.init

RUN . ~/.init && \
    # elixir
    asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git && \
    asdf install elixir 1.10.3 && \
    asdf global elixir 1.10.3 && \
    echo -e 'asdf global elixir 1.10.3\n' >> ~/.init && \
    mix local.hex --force && \
    mix local.rebar --force

RUN . ~/.init && \
    apt-get update && \
    # ffmpeg
    apt-get -y install \
    ffmpeg=7:4.2.2-1ubuntu1 libavcodec-dev libavdevice-dev libavformat-dev \
    libavfilter-dev libavformat-dev libavresample-dev libavutil-dev \
    libpostproc-dev libswresample-dev libswscale-dev && \
    # sdl
    apt-get -y install libsdl2-dev && \
    # fdk-aac
    cd /tmp && \
    wget https://downloads.sourceforge.net/opencore-amr/fdk-aac-2.0.0.tar.gz && \
    tar -xf fdk-aac-2.0.0.tar.gz && cd fdk-aac-2.0.0 && \
    ./configure --prefix=/usr --disable-static \
    && make && make install && cd .. && \
    rm -rf fdk-aac-2.0.0 && rm fdk-aac-2.0.0.tar.gz && cd / && \
    # portaudio
    apt-get -y install portaudio19-dev && \
    # mad
    apt-get -y install libmad0-dev && \
    # flac
    apt-get -y install libflac-dev && \
    # opus
    apt-get -y install libopus-dev
