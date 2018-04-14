FROM ubuntu

LABEL maintainer="hi@rog.gr"

RUN \
  apt-get update && \
  apt-get install -y \
          build-essential git make python \
          cmake libboost-system-dev libboost-dev libboost-date-time-dev \
          libboost-filesystem-dev libboost-iostreams-dev libboost-python-dev \
          libboost-regex-dev libgmp3-dev libmpfr-dev libboost-test-dev

RUN \
  git clone https://github.com/ledger/ledger /tmp/ledger && \
  cd /tmp/ledger && \
  git checkout -b stable v3.1 && \
  git submodule update --init && \
  ./acprep make && \
  make check && \
  make install && \
  cd / && \
  rm -rf /tmp/ledger

ADD ./.ledgerrc /root/.ledgerrc
ADD ./scripts /root/

ENTRYPOINT ["ledger"]

