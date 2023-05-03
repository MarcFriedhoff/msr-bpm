#!/bin/bash

docker run -d -p 5555:5555 -e SAG_IS_LICENSE_FILE=/license/licenseKey.xml -e SAG_IS_CONFIG_PROPERTIES=/config/msr-solution-variables.properties -v ${PWD}/licenses/is-license.xml:/license/licenseKey.xml:rw -v ${PWD}/config:/config msr-solution:latest