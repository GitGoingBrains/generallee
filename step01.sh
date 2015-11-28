#!/bin/bash
# fetch this file with:wget https://github.com/GitGoingBrains/generallee/step01.sh
# wget -O - http://github.com/GitGoingBrains/generallee/step01.sh | bash
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
#dotfiles

#using script call 1st agrument: get "generallee" install file, and run
[ -z "$1" ] && echo "No project argument supplied"
#wget clone http://github.com/GitGoingBrains/$1-generallee-install.sh
#bash $1-generallee-install.sh
#clone working project (pointer from command line agrument?)

#fetch private tokens/keys

#create tmux sessions setup and autosave

#rm setup script, etc.
#reboot sys
