FROM alpine:3.10.2 AS builder

ARG build_tag=pgbouncer_1_12_0

RUN wget https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-linux.tar.gz
RUN tar xvzf pandoc-2.7.3-linux.tar.gz --strip-components 1 -C /usr/local

RUN apk --no-cache add make pkgconfig autoconf automake libtool py-docutils git gcc g++ libevent-dev openssl-dev c-ares-dev ca-certificates
RUN git clone --branch ${build_tag} --recurse-submodules -j8 https://github.com/pgbouncer/pgbouncer.git

WORKDIR pgbouncer

RUN ./autogen.sh
RUN ./configure --prefix=/pgbouncer
RUN make
RUN make install

FROM alpine:3.10.2

LABEL maintainer="Gerben Geijteman <gerben@hyperized.net>"
LABEL description="A simple pg_bouncer docker instance"

RUN apk --no-cache add libevent openssl c-ares

COPY --from=builder /pgbouncer /pgbouncer

# Healthcheck
HEALTHCHECK --interval=10s --timeout=3s CMD stat /tmp/.s.PGSQL.*

# pgbouncer can't run as root, so let's drop to 'nobody' by default :)
ENTRYPOINT ["/pgbouncer/bin/pgbouncer", "-u", "nobody"]
