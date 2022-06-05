FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
wget ca-certificates gnupg2 \
libgtk2.0-0 libxtst6 \
libnss3 libnss3-tools \
libnspr4 \
libatk-bridge2.0-0 \
libx11-xcb-dev \
libgl1-mesa-dri libxcb-dri3-0 libxcb-dri3-dev \
libdrm2 libdrm-dev \
libgbm1 libgbm-dev \
libasound2 libasound2-dev \
libatspi2.0-0 libatspi2.0-dev \
libxss1 libxss-dev \
libxkbcommon0 libxshmfence1 \
git \
tzdata \
&& apt-get update \
&& apt-get upgrade -y \
&& apt-get remove -fy \
&& apt-get autoclean -y \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

RUN mkdir /phpstorm \
&& export PS_VAR=$(wget -qO- "https://data.services.jetbrains.com/products/releases?code=PS&latest=true&type=release" 2>&1 | grep -oP '(?<="version":")(.*?)(?=")') \
&& wget -O - https://download.jetbrains.com/webide/PhpStorm-$PS_VAR.tar.gz | tar xzf - -C "/phpstorm" --strip-components=1

ARG UNAME=udocker
ARG UID=1000
ARG GNAME=$UNAME
ARG GID=1000
ARG GROUPS=$GNAME

RUN groupadd -g $GID $GNAME \
&& useradd --create-home -d /home/$UNAME -g $GID -u $UID $UNAME \
&& usermod -a -G $GROUPS $UNAME
USER $UNAME
WORKDIR /home/$UNAME

ENTRYPOINT ["/phpstorm/bin/phpstorm.sh"]

