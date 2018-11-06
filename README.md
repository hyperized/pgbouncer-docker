# pgbouncer-docker
a simple pgbouncer Docker instance

### To pull container

```docker pull hyperized/pgbouncer```

### To build container

```docker build -t pgbouncer Dockerfile```

### To run container 

```docker run -v $(pwd):/m -p 6543:6543 pgbouncer /m/example.ini```

### To show stats

```
psql -h 127.0.0.1 -p 6543 pgbouncer

psql (10.5, server 1.9.0/bouncer)
Type "help" for help.

pgbouncer=# show stats;
```
