#!/bin/bash

set -e

if ! command -v terraform-docs &> /dev/null
    then
    echo "!!! Plaese ensure you have terraform-docs installed & on your path !!!"
    echo -e "https://github.com/terraform-docs/terraform-docs\n"
    exit 42
fi

if [ "$#" -ne 1 ]; then
    echo "USAGE: ./xxx_terraform-docs.sh \${YOUR_TERRAFORM_EXEC}"
    echo "e.g > ./xxx_terraform-docs.sh terraform_v1.5.1"
    exit 0
fi

terraform_exec=$1

### Run tf fmt
$terraform_exec fmt -recursive

unique_tf_dirs=$(find ./ -not -path "*/\.*" -not -path "*venv/*" -not -path "*node_modules/*" -iname "*.tf" -exec dirname {} \; | uniq)

for tf_dirs in $unique_tf_dirs; do
    cd $tf_dirs
        echo ""
        pwd
        # TODO: customise this further to enrich READMEs and create links to them from root directory
        terraform-docs markdown table --output-file README.md --output-mode inject .

        IMAGE_FILE="./images/terraform_infra.png"
        if [ -f "$IMAGE_FILE" ]; then
            echo "Adding infra image"
            ### rm previous additions

            sed -i "s|images/terraform_infra.png||g" README.md
            mv -f README.md README.temp


            MDIMG_LINK="![terraform_infra](${IMAGE_FILE})"
            echo "$MDIMG_LINK" > README.md
            echo "" >> README.md
            echo "" >> README.md
            cat README.temp >> README.md
            rm README.temp

        else
            echo "nofindo"
        fi
    cd -
done