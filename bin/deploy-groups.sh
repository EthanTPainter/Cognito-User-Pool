#!/bin/bash

# $1 = location of groups json file
echo "Deploying new groups..."

COUNTER=0
NumberOfGroups=$(jq '.[] | length' $1)

while [ $COUNTER -lt $NumberOfGroups ]
do
  # Get Group Name and User Pool Id from each group
  GroupName=$(jq --raw-output '.[] | .['$COUNTER'] | .group_name' $1)
  UserPoolId=$(jq --raw-output '.[] | .['$COUNTER'] | .user_pool_id' $1)

  echo "Creating group for $GroupName..."
  aws cognito-idp create-group --group-name $GroupName --user-pool-id $UserPoolId

  # Increment counter
  let COUNTER=COUNTER+1
done

echo "Finished Deploying all new groups"