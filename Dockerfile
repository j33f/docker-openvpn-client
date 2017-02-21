FROM alpine:latest
LABEL maintainer Jeff <jeff@modulaweb.fr>

ADD start.sh /start.sh

RUN apk add --no-cache openvpn curl \
    && chmod a+x /start.sh

CMD /start.sh