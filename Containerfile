FROM docker.io/library/python:3.8-alpine

# 1 = JSON
# 2 = PostgreSQL
ENV STOCKAGE=1

ENV INSTANCE=""


RUN apk add --no-cache git openjdk11-jre-headless && \
	apk add --virtual .build-deps alpine-sdk libffi-dev && \
	adduser -D -h /red -g red red
#	mkdir /red/data && chown red:red /red/data 

VOLUME /red/data
USER red:red

RUN python -m venv $HOME/env && \
	source $HOME/env/bin/activate && \
	pip install --no-cache-dir Red-DiscordBot


ADD launch.sh /usr/local/bin
ENTRYPOINT ["/usr/local/bin/launch.sh"]
