FROM ubuntu:20.04

RUN apt-get update -y && \
apt-get install -y tzdata && \
apt-get install -y openjdk-17-jre-headless wget git vim
RUN wget "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar" -O BuildTools.jar
RUN git config --global core.autocrlf input
RUN java -jar BuildTools.jar -rev 1.17.1
RUN echo "eula=true" > eula.txt

# RUN git clone https://github.com/temporaryP/world.git

CMD java -server -Xms8G -Xmx8G -jar spigot-1.17.1.jar nogui

EXPOSE 25565
EXPOSE 19132/udp
EXPOSE 80
RUN java -version
