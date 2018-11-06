# pgbouncer-docker
a simple pgbouncer Docker instance

### To pull container

```docker pull hyperized/pgbouncer```

### To build container

```docker build -t pgbouncer Dockerfile```

### To run container 

```docker run -v $(pwd):/m pgbouncer /m/example.ini```
