#!/bin/bash
TOKEN=$(sed -n 's/.*token *= *\([^ ]*.*\)/\1/p' < $1)
CHANNEL=$(sed -n 's/.*channel *= *\([^ ]*.*\)/\1/p' < $1)
USERNAME=$(sed -n 's/.*username *= *\([^ ]*.*\)/\1/p' < $1)

function push {
  RESPONSE=$(curl -X POST https://slack.com/api/chat.postMessage -v --data "token=$TOKEN&channel=$CHANNEL&text=$1&username=$USERNAME&mrkdwn=true") 
  echo $RESPONSE  
}

MYSQL_STATUS=$(service mysql status)
if [ MYSQL_STATUS grep -q "stop" ]; then
  push "WOOOT! MySQL service has stopped, quickly connect that service up again!"
fi;

APACHE_STATUS=$(service apache2 status)
if [ APACHE_STATUS grep -q "apache2 is not running" ]; then
  push "WOOOT! Apache2 is not running, your pages are down(not special) unreachebles!"
fi;

exit 0