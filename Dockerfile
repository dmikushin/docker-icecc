FROM ubuntu:jammy
MAINTAINER dmitry@kernelgen.org

ENV ICECC_ENABLE_SCHEDULER=0

USER root

COPY scripts/build.sh /tmp/build.sh
COPY scripts/icecc-run.sh /usr/local/bin/icecc-run.sh

RUN apt-get -y update && \
  apt-get -y install build-essential autoconf pkg-config git libtool libcap-ng-dev \
  liblzo2-dev libzstd-dev libarchive-dev
RUN apt-get -y install sudo

RUN /tmp/build.sh

RUN useradd --create-home -s /bin/bash icecc
RUN echo "icecc ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/icecc
WORKDIR /home/icecc
CMD /bin/bash

USER icecc

EXPOSE 10245 8765/TCP 8765/UDP 8766

ENTRYPOINT ["/usr/local/bin/icecc-run.sh"]
