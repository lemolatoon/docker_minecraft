SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

export GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa_git"

rm running -rf
git clone git@github.com:temporaryP/running.git
if [ `cat ./running/running` = "true" ]; then
	echo "他の誰かがすでにサーバー実行中です"
	echo "Someone is already running Server."
else
	DATE=`TZ='Asia/Tokyo' date`

	echo "true" > running/running
	cd running
	git add *
	git commit -m "$DATE, true"
	git push git@github.com:temporaryP/running.git master
	cd ..

	
	rm world -rf
	rm world_nether -rf
	rm world_the_end -rf
	git clone git@github.com:temporaryP/world.git
	git clone git@github.com:temporaryP/world_nether.git
	git clone git@github.com:temporaryP/world_the_end.git


	if [ ! -e "exist_plugins" ]; then
		sudo rm plugins -rf
		mkdir -P plugins
		wget -P ./plugins/ "https://ci.opencollab.dev//job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar"
		wget -P ./plugins/ "https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/spigot/target/floodgate-spigot.jar"
		wget -P ./plugins/ "https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/spigot/target/floodgate-spigot.jar"
		wget -P ./plugins/ "https://github.com/ViaVersion/ViaVersion/releases/download/4.1.1/ViaVersion-4.1.1.jar"
		wget -P ./plugins/ "https://github.com/ViaVersion/ViaBackwards/releases/download/4.1.1/ViaBackwards-4.1.1.jar"

		mkdir -p plugins/Geyser-Spigot

		wget "https://raw.githubusercontent.com/temporaryP/config.yml/main/config.yml -P ./plugins/Geyser-Spigot/"

		echo true > exist_plugins
	else
		echo "すでにファイルはダウンロードされています。"
		echo "plugins are already downloaded"
	fi

	sudo docker rm Spigot1.17.1

	sudo docker run -i -t --name Spigot1.17.1 \
		-v $SCRIPT_DIR/world:/world \
		-v $SCRIPT_DIR/world_nether:/world_nether \
		-v $SCRIPT_DIR/world_the_end:/world_the_end \
		-v $SCRIPT_DIR/plugins:/plugins \
		-p=25565:25565 -p=19132:19132/udp \
		Spigot1.17.1/spigot:latest

	./world_push.sh

	echo "false" > running/running

	cd running
	git add *
	git commit -m "$DATE, false"
	git push git@github.com:temporaryP/running.git master
fi
