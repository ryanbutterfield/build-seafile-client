FROM ubuntu:24.04

RUN apt update && \
  apt upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt install -y autoconf automake libtool libevent-dev \
  libcurl4-openssl-dev libgtk-3-dev uuid-dev intltool libsqlite3-dev valac libjansson-dev \
  qtchooser qtbase5-dev libqt5webkit5-dev qttools5-dev qttools5-dev-tools cmake \
  python3-simplejson libssl-dev build-essential devscripts debhelper wget dh-python \
  libwebsockets-dev qtwebengine5-dev

WORKDIR /data

COPY libsearcpc-fix-pkgconfig-paths.patch /libsearcpc-fix-pkgconfig-paths.patch
COPY seafile-fix-pkgconfig-paths.patch /seafile-fix-pkgconfig-paths.patch

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]