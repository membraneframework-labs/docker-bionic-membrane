FROM ubuntu:18.04

ENV BASH_ENV=~/.init

SHELL ["/bin/bash", "-c"]

RUN \
    #common
    echo -e 'unset BASH_ENV' > ~/.init && \
    . ~/.init && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -y install git wget locales software-properties-common && \
    locale-gen en_US.UTF-8 && \
    echo -e '\nexport LC_ALL=en_US.UTF-8' >> ~/.init && \
    # asdf
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.1 && \
    chmod u+x ~/.asdf/asdf.sh && \
    . ~/.asdf/asdf.sh && \
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.init && \
    apt -y install \
      automake autoconf libreadline-dev \
      libncurses-dev libssl-dev libyaml-dev \
      libxslt-dev libffi-dev libtool unixodbc-dev \
      unzip curl

RUN \
    # erlang
    asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git && \
    apt-get -y install \
      build-essential autoconf m4 libncurses5-dev libwxgtk3.0-dev \
      libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev \
      xsltproc fop && \
    asdf install erlang 21.3 && \
    asdf global erlang 21.3 && \
    echo -e '\nasdf global erlang 21.3' >> ~/.init

RUN \
    # elixir
    asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git && \
    asdf install elixir 1.8.1 && \
    asdf global elixir 1.8.1 && \
    echo -e '\nasdf global elixir 1.8.1' >> ~/.init && \
    mix local.hex --force && \
    mix local.rebar --force

RUN \
    # ffmpeg
    add-apt-repository -y ppa:jonathonf/ffmpeg-4 && apt-get update && \
    apt-get -y install \
      ffmpeg=7:4.1.3-0york1~18.04 libavcodec-dev libavdevice-dev libavformat-dev \
      libavfilter-dev libavformat-dev libavresample-dev libavutil-dev \
      libpostproc-dev libswresample-dev libswscale-dev && \
    # sdl
    apt-get -y install libsdl2-dev && \
    #fdk-aac
    cd /tmp && \
      wget https://downloads.sourceforge.net/opencore-amr/fdk-aac-2.0.0.tar.gz && \
      tar -xf fdk-aac-2.0.0.tar.gz && cd fdk-aac-2.0.0 && \
        ./configure --prefix=/usr --disable-static \
        && make && make install && cd .. && \
      rm -rf fdk-aac-2.0.0 && rm fdk-aac-2.0.0.tar.gz && cd / \
