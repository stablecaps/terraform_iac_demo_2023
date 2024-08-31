#!/bin/bash

set -e

#DEPLOY_ENV=$1
DEPLOY_ENV=prod

if [ -z "$DEPLOY_ENV" ]; then
    echo "Error: \$DEPLOY_ENV variable is unset"
    echo $correct_usage_str
    exit 42
fi


### Note: github actions runner will not have r53 perms to reduce secirity blast radius
for INIT_DIR in "01_ecs_cluster_fargate" "02_ecs_alb" "04_traefik_service" "05c_ecs_scaps_service"; do
    echo -e "\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "@@@@@@@@@@ Deploying $INIT_DIR @@@@@@@@@@@"
    echo -e "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n"

    cd init_points/$INIT_DIR
        pwd
        # TODO: add TF CI switches for clearer log output
        ./xxx_tfhelper.sh terraform yes $DEPLOY_ENV full
    cd -
done