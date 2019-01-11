FROM alpine AS builder

LABEL maintainer="Gerben Geijteman <gerben@hyperized.net>"
LABEL description="A simple pg_bouncer docker instance"

RUN apk --no-cache add make pkgconfig autoconf automake libtool py-docutils git gcc g++ libevent-dev openssl-dev c-ares-dev ca-certificates
RUN git clone --recurse-submodules -j8 https://github.com/pgbouncer/pgbouncer.git
WORKDIR pgbouncer
RUN ./autogen.sh
RUN ./configure --prefix=/pgbouncer --with-libevent=libevent-prefix
RUN make
RUN make install

FROM alpine
RUN apk --no-cache add libevent openssl c-ares
COPY --from=builder /pgbouncer /usr/lib/pgbouncer

# Healthcheck
HEALTHCHECK --interval=10s --timeout=3s CMD stat /tmp/.s.PGSQL.*

# pgbouncer can't run as root, so let's drop to 'nobody' by default :)
ENTRYPOINT ["/usr/local/bin/pgbouncer", "-u", "nobody"]
