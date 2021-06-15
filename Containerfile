FROM docker.io/library/python:3.8-alpine AS intermediate

ENV INSTANCE="bot"

RUN apk add --no-cache git openjdk11-jre-headless && \
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

