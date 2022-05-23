#!/bin/bash
# Author: Petya Cvitic
# Created Date: 20 April 2022

for item in $(cat apiLinks_issues) ; do
    export BASEURL=$item
    export FILENAME="DLT_issues_all.csv"
    export PROJECT="$(echo $item | cut -d/ -f6)"
    sh fetchScript_issues_all.sh
done
