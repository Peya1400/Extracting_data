#!/bin/bash
# Author: Petya Cvitic
# Created Date: 20 April 2022

for item in $(cat apiLinks) ; do
    export BASEURL=$item
    export PROJECT="$(echo $item | cut -d/ -f6)"
    sh fetchScript.sh
done
