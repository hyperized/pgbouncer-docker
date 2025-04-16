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
2025-04-16 19:19:36.846 UTC [1] LOG kernel file descriptor limit: 1048576 (hard: 1048576); max_client_conn: 100, max expected fd use: 152
2025-04-16 19:19:36.846 UTC [1] LOG listening on 0.0.0.0:6543
2025-04-16 19:19:36.847 UTC [1] LOG listening on unix:/tmp/.s.PGSQL.6543
2025-04-16 19:19:36.847 UTC [1] LOG process up: PgBouncer 1.24.1, libevent 2.1.12-stable (epoll), adns: c-ares 1.34.5, tls: OpenSSL 3.3.3 11 Feb 2025
```

To log in with this example:

```
psql -h 127.0.0.1 -p 6543 -U user@secure pgbouncer
```

with the password `mypass` (as described in `password.txt`)

## To show stats

```
psql -h 127.0.0.1 -p 6543 pgbouncer

psql (17.2, server 1.24.1/bouncer)
Type "help" for help.

pgbouncer=# SHOW STATS;
```

## Reference

Docker hub: https://hub.docker.com/r/hyperized/pgbouncer

Github: https://github.com/hyperized/pgbouncer-docker
