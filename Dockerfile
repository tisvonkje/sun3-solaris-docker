FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y build-essential && \
    apt-get install -y libgtk2.0-dev && \
    apt-get install -y aptitude && \
    apt-get install -y git

WORKDIR /sun3

COPY tme-0.8.tar.gz /sun3
RUN tar xzf tme-0.8.tar.gz

WORKDIR /sun3/tme-0.8
ENV LIBS='-lX11 -lglib-2.0'
RUN ./configure --exec-prefix /opt/tme --disable-warnings --disable-shared
#RUN ./configure --exec-prefix /opt/tme --disable-warnings --disable-shared --with-x
RUN make
RUN make install

WORKDIR /sun3
RUN git clone https://github.com/tisvonkje/Run-Sun3-SunOS-4.1.1

WORKDIR /sun3/Run-Sun3-SunOS-4.1.1
RUN gunzip sun3-disk.img.gz
