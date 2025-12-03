# [pgbouncer-docker](https://github.com/hyperized/pgbouncer-docker)
A small Alpine based pgbouncer Docker image

## To pull container

```docker pull hyperized/pgbouncer```

## To build container

```docker build -t hyperized/pgbouncer .```

## To run container 

```docker run -v $(pwd):/m -p 6543:6543 hyperized/pgbouncer /m/example.ini```

## To run container with TLS to PostgreSQL server

Commonly used with PHP as local connection pool to eliminate TLS overhead.

Expects `ca.crt`, `key.pem` and `cert.pem` to be present in current folder.

See `tls.ini` for details

```docker run -v $(pwd):/m -p 6543:6543 hyperized/pgbouncer /m/tls.ini```

Expect output to be like:

```shell script
2025-12-03 20:06:54.210 UTC [1] LOG kernel file descriptor limit: 1048576 (hard: 1048576); max_client_conn: 100, max expected fd use: 152
2025-12-03 20:06:54.211 UTC [1] LOG listening on 0.0.0.0:6543
2025-12-03 20:06:54.212 UTC [1] LOG listening on unix:/tmp/.s.PGSQL.6543
2025-12-03 20:06:54.213 UTC [1] LOG process up: PgBouncer 1.25.1, libevent 2.1.12-stable (epoll), adns: c-ares 1.34.5, tls: OpenSSL 3.5.4 30 Sep 2025
```

To log in with this example:

```
psql -h 127.0.0.1 -p 6543 -U user@secure pgbouncer
```

with the password `mypass` (as described in `password.txt`)

## To show stats

```
psql -h 127.0.0.1 -p 6543 pgbouncer

psql (18.0, server 1.25.0/bouncer)
Type "help" for help.

pgbouncer=# SHOW STATS;
```

## Reference

Docker hub: https://hub.docker.com/r/hyperized/pgbouncer

Github: https://github.com/hyperized/pgbouncer-docker
