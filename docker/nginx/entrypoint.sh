#!/bin/bash

sed -i "s/YOUR_NAME/$MY_NAME/" /usr/share/nginx/html/index.html

if [ $? == 0 ]
then
  echo "Starting nginx"
  nginx -g "daemon off;"
else
	echo "Cannot update html file"
fi