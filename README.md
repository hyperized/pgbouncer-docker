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

```docker run -v $(pwd):/m -p -p 6543:6543 hyperized/pgbouncer /m/tls.ini```

## To show stats

```
psql -h 127.0.0.1 -p 6543 pgbouncer

psql (10.5, server 1.9.0/bouncer)
Type "help" for help.

pgbouncer=# show stats;
```

## Reference

Docker cloud: https://cloud.docker.com/repository/docker/hyperized/pgbouncer

Repository: https://github.com/hyperized/pgbouncer-docker