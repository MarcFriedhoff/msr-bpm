#!/bin/bash

source ../.env

if [ ! -f installer.bin ]; then
    curl https://empowersdc.softwareag.com/ccinstallers/SoftwareAGInstaller20221103-Linux_x86_64.bin --output installer.bin
fi

sh installer.bin create container-image --name msr-bpm --products MSC,Monitor,wmprt,PIEContainerExternalRDBMS,WSIddj --release 10.15 --username $EMPOWER_USER --password $EMPOWER_PASSWORD  --accept-license --admin-password=manage