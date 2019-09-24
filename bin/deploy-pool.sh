#!/bin/bash

function packageAndDeployPool() {
  UserPoolTemplatePath=$(pwd)/templates/user-pool.yaml
  aws cloudformation package \
    --template-file ${UserPoolTemplatePath} \
    --s3-bucket ethan.painter/cognito-test \
    --output-template-file $(pwd)/templates/user-pool.package.yaml

  UserPoolTemplatePackagePath=$(pwd)/templates/user-pool.package.yaml
  aws cloudformation deploy \
    --template-file ${UserPoolTemplatePackagePath} \
    --stack-name TEST
}

function packageAndDeployUsers() {
  UserTemplatePath=$(pwd)/templates/user.yaml
  aws cloudformation package \
    --template-file ${UsersTemplatePath} \
    --s3-bucket ethan.painter/cognito-test \
    --output-template-file $(pwd)/templates/user.package.yaml

  UserTemplatePackagePath=$(pwd)/templates/user.package.yaml
  aws cloudformation package \
    --template-file ${UserTemplatePackagePath} \
    --stack-name USERS
}

# Deploy Cognito User Pool Template
packageAndDeployPool()

# Deploy Cognito Users Template
packageAndDeployUsers()
