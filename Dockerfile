FROM openjdk:8-jre

ENV GOSU_VERSION 1.10
ENV GOSU_GPG_KEY B42F6819007F00F88E364FD4036A9C25BF357DD4
ENV CEREBRO_VERSION 0.6.5

RUN set -x \
        && apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
	&& dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \
        && wget https://github.com/lmenezes/cerebro/releases/download/v${CEREBRO_VERSION}/cerebro-${CEREBRO_VERSION}.tgz \
        && tar -zxvf cerebro-${CEREBRO_VERSION}.tgz \
        && rm cerebro-${CEREBRO_VERSION}.tgz \
        && mv cerebro-${CEREBRO_VERSION} cerebro \
        && mkdir -p cerebro/logs \
        && apt-get purge -y --auto-remove ca-certificates wget

COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 9000
WORKDIR /cerebro
ENTRYPOINT ["/docker-entrypoint.sh"]
