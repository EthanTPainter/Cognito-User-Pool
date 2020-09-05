#!/bin/bash

function createUser() {
  # Get all needed attributes for each user
  Username=$(jq --raw-output '.[] | .['$COUNTER'] | .username' $1)
  Email=$(jq --raw-output '.[] | .['$COUNTER'] | .email' $1)
  GivenName=$(jq --raw-output '.[] | .['$COUNTER'] | .given_name' $1)
  FamilyName=$(jq --raw-output '.[] | .['$COUNTER'] | .family_name' $1)
  ClientId=$(jq --raw-output '.[] | .['$COUNTER'] | .client_id' $1)
  UserPoolId=$(jq --raw-output '.[] | .['$COUNTER'] | .user_pool_id' $1)

  # Create user in cognito user pool
  aws cognito-idp admin-create-user \
    --username $Username \
    --user-pool-id $UserPoolId \
    --user-attributes=Name=username,Value=$Username,Name=email,Value=$Email,Name=given_name,Value=$GivenName,Name=family_name,Value=$FamilyName,Name=custom:client_id,Value=$ClientId
  
  echo "Created $Username in $UserPoolId"
}

function addUserToGroup() {
  # Check if a group is assigned to the user
  GroupName=$(jq --raw-output '.[] | .['$COUNTER'] | .group_name' $1)
  if [[ $GroupName != "null" ]]
  then
    echo "Adding $Username to group $GroupName"
    aws cognito-idp admin-add-user-to-group \
      --username $Username \
      --user-pool-id $UserPoolId \
      --group-name $GroupName
  else
    echo "Group name not found. Not adding user $Username to a group"
  fi
}

function main() {
  echo "Deploying new users..."
  COUNTER=0
  NumberOfGroups=$(jq '.[] | length' $1)
  while [ $COUNTER -lt $NumberOfGroups ]
  do
    createUser $1
    addUserToGroup $1
    let COUNTER=COUNTER+1
  done

  echo "Finished deploying all new users"
}

main $1
