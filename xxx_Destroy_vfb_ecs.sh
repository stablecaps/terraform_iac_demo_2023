#!/bin/bash

set -e

#DEPLOY_ENV=$1
DEPLOY_ENV=dev

if [ -z "$DEPLOY_ENV" ]; then
    echo "Error: \$DEPLOY_ENV variable is unset"
    echo $correct_usage_str
    exit 42
fi


# "04_codedeploy_blue_green"
for INIT_DIR in "04_ecs_webapp_service" "03_route53_2alb" "02_ecs_alb" "01_ecs_cluster_fargate" ; do
    echo -e "\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@ Destroying $INIT_DIR @@@@@@@@@@@"
    echo -e "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n"

    cp -vf ./xxx_tfhelperv2.sh init_points/$INIT_DIR/

    cd init_points/$INIT_DIR
        pwd
        # TODO: add TF CI switches for clearer log output
        ./xxx_tfhelper.sh terraform_v1.5.1 yes $DEPLOY_ENV destroy
    cd -

done
