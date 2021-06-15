# Red in a container

The goal of this projet is encapsule [Red Discord Bot](https://github.com/Cog-Creators/Red-DiscordBot) in a container.

## Instructions

Due to a [issue](https://github.com/moby/moby/issues/2259) of docker, a volume is required :
```bash
docker volume create NAME-OF-VOLUME
docker run -e TOKEN=YOUR_TOKEN -v NAME-OF-VOLUME:/red/data stelfux/red-discordbot
```

A more complex exemple (with `podman`):
```bash
podman pod create --name red

podman volume create red-db
podman secret create red-token TOKEN-FILENAME
podman secret create red-db-pass DB-PASS-FILENAME

podman run \
	--secret red-db-password \
	--env POSTGRES_USER=red --env POSTGRES_DB=red \
	--env POSTGRES_PASSWORD_FILE=/run/secrets/red-db-password \
	--volume red-db:/var/lib/postgresql/data:Z \
	--name red-db --pod red --detach \
	docker.io/library/postgres:alpine

podman run \
	--env INSTANCE=NAME_OF_INSTANCE \
	--env TOKEN_FILE=/run/secrets/red-token \
    --env PGPASSWORD=/run/secrets/red-db-pass \
	--volume NAME-OF-VOLUME:/red/data:Z \
	--name red-bot --pod red \
	docker.io/stelfux/red-discordbot:postgres \
	--mentionable # or any others args
```
## Settings

Environnement variables :
 * `TOKEN`: [Application Token](https://discord.com/developers/applications) (see the [docs](https://docs.discord.red/en/stable/bot_application_guide.html))
 * `INSTANCE`: Name of the instance (*default: bot*)
For postgres:
 * `PGHOST`: PostgreSQL server address (*default: localhost*)
 * `PGPORT`: PostgreSQL server port (*default: 5432*)
 * `PGUSER`: PostgreSQL server username (*default: red*)
 * `PGPASSWORD`: PostgreSQL server password
 * `PGDATABASE`: PostgreSQL database's name (*default: name*) 

As an alternative to passing sensitive information via environment variables, _FILE may be appended to some of the previously listed environment variables, causing the initialization script to load the values for those variables from files present in the container. In particular, this can be used to load passwords from Docker secrets stored in /run/secrets/<secret_name> files.
