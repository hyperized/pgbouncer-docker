FROM alpine

LABEL maintainer="Gerben Geijteman <gerben@hyperized.net>"
LABEL description="A simple pg_bouncer docker instance"

RUN apk --no-cache add --virtual build-tools make pkgconfig autoconf automake libtool py-docutils git gcc g++ && \
    apk --no-cache add libevent-dev openssl-dev c-ares-dev ca-certificates && \
    git clone --recurse-submodules -j8 https://github.com/pgbouncer/pgbouncer.git && \
    cd pgbouncer && \
    ./autogen.sh && \
    ./configure --prefix=/usr/local --with-libevent=libevent-prefix && \
    make && \
    make install && \
    apk del build-tools && \
    mkdir -m777 -p /var/run/pgbouncer/

# Healthcheck
HEALTHCHECK --interval=10s --timeout=3s CMD stat /tmp/.s.PGSQL.*

# pgbouncer can't run as root, so let's drop to 'nobody' by default :)
ENTRYPOINT ["/usr/local/bin/pgbouncer", "-u", "nobody"]
