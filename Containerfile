FROM archlinux:base-devel-20260308.0.497099 AS builder

ARG VALKEY_VERSION
ARG ZLIB_VERSION
ARG OPENSSL_VERSION

ARG OPENSSL_SOURCE=https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
ARG ZLIB_SOURCE=https://zlib.net/zlib-${ZLIB_VERSION}.tar.gz
ARG VALKEY_SOURCE=https://github.com/valkey-io/valkey/archive/refs/tags/${VALKEY_VERSION}.tar.gz

RUN pacman -Sy --noconfirm python >/dev/null

WORKDIR /build/zlib
RUN curl --silent --show-error --location --output zlib.tar.gz \
    "${ZLIB_SOURCE}" \
    && tar xf zlib.tar.gz --strip-components=1 \
    && ./configure --prefix=/usr \
    && make -s -j$(nproc) \
    && make install DESTDIR=/base

WORKDIR /build/openssl
RUN curl --silent --show-error --location --output openssl.tar.gz \
    "${OPENSSL_SOURCE}" \
    && tar xf openssl.tar.gz --strip-components=1 \
    && ./Configure linux-x86_64 \
        --prefix=/usr \
        --libdir=/usr/lib \
        no-tests no-docs \
        --with-zlib-include=/base/usr/include \
        --with-zlib-lib=/base/usr/lib \
    && make -s -j$(nproc) \
    && make install DESTDIR=/base

WORKDIR /build/valkey
RUN curl --silent --show-error --location --output valkey.tar.gz \
    "${VALKEY_SOURCE}" \
    && tar xf valkey.tar.gz --strip-components=1 \
    && make BUILD_TLS=yes USE_SYSTEM_OPENSSL=yes \
          USE_SYSTEMD=no PREFIX=/usr \
          CFLAGS="-I/base/usr/include" \
          LDFLAGS="-L/base/usr/lib" \
          -j$(nproc) \
    && make install INSTALL_BIN=/base/usr/bin

RUN rm -fr \
    /base/usr/share/{doc,info,man} \
    /base/usr/lib/pkgconfig \
    /base/usr/lib/cmake

FROM ghcr.io/simons-containers/distroless-glibc

ARG VALKEY_VERSION
ARG ZLIB_VERSION
ARG OPENSSL_VERSION

COPY --from=builder /base/usr/lib/ /usr/lib/
COPY --from=builder /base/usr/share/ /usr/share/
COPY --from=builder /base/usr/bin/ /usr/bin/

COPY ./passwd /etc/passwd
COPY ./shadow /etc/shadow

USER valkey
WORKDIR /var/lib/valkey

ENTRYPOINT ["valkey-server"]
CMD ["/etc/valkey/server.conf"]

LABEL org.opencontainers.image.title="distroless valkey"
LABEL org.opencontainers.image.description="distroless valkey"
LABEL org.opencontainers.image.version="${VALKEY_VERSION}"
LABEL org.opencontainers.image.source="https://github.com/simons-containers/distroless-valkey"
LABEL org.opencontainers.image.volumes.config="/etc/valkey"
LABEL org.opencontainers.image.base.libs="zlib@${ZLIB_VERSION},openssl@${OPENSSL_VERSION}"
