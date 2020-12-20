#
#  Docker build and run
#
#  Alex Shvid
#

FROM ubuntu:18.04

LABEL maintainer "Alex Shvid <a@shvid.com>"

ENV DEBIAN_FRONTEND noninteractive

# Prerequisite and locale
RUN apt-get update &&\
    apt-get autoclean &&\
    apt-get install -y ca-certificates && \
    apt-get -y install locales python3 python3-pip git wget nano fish mc lib32stdc++6 tzdata && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV REQUESTS_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt
ENV LANG en_US.UTF-8

ARG GO_VER

RUN echo "Download GoLang" && \
    wget -q https://dl.google.com/go/go${GO_VER}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GO_VER}.linux-amd64.tar.gz && \
    rm go${GO_VER}.linux-amd64.tar.gz

ENV GOROOT=/usr/local/go/
ENV PATH=$PATH:$GOROOT/bin
ENV GOPATH=/go

# Prefetch some x packages
RUN go get \
  golang.org/x/crypto/acme \
  golang.org/x/crypto/acme/autocert \
  golang.org/x/crypto/argon2 \
  golang.org/x/crypto/bcrypt \
  golang.org/x/crypto/blake2b \
  golang.org/x/crypto/blake2s \
  golang.org/x/crypto/blowfish \
  golang.org/x/crypto/bn256 \
  golang.org/x/crypto/cast5 \
  golang.org/x/crypto/chacha20poly1305 \
  golang.org/x/crypto/cryptobyte \
  golang.org/x/crypto/curve25519 \
  golang.org/x/crypto/ed25519 \
  golang.org/x/crypto/hkdf \
  golang.org/x/crypto/md4 \
  golang.org/x/crypto/ocsp \
  golang.org/x/crypto/openpgp \
  golang.org/x/crypto/otr \
  golang.org/x/crypto/pbkdf2 \
  golang.org/x/crypto/pkcs12 \
  golang.org/x/crypto/poly1305 \
  golang.org/x/crypto/ripemd160 \
  golang.org/x/crypto/salsa20 \
  golang.org/x/crypto/scrypt \
  golang.org/x/crypto/sha3 \
  golang.org/x/crypto/ssh \
  golang.org/x/crypto/tea \
  golang.org/x/crypto/twofish \
  golang.org/x/crypto/xtea \
  golang.org/x/crypto/xts \
  golang.org/x/net/bpf \
  golang.org/x/net/context \
  golang.org/x/net/dict \
  golang.org/x/net/html \
  golang.org/x/net/http/httpguts \
  golang.org/x/net/http/httpproxy \
  golang.org/x/net/http2 \
  golang.org/x/net/http2/h2c \
  golang.org/x/net/http2/h2i \
  golang.org/x/net/http2/hpack \
  golang.org/x/net/icmp \
  golang.org/x/net/idna \
  golang.org/x/net/ipv4 \
  golang.org/x/net/ipv6 \
  golang.org/x/net/nettest \
  golang.org/x/net/netutil \
  golang.org/x/net/proxy \
  golang.org/x/net/publicsuffix \
  golang.org/x/net/trace \
  golang.org/x/net/webdav \
  golang.org/x/net/websocket \
  golang.org/x/net/xsrftoken \
  golang.org/x/sys/cpu \
  golang.org/x/sys/unix \
  golang.org/x/text/cases \
  golang.org/x/text/cmd/gotext \
  golang.org/x/text/collate \
  golang.org/x/text/collate/build \
  golang.org/x/text/collate/tools/colcmp \
  golang.org/x/text/currency \
  golang.org/x/text/date \
  golang.org/x/text/encoding \
  golang.org/x/text/encoding/charmap \
  golang.org/x/text/encoding/htmlindex \
  golang.org/x/text/encoding/ianaindex \
  golang.org/x/text/encoding/internal \
  golang.org/x/text/encoding/internal/enctest \
  golang.org/x/text/encoding/internal/identifier \
  golang.org/x/text/encoding/japanese \
  golang.org/x/text/encoding/korean \
  golang.org/x/text/encoding/simplifiedchinese \
  golang.org/x/text/encoding/traditionalchinese \
  golang.org/x/text/encoding/unicode \
  golang.org/x/text/encoding/unicode/utf32 \
  golang.org/x/text/feature/plural \
  golang.org/x/text/language \
  golang.org/x/text/language/display \
  golang.org/x/text/message \
  golang.org/x/text/message/catalog \
  golang.org/x/text/message/pipeline \
  golang.org/x/text/number \
  golang.org/x/text/runes \
  golang.org/x/text/search \
  golang.org/x/text/secure \
  golang.org/x/text/secure/bidirule \
  golang.org/x/text/secure/precis \
  golang.org/x/text/transform \
  golang.org/x/text/unicode \
  golang.org/x/text/unicode/bidi \
  golang.org/x/text/unicode/cldr \
  golang.org/x/text/unicode/norm \
  golang.org/x/text/unicode/rangetable \
  golang.org/x/text/unicode/runenames \
  golang.org/x/text/width
