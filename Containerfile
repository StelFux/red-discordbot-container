FROM docker.io/library/python:3.8-alpine

ENV INSTANCE="bot"

RUN apk add --no-cache git openjdk11-jre-headless && \
	apk add --virtual .build-deps alpine-sdk libffi-dev && \
	adduser -D -h /red -g red red

VOLUME /red/data
USER red:red

RUN python -m venv $HOME/env && \
	source $HOME/env/bin/activate && \
	pip install --no-cache-dir Red-DiscordBot

ADD launch.sh /usr/local/bin
ENTRYPOINT ["/usr/local/bin/launch.sh"]
