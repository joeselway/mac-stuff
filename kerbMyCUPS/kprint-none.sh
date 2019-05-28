#!/bin/bash

PS=$(lpstat -p | awk '{ print $2}')
if [ -z "$PS" ];
then
	echo "No printers found"
	exit 1
else 
	for p in $PS
do
	lpadmin -p $p -o auth-info-required=username,password
	echo "Enabling basic user authentication for $p"
done
fi

exit 0