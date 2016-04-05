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

echo "Spinning up droplet..."

# Start new droplet with token and parameters, requiring key pair onhand (named in project parameters, referenced separately
#uncomment this
curl -s -X POST -H "Content-Type: application/json" \
    -H "Authorization: Bearer $digitaloceantoken" \
    -d '{"name":"'$server1name'","region":"'$server1region'","size":"'$server1size'","image":"'$server1image'","'$server1ssh_keys'":null,"backups":false,"ipv6":true,"user_data":null,"private_networking":null}' "https://api.digitalocean.com/v2/droplets" \
    > references/new-drop.log.json

# new drop (above) error handling TODO response header should 202
# get action_id and DO check WHILE status !complete
newActionId=$(grep -Po '("actions":.."id":)[0-9]+' references/new-drop.log.json | grep -Po '[0-9]+')
echo "Action Id:"
# temp action id assignment
# newid=92342589
echo $newActionId
echo $newActionId > references/currentAction
sleep 1

#set dummy action status
jobstatus="unknown"
exit 0
#fetch action status until action is "complete"
while $jobstatus=!"complete";
    do
        curl -s -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $digitaloceantoken" "https://api.digitalocean.com/v2/actions/$newActionId" > references/actioninfo.log

        jobstatus=$(grep -Po '("status:")[a-z]' references/actioninfo.log)

        echo $jobstatus
        sleep 5
    done

# test for server running
# test/ scp  
# scp project triggers and key scripts in tar ball
# scp secret files
# scp and excute setup_droplet.sh for project
# wait and listen for complete?
# complete signals test/checks to log and reboot, or writes check& log to startup script and reboot
# startup script signals admin? ready/standing by?
# handle log files
exit 0
