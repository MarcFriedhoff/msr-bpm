#!/bin/bash

# tag (prefix docker registry)
docker tag msr-bpm:latest $DOCKER_REGISTRY/$DOCKER_PROJECT/msr-bpm:latest

# login to remote registry
docker login $DOCKER_REGISTRY -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

# push to remote registry
docker push  $DOCKER_REGISTRY/$DOCKER_PROJECT/msr-bpm:latest