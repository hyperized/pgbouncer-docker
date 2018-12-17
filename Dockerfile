FROM alpine

LABEL maintainer="Gerben Geijteman <gerben@hyperized.net>"
LABEL description="A simple pg_bouncer docker instance"

RUN apk --no-cache add make libevent-dev pkgconfig openssl-dev c-ares-dev autoconf automake libtool py-docutils git gcc g++ ca-certificates netcat-openbsd
RUN git clone https://github.com/pgbouncer/pgbouncer.git
WORKDIR pgbouncer
RUN git submodule init
RUN git submodule update
RUN ./autogen.sh
RUN ./configure --prefix=/usr/local --with-libevent=libevent-prefix
RUN make
RUN make install

# pgbouncer can't run as root, so let's drop to 'nobody'
RUN mkdir -m777 -p /var/run/pgbouncer/

# Healthcheck
HEALTHCHECK --interval=10s --timeout=3s CMD nc -z localhost 6543

ENTRYPOINT ["/usr/local/bin/pgbouncer", "-u", "nobody"]
