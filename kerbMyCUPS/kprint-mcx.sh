#!/bin/bash

# This script will enable kerberos authentication for all MCX print queues
# Use in conjunction with AD Host Name script for kerberos win
# Shane Ferguson & Joe Selway (C) 2011

PS=$(lpstat -p |  grep "mcx" | awk '{ print $2}')
for p in $PS
do
	lpadmin -p $p -o auth-info-required=negotiate
done

exit


