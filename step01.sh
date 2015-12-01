#!/bin/bash
# fetch this file with:wget https://github.com/GitGoingBrains/generallee/step01.sh
# wget -O - http://github.com/GitGoingBrains/generallee/raw/master/step01.sh | bash
#
# developed for debian 8 on Digial Ocean snapshots access via non-root user on SSH
# likely development projects on node, meteor, mongoDB and some python

#git
apt-get update -y
apt-get upgrade -y
apt-get install -y git
#git clone - rest -of -the -setup
#
#rest of the setup:
#tmux
apt-get install -y tmux
#vim
apt-get install -y vim
apt-get install -y curl

#clone .vimrc .tmuxrc
touch .vimrc
echo syntax on >> .vimrc 
#dotfiles

#using script call 1st agrument: get "generallee" install file, and run
touch setup-args.log
[ -z "$1" ] && echo "No project argument supplied" >> setup-args.log
for var in "$@"
do
    echo "$var" >> setup-args.log
    wget https://github.com/GitGoingBrains/raw/master/"$var".sh
    bash "$var".sh
    rm "$var".sh
done
wget https://github.com/GitGoingBrains/generallee/step99.sh
chmod 0700 step99.sh
bash step99.sh
rm step99.sh
rm step01.sh
exit

