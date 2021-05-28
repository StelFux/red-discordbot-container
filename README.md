# Red in a container

The goal of this projet is encapsule [Red Discord Bot](https://github.com/Cog-Creators/Red-DiscordBot) in a container.

## Instructions

Environnement variables :
 * `TOKEN`: [Application Token](https://discord.com/developers/applications)
 * `INSTANCE`: Name of the instance

Due to a [issue](https://github.com/moby/moby/issues/2259) of docker, a volume is required :
```shell
docker volume create NAME-OF-VOLUME
docker run \
	-e INSTANCE=NAME_OF_INSTANCE \
	-e TOKEN=YOUR_TOKEN \
	-v NAME-OF-VOLUME:/red/data \
	stelfux/red-discordbot

# Or with podman
podman volume create NAME-OF-VOLUME
podman run \
	-e INSTANCE=NAME_OF_INSTANCE \
	-e TOKEN=YOUR_TOKEN \
	-v NAME-OF-VOLUME:/red/data \
	docker.io/stelfux/red-discordbot
```
