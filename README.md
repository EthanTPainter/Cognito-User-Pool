# Cognito-User-Pool

This Repository is used to quickly setup AWS Cognito resources. These include:
* User Pool
* User Pool Client
* User Pool Users
* User Pool Groups

## Before Running

Make sure to install jq & aws-cli before attempting to run this application

Installing [jq](https://stedolan.github.io/jq/download/)

Installing the [AWS CLI on linux](https://docs.aws.amazon.com/cli/latest/userguide/install-linux.html)
Installing the [AWS CLI on MAC OS](https://docs.aws.amazon.com/cli/latest/userguide/install-macos.html)
Installing the [AWS CLI on Windows](https://docs.aws.amazon.com/cli/latest/userguide/install-windows.html)

## Creating A User Pool

A basic template is provided at `templates/user-pool.yaml`.

CloudFormation template format available [here](https://docs.aws.amazon.com/en_pv/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpool.html)

## Creating A User Pool Client

A basic template is provided at `templates/user-pool-client.yaml`.

CloudFormation template format available [here](https://docs.aws.amazon.com/en_pv/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpoolclient.html)

## Creating Users & Groups

JSON files in `params` folder contain users and groups used to create in cognito.