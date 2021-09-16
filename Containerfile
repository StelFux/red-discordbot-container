FROM docker.io/library/python:3.9-alpine AS intermediate

LABEL org.opencontainers.image.authors="StelFux <coles@tuta.io>" \
	org.opencontainers.image.url="https://github.com/StelFux/red-discordbot-docker/blob/master/README.md" \
	org.opencontainers.image.documentation="https://github.com/StelFux/red-discordbot-docker/blob/master/README.md#settings" \
	org.opencontainers.image.source="https://github.com/StelFux/red-discordbot-docker" \
	org.opencontainers.image.title="Red DiscordBot" \
	org.opencontainers.image.description="A multi-function Discord bot"

ENV INSTANCE="bot"

# libstdc++ used by serverstats
RUN apk add --no-cache git openjdk11-jre-headless libstdc++ && \
	apk add --no-cache --virtual .build-deps alpine-sdk libffi-dev && \
	adduser -D -h /red -g red red && \
	su red -c "python -m venv /red/env && \
	source /red/env/bin/activate && \
	pip install --upgrade --no-cache-dir pip setuptools wheel"

VOLUME /red/data
ADD launch.sh /usr/local/bin
ENTRYPOINT ["/usr/local/bin/launch.sh"]

FROM intermediate AS latest
RUN su red -c "source /red/env/bin/activate && \
	pip install --no-cache-dir Red-DiscordBot" && \
	apk del .build-deps
USER red:red

FROM intermediate AS postgres
ENV STOCKAGE=postgres
RUN su red -c "source /red/env/bin/activate && \
	pip install --no-cache-dir Red-DiscordBot[Postgres]" && \
	apk del .build-deps
USER red:red

