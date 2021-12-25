## docker_minecraft
# 1. このrepositoryをcloneする
```
$ git clone git@github.com:temporaryP/docker_minecraft.git
```
*注意:秘密鍵が必要。id_rsa_gitとして保存している場合にはつぎのように環境変数を設定すると良い。
```
$ export GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa_git"
$ echo $GIT_SSH_COMMAND
ssh -i ~/.ssh/id_rsa_git
```
ただし、これはshellを再起動すると、この変数もリセットされるので注意

# 2. docker,wgetをインストールする。
*注意:ここからはcloneしたフォルダ(docker_minecraft)内で作業します。(要：``cd docker_minecraft``)
```
$ ./setup.sh
```
# 3. DockerFileをbuildする。
```
./build.sh
```
# 4. dockerを走らせる。 
```
./run.sh
```
ここでは、セーブデータ、プラグインがgit clone, wgetを用いてダウンロードされ、docker内にマウントされます。
runningリポジトリ内の値がtrueの場合、他の誰かがすでにサーバーを動かしているということなのでサーバーは動きません。
# 5. serverを止める。
```
>stop
```
これで止まります。

## 使用しているポート
25565,19132/udpです。公開して遊ぶ場合は適宜ufwの設定と、ルータのポートフォワーディングの設定をしてください。
```
$ sudo ufw enable
$ sudo ufw allow 25565
$ sudo ufw allow 19132/udp
```
