#
# Dockerfile - H2O web server
#
# Site    : https://h2o.examp1e.net/
# GitHub: https://github.com/h2o/h2o
#
# - Build
# docker build --rm -t h2o:source .
#
# - Run
# docker run -d --name="h2o" -h "h2o" h2o:source
#
# Use the base images
FROM ubuntu:14.04
MAINTAINER Yongbok Kim <ruo91@yongbok.net>

# Change the repository
RUN sed -i 's/archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list

# The last update and install package for H2O
RUN apt-get update && apt-get install -y supervisor git-core \
 locate cmake build-essential checkinstall autoconf pkg-config libtool python-sphinx libcunit1-dev nettle-dev libyaml-dev libssl-dev

# Variable
ENV SRC_DIR /opt
WORKDIR $SRC_DIR

# libuv
RUN git clone https://github.com/libuv/libuv.git \
 && cd libuv && ./autogen.sh \
 && ./configure --prefix=/usr \
 && make && make install \
 && cd $SRC_DIR && rm -rf libuv

# wslay
RUN git clone https://github.com/tatsuhiro-t/wslay.git \
 && cd wslay && autoreconf -i && automake && autoconf \
 && ./configure && make && make install \
 && cd $SRC_DIR && rm -rf wslay

# OpenSSL
ENV OPENSSL_INCLUDE_DIR /usr/include
ENV LD_LIBRARY_PATH /lib/x86_64-linux-gnu
ENV OPENSSL_LIBRARIES $LIBRARY_DIR/libssl.so;$LIBRARY_DIR/libcrypto.so

RUN cd $LD_LIBRARY_PATH \
 && ln -s libssl.so* libssl.so \
 && ln -s libcrypto.so* libcrypto.so

# H2O
ENV H2O_PREFIX /usr/local/h2o
ENV CMAKE_FILE cmake/FindOpenSSL.cmake
RUN git clone https://github.com/h2o/h2o.git \
 && cd h2o \
 && echo 'FIND_PATH(OPENSSL_INCLUDE_DIR NAMES openssl/ssl.h)' > $CMAKE_FILE \
 && echo 'INCLUDE(FindPackageHandleStandardArgs)' >> $CMAKE_FILE \
 && echo 'FIND_PACKAGE_HANDLE_STANDARD_ARGS(OPENSSL DEFAULT_MSG OPENSSL_LIBRARIES OPENSSL_INCLUDE_DIR)' >> $CMAKE_FILE \
 && cmake \
 -DCMAKE_INSTALL_PREFIX="$H2O_PREFIX" \
 -DOPENSSL_INCLUDE_DIR="OPENSSL_INCLUDE_DIR" \
 -DOPENSSL_LIBRARIES="$OPENSSL_LIBRARIES" \
 && make && make install \
 && cd $SRC_DIR && rm -rf h2o \
 && echo '' >> /etc/profile \
 && echo '# H2O Web Server' >> /etc/profile \
 && echo "export H2O_PREFIX=$H2O_PREFIX" >> /etc/profile \
 && echo 'export PATH=$PATH:$H2O_PREFIX/bin:$H2O_PREFIX/share/h2o' >> /etc/profile

# Add html and configuration file
ENV H2O_DIR /etc/h2o
ADD conf/h2o $H2O_DIR
RUN mkdir $H2O_DIR/logs \
 && mkdir $H2O_DIR/run

# Supervisor
RUN mkdir -p /var/log/supervisor
ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Port
EXPOSE 80

# Daemon
CMD ["/usr/bin/supervisord"]
