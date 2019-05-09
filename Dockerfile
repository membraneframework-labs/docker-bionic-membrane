FROM ubuntu:19.04

SHELL ["/bin/bash", "-c"]

RUN \
    #common
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -y install git wget locales && \
    locale-gen en_US.UTF-8 && \
    echo -e '\nexport LC_ALL=en_US.UTF-8' >> ~/.bashrc && \
    # asdf
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.1 && \
    chmod u+x ~/.asdf/asdf.sh && \
    . ~/.asdf/asdf.sh && \
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc && \
    apt -y install \
      automake autoconf libreadline-dev \
      libncurses-dev libssl-dev libyaml-dev \
      libxslt-dev libffi-dev libtool unixodbc-dev \
      unzip curl && \
    # erlang
    asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git && \
    apt-get -y install \
      build-essential autoconf m4 libncurses5-dev libwxgtk3.0-dev \
      libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev \
      xsltproc fop && \
    asdf install erlang 21.3 && \
    asdf global erlang 21.3 && \
    echo -e '\nasdf global erlang 21.3' >> ~/.bashrc && \
    # elixir
    asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git && \
    asdf install elixir 1.8.1 && \
    asdf global elixir 1.8.1 && \
    echo -e '\nasdf global elixir 1.8.1' >> ~/.bashrc && \
    mix local.hex --force && \
    mix local.rebar --force

RUN \
    # libs from PM
    apt-get -y install \
      ffmpeg=7:4.1.3-0ubuntu1 libavcodec-dev libavdevice-dev libavformat-dev \
      libavfilter-dev libavformat-dev libavresample-dev libavutil-dev \
      libpostproc-dev libswresample-dev libswscale-dev \
      libsdl2-dev && \
    # fdk-aac
    wget https://downloads.sourceforge.net/opencore-amr/fdk-aac-2.0.0.tar.gz \
      -O ~/fdk-aac-2.0.0.tar.gz && \
    tar -xf ~/fdk-aac-2.0.0.tar.gz -C ~ && \
    cd ~/fdk-aac-2.0.0 \
      && ./configure --prefix=/usr --disable-static \
      && make && make install && cd ~
