FROM alpine:latest
MAINTAINER Jeff <jeff@modulaweb.fr>

ADD start.sh /start.sh

RUN apk add --no-cache openvpn curl \
    && chmod a+x /start.sh

CMD /start.sh