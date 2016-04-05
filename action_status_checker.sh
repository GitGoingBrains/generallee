#!/bin/bash
# Check for valid digital ocean token via api 
digitaloceantoken=$(cat references/.keys/digitaloceantoken)

#set dummy action status
jobstatus=$(echo "unknown")
newActionId=$(cat references/currentAction)
echo "About 30s for deployment..."
sleep 8

echo "Status:"
#fetch action status until action is "complete"
while [ "$jobstatus" != "complete" ]
    do
        curl -s -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $digitaloceantoken" "https://api.digitalocean.com/v2/actions/$newActionId" > references/actioninfo.log
#grep -Po '("status":")[a-z]*' references/actioninfo.log
        jobstatus=$(grep -Po '("status":")[a-z]*' references/actioninfo.log | grep -Po 'complete')
        sleep 4
        echo "-  " $jobstatus
    done

