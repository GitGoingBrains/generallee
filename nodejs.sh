#1/bin/bash
sudo apt-get install -y nodejs
echo "nodejs installer done" nodejs --version >> setup-args.log
sudo apt-get install -y npm
echo "npm installer done" npm --version >> setup-args.log
exit
