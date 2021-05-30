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
podman volume create NAME-OF-VOLUME
podman run \
	-e INSTANCE=NAME_OF_INSTANCE \
	-e TOKEN_FILE=/run/secrets/SECRET-NAME \
	-v NAME-OF-VOLUME:/red/data:Z \
	docker.io/stelfux/red-discordbot \
	--mentionable # or any others args
```
## Settings

Environnement variables :
 * `TOKEN`: [Application Token](https://discord.com/developers/applications) (see the [docs](https://docs.discord.red/en/stable/bot_application_guide.html))
 * `INSTANCE`: Name of the instance (*default: bot*)

As an alternative to passing sensitive information via environment variables, _FILE may be appended to some of the previously listed environment variables, causing the initialization script to load the values for those variables from files present in the container. In particular, this can be used to load passwords from Docker secrets stored in /run/secrets/<secret_name> files.
