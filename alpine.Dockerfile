FROM alpine:3.11
LABEL maintainer="urielCh <admin@uriel.ovh>"

RUN apk add --no-cache squid apache2-utils

COPY squid.conf /etc/squid/squid.conf_
COPY entry.sh /entry.sh

CMD [ "/entry.sh" ]

