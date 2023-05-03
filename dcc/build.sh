#!/bin/bash

source ../.env

if [ ! -f installer.bin ]; then
    curl https://empowersdc.softwareag.com/ccinstallers/SoftwareAGInstaller20221103-Linux_x86_64.bin --output installer.bin
fi

sed "s/%EMPOWER_PASSWORD%/${EMPOWER_PASSWORD}/g;s/%EMPOWER_USER%/${EMPOWER_USER}/g;" dcc_script_template > dcc_script

docker build . -t dcc:latest