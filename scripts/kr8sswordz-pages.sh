#!/bin/bash

#Retrieve the latest git commit hash
#TAG=`git rev-parse --short HEAD`
TAG=latest
#Build the docker image
docker build -t registry.cn-huhehaote.aliyuncs.com/henryops/kr8sswordz:$TAG -f applications/kr8sswordz-pages/Dockerfile applications/kr8sswordz-pages

#Setup the proxy for the registry

echo "5 second sleep to make sure the registry is ready"
sleep 5;

#Push the images
docker push registry.cn-huhehaote.aliyuncs.com/henryops/kr8sswordz:$TAG

#Stop the registry proxy

# Create the deployment and service for the front end aka kr8sswordz
sed 's/kr8sswordz:latest/kr8sswordz:'$TAG'/g' applications/kr8sswordz-pages/k8s/deployment.yaml | kubectl apply -f -
