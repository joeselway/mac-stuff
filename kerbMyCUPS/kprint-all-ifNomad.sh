#!/bin/bash

if [ ! -f "/Applications/NoMAD.app/Contents/MacOS/NoMAD" ];
then
	echo "NoMAD not installed, aborting"
    exit 1
fi

PS=$(lpstat -p | awk '{ print $2}')
if [ -z "$PS" ];
then
	echo "No printers found"
	exit 1
else 
	for p in $PS
do
	lpadmin -p $p -o auth-info-required=negotiate
	echo "Enabling kerberos authentication for $p"
done
fi
exit 0