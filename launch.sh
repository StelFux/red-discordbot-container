#!/bin/sh

RED_CONFIG="$HOME/.config/Red-DiscordBot/config.json"

source ${HOME}/env/bin/activate

echo -e "${INSTANCE}\n/red/data/${INSTANCE}\n\n${STOCKAGE:-1}\n" | \
	redbot-setup > /dev/null

redbot "${INSTANCE}" \
	--token "${TOKEN}" \
	--prefix "${PREFIX:-!}" \
	$@
