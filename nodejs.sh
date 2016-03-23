#1/bin/bash
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
#sudo apt-get install -y nodejs

#sudo apt-get install -y nodejs
echo "nodejs done" node --version >> setup-args.log
#sudo apt-get install -y npm
echo "npm done" npm --version >> setup-args.log
exit
