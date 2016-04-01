#!/bin/bash
# Check for valid digital ocean token via api 
digitaloceantoken=$(cat references/.keys/digitaloceantoken)
if [ -z "$digitaloceantoken" ]
    then
        echo "Digital Ocean token $digitaloceantoken not found (references/.keys/digitaloceantoken)"
        exit 1
fi

# Check Digital Ocean API for response
if
    curl -s -X GET -I -H "Content-Type: application/json" -H "Authorization: Bearer $digitaloceantoken" "https://api.digitalocean.com/v2/account" | grep "200 OK" > /dev/null 
        then
            echo "Digital Ocean API OK"
        else
            echo "Error with Digital Ocean API"
            exit 1
fi

# Check Digital Ocean account for messages
if curl -s -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $digitaloceantoken" "https://api.digitalocean.com/v2/account" | grep '"status_message":""' > /dev/null 
    then echo "No account messages"
    else curl -s -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $digitaloceantoken" "https://api.digitalocean.com/v2/account" | grep --color=always '"status_message":"*"'
fi

# Check for project parameters
# ## TODO
server1name="devserverOne"
server1region="sfo1"
server1size="512mb"
server1image="14553286"
server1ssh_keys="id_rsa_balls.pub"

# this is page 2 below being called for temporary reference
curl -X GET -H "Content-Type: application/json" \
    -H "Authorization: Bearer $digitaloceantoken" \
    "https://api.digitalocean.com/v2/images?page=2&per_page=1&private=true"
echo "##########################"

# Start new droplet with token and parameters, requiring key pair onhand (named in project parameters, referenced separately
curl -X POST -H "Content-Type: application/json" \
    -H "Authorization: Bearer $digitaloceantoken" \
    -d '{"name":"'$server1name'","region":"'$server1region'","size":"'$server1size'","image":"'$server1image'","'$server1ssh_keys'":null,"backups":false,"ipv6":true,"user_data":null,"private_networking":null}' "https://api.digitalocean.com/v2/droplets"
# get action_id and DO check WHILE status !complete
# test for server running
# test/ scp  
# scp project triggers and key scripts in tar ball
# scp secret files
# scp and excute setup_droplet.sh for project
# wait and listen for complete?
# complete signals test/checks to log and reboot, or writes check& log to startup script and reboot
# startup script signals admin? ready/standing by?
exit 0
