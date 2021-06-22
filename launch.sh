#!/bin/sh

RED_CONFIG="$HOME/.config/Red-DiscordBot/config.json"

source ${HOME}/env/bin/activate

if [ "${STOCKAGE}" == "postgres" ]; then
	STOCKAGE="2\n\n\n\n\n"
fi

echo -e "${INSTANCE}\n/red/data/${INSTANCE}\n\n${STOCKAGE:-1}\n" | \
	redbot-setup > /dev/null 2>&1

redbot "${INSTANCE}" \
	--token "${TOKEN}" \
	--prefix "${PREFIX:-!}" \
	$@
