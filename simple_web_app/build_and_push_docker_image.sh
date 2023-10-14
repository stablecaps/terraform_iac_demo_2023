#!/bin/bash

set -e

VERSION=1.0.0

docker build -t simple-web-app:${VERSION} .

echo -e "Script finished"