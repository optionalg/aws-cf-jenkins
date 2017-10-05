#!/bin/bash

templateFile=jenkins.template.yaml
stackName=$1

aws cloudformation describe-stacks --stack-name $stackName &> /dev/null

if [ $? == 0 ]; then
    printf "Update stack $stackName... "
    response=$(aws cloudformation update-stack \
        --stack-name $stackName \
        --template-body file://$(pwd)//${templateFile} \
        --capabilities CAPABILITY_NAMED_IAM \
        --parameters file://$(pwd)//parameters.json)
else
    printf "Create stack $stackName... "
    response=$(aws cloudformation create-stack \
        --stack-name $stackName \
        --template-body file://$(pwd)//${templateFile} \
        --capabilities CAPABILITY_NAMED_IAM \
        --parameters file://$(pwd)//parameters.json)
fi

if [ $? == 0 ]; then
    echo $response | jq -r ".StackId"
fi