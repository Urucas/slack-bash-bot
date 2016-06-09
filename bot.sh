#!/bin/bash
TOKEN=$(sed -n 's/.*token *= *\([^ ]*.*\)/\1/p' < $1)
CHANNEL=$(sed -n 's/.*channel *= *\([^ ]*.*\)/\1/p' < $1)
USERNAME=$(sed -n 's/.*username *= *\([^ ]*.*\)/\1/p' < $1)

function push {
  RESPONSE=$(curl -X POST https://slack.com/api/chat.postMessage -v --data "token=$TOKEN&channel=$CHANNEL&text=$1&username=$USERNAME&mrkdwn=true") 
  echo $RESPONSE  
}

MYSQL_STATUS=$(service mysql status | grep "running")
if [ -z MYSQL_STATUS ]; then
  push "WOOOT! MySQL service has stopped, quickly connect that service up again! ...or move to mongo, what ever you want."
fi;

APACHE_STATUS=$(service apache2 status | grep "is running")
if [ -z APACHE_STATUS ]; then
  push "WOOOT! Apache2 is not running, your pages are unreachebles! Ohhh, won't somebody please think of the children."
fi;

exit 0