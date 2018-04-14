FROM ubuntu

LABEL maintainer="hi@rog.gr"

RUN \
  apt-get update && \
  apt-get install -y \
          build-essential cmake doxygen \
          libboost-system-dev libboost-dev python-dev gettext git \
          libboost-date-time-dev libboost-filesystem-dev \
          libboost-iostreams-dev libboost-python-dev libboost-regex-dev \
          libboost-test-dev libedit-dev libgmp3-dev libmpfr-dev texinfo
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

