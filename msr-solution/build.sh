#!/bin/bash

source ../.env

docker build . -t msr-solution:latest --no-cache