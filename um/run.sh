#!/bin/bash

mkdir -p data
chmod ugo+rwx data

docker run -d -p 9000:9000 --name um -v ${PWD}/licence:/opt/softwareag/UniversalMessaging/server/umserver/licence -v ${PWD}/data:/opt/softwareag/UniversalMessaging/server/umserver/data:rw sagcr.azurecr.io/universalmessaging-server:10.15 um