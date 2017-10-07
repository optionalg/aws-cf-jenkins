#!/usr/bin/env bash

templateFile=jenkins.template.yaml
stackName=$1

aws cloudformation describe-stacks --stack-name $stackName &> /dev/null

if [ $? == 0 ]; then
    changeSetName="${stackName}_$(date '+%Y-%m-%d_%H:%M:%S')"
    printf "Create change set for stack $stackName... "
    response=$(aws cloudformation create-change-set \
        --stack-name $stackName \
        --change-set-name "${stackName}-$(date '+%Y%m%d-%H%M%S')" \
        --template-body file://$(pwd)//${templateFile} \
        --capabilities CAPABILITY_NAMED_IAM \
        --parameters file://$(pwd)//parameters.json)

    if [ $? == 0 ]; then
        printf $response | jq -r ".Id"
    fi
else
    printf "WARNING: Stack $stackName not found... "
    printf "\n"
    exit 1;
fi

