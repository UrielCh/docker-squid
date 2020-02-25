# An other squid docker

this squid Docker give access to all the IP of the host

## env variables

- PASSWORD: choose password
- PORT: port to bind

## publish

```bash
docker build -f alpine.Dockerfile -t urielch/squid .
docker push urielch/squid:latest
```

## clean

```bash
docker kill proxy2; docker rm $(docker  ps -a -q)
docker pull urielch/squid:latest
```
