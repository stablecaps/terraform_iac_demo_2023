# Simple Web App in Python


## Overview

This is a very simple app that listens to requests on ports `*:80`, `*:8080`, and `*:8000`.

## Build and run
!! NOTE: Make sure your aws creds are exported into your environment

Use script `simple_web_app/build_and_push_docker_image.sh` or using:

```
### Build
docker build -t simple-web-app:${VERSION} .

### Run
docker run -p 8080:8080 -it simple-web-app:${VERSION}

### Make a call
curl localhost:8080

### Should give the following response
Running app version <2.0.0> on random port <47294>
```

