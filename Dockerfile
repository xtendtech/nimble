FROM debian:12-slim

ENV TZ=America/New_York

RUN apt-get clean && apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends libxml2 libzip4 openssl \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && mkdir -p /var/log/nimble    &&  mkdir -p /etc/nimble
#    && mkdir -p /var/log/nimble && ln -sf /dev/stdout /var/log/nimble/nimble.log
COPY rootfs/ /
RUN chmod +x /usr/bin/nimble_3.7.13-3

ENTRYPOINT ["/usr/bin/nimble_3.7.13-3", "--conf-dir=/etc/nimble", "--log-dir=/var/log/nimble" ]
