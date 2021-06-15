#!/bin/sh

RED_CONFIG="$HOME/.config/Red-DiscordBot/config.json"

source ${HOME}/env/bin/activate

for i in $(env | grep _FILE)
do
	VAR=$(echo -n $i | cut -d= -f1)
	FILE=$(echo -n $i | cut -d= -f2-)
	
	if [ -f "${FILE}" ]
	then
		export ${VAR::-5}=$(cat $FILE | tr -d '\n')
	fi
done

if [ ${STOCKAGE} == "postgres" ]; then
	STOCKAGE="2\n\n\n\n\n"
fi

echo -e "${INSTANCE}\n/red/data/${INSTANCE}\n\n${STOCKAGE:-1}\n" | \
	redbot-setup > /dev/null 2>&1

redbot "${INSTANCE}" \
	--token "${TOKEN}" \
	--prefix "${PREFIX:-!}" \
	$@
