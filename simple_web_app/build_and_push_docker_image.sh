#!/bin/bash

set -e

AWS_ACCOUNT_NUMBER=$1
APPNAME=simple-docker-webapp
VERSION=1.0.0

if [ -z "$AWS_ACCOUNT_NUMBER" ]; then
    echo "Error: \$AWS_ACCOUNT_NUMBER variable is unset"
    echo "./build_and_push_docker_image.sh 115588969956"
    exit 42
fi

### Build docker file
docker build -t ${APPNAME}:${VERSION} .


echo -e "Pushing to ECR"
aws ecr get-login-password \
            --region eu-west-1 \
            | docker login \
                --username AWS \
                --password-stdin ${AWS_ACCOUNT_NUMBER}.dkr.ecr.eu-west-1.amazonaws.com

### tag
docker tag ${APPNAME}:${VERSION} \
                ${AWS_ACCOUNT_NUMBER}.dkr.ecr.eu-west-1.amazonaws.com/${APPNAME}:${VERSION}

### push
docker push ${AWS_ACCOUNT_NUMBER}.dkr.ecr.eu-west-1.amazonaws.com/${APPNAME}:${VERSION}


echo -e "Script finished"