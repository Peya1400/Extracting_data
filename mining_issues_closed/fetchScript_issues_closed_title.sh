#!/bin/bash
# Author: Petya Cvitic
# Created Date: 20 April 2022
# inspired by: 
# - https://www.middlewareinventory.com/blog/github-list-all-repositories-using-rest-api/
# - https://www.baeldung.com/linux/jq-command-json
# - https://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-7.html

# add your GitHub username and token
USERNAME=
TOKEN=

# No of reposoitories per page - Maximum Limit is 100
PERPAGE=100

# Change the BASEURL to  Org or User of interest
BASEURL="${BASEURL:-https://api.github.com/repos/corda/corda/commits}"
FILENAME="DLT_issues_closed.csv"
echo "WORKING WITH $BASEURL AND FILENAME $FILENAME AND PROJECT $PROJECT"

# Calculating the Total Pages after enabling Pagination
TOTALPAGES=`curl -I -i -u $USERNAME:$TOKEN -H "Accept: application/vnd.github.v3+json" -s ${BASEURL}\?state=closed | grep -i link: 2>/dev/null|sed 's/link: //g'|awk -F',' -v  ORS='\n' '{ for (i = 1; i <= NF; i++) print $i }'|grep -i last|awk '{print $1}' | tr -d '\<\>' | tr '\?\&' ' '|awk '{print $3}'| tr -d '=;page'`

i=1
echo is it $TOTALPAGES totalpages
until [ $i -gt $TOTALPAGES ]
do
  result=`curl -s -u $USERNAME:$TOKEN -H 'Accept: application/vnd.github.v3+json' ${BASEURL}\?state=closed\&page=${i} 2>&1`
  echo $result > tempfile
  cat tempfile| jq '['\"${PROJECT}\"'] + (.[] | [.id, .state, .created_at, .closed_at, .title])| @csv' | tr -d '\\"' >> $FILENAME
  ((i=$i+1))
done
