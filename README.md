# [pgbouncer-docker](https://github.com/hyperized/pgbouncer-docker)
A small Alpine based pgbouncer Docker image

## To pull container

```docker pull hyperized/pgbouncer```

## To build container

```docker build -t hyperized/pgbouncer Dockerfile```

## To run container 

```docker run -v $(pwd):/m -p 6543:6543 hyperized/pgbouncer /m/example.ini```

## To run container with TLS to PostgreSQL server

Commonly used with PHP as local connection pool to eliminate TLS overhead.

Expects `ca.crt`, `key.pem` and `cert.pem` to be present in current folder.

See `tls.ini` for details

```docker run -v $(pwd):/m -p 6543:6543 hyperized/pgbouncer /m/tls.ini```

Expect output to be like:

```shell script
2020-04-27 12:07:12.741 UTC [1] LOG kernel file descriptor limit: 1048576 (hard: 1048576); max_client_conn: 100, max expected fd use: 112
2020-04-27 12:07:12.741 UTC [1] LOG listening on 0.0.0.0:6543
2020-04-27 12:07:12.741 UTC [1] LOG listening on unix:/tmp/.s.PGSQL.6543
2020-04-27 12:07:12.741 UTC [1] LOG process up: PgBouncer 1.13.0, libevent 2.1.10-stable (epoll), adns: c-ares 1.15.0, tls: OpenSSL 1.1.1c  28 May 2019
2020-04-27 12:08:12.675 UTC [1] LOG stats: 0 xacts/s, 0 queries/s, in 0 B/s, out 0 B/s, xact 0 us, query 0 us, wait 0 us
```

To log in with this example:

```
psql -h 127.0.0.1 -p 6543 -U user@secure pgbouncer
```

with the password `mypass` (as described in `password.txt`)

## To show stats

```
psql -h 127.0.0.1 -p 6543 pgbouncer

psql (12.2, server 1.13.0/bouncer)
Type "help" for help.

pgbouncer=# SHOW STATS;
```

## Reference

Docker hub: https://hub.docker.com/r/hyperized/pgbouncer

Github: https://github.com/hyperized/pgbouncer-docker