#!/bin/bash

# $1 = location of users json file
echo "Deploying new users..."

COUNTER=0
NumberOfGroups=$(jq '.[] | length' $1)

while [ $COUNTER -lt $NumberOfGroups ]
do
  # Get all needed attributes for each user
  Username=$(jq --raw-output '.[] | .['$COUNTER'] | .username' $1)
  Email=$(jq --raw-output '.[] | .['$COUNTER'] | .email' $1)
  GivenName=$(jq --raw-output '.[] | .['$COUNTER'] | .given_name' $1)
  FamilyName=$(jq --raw-output '.[] | .['$COUNTER'] | .family_name' $1)
  ClientId=$(jq --raw-output '.[] | .['$COUNTER'] | .client_id' $1)
  UserPoolId=$(jq --raw-output '.[] | .['$COUNTER'] | .user_pool_id' $1)

  aws cognito-idp admin-create-user \
    --username $Username \
    --user-pool-id $UserPoolId \
    --user-attributes=Name=username,Value=$Username,Name=email,Value=$Email,Name=given_name,Value=$GivenName,Name=family_name,Value=$FamilyName,Name=custom:client_id,Value=$ClientId

  # Increment counter
  let COUNTER=COUNTER+1
done

echo "Finished deploying all new users"