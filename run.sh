session_name=$(screen -ls | awk '/[[:digit:]]\.spigot/{print $1}')

if [ -n "$session_name" ]; then
	echo "すでにscreen session: $session_name が存在します。"
	echo "screen session: $session_name is already exists"
	echo ""
	echo -n "Do you want to kill $session_name and continue launching? [y/n]: "
	read response
	echo ""
	if [ ! $response = "y" ]; then
		echo "terminating script..."
		exit 1
	fi
	screen -S $session_name -X quit
fi

echo "Starting launching script on screen....."

screen -dmS spigot
screen -S spigot -X stuff './_run.sh'`echo -ne '\015'`
screen -r
