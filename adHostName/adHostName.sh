#!/bin/bash

# Set macOS hostnames to AD plug-in computer name.
# Commonly called at startup from /Library/Scripts/ with a simple launch daemon on AD bound Macs to keep kerberos happy.

adHostName=`sudo dsconfigad -show | grep Computer | cut -d " " -f 20`
adDomain=`sudo dsconfigad -show | grep "Active Directory Domain" | cut -d "=" -f 2 | tail -c +2`

sudo scutil --set HostName $adHostName.$adDomain
sudo scutil --set ComputerName $adHostName
sudo scutil --set LocalHostName $adHostName

# In some cases the HostName value should use the public fqdn.
# In this case simply replace the existing HostName line with
# sudo scutil --set HostName $adHostName.domain.com
# In extreme cases valid reverse DNS may be required for full kerberos win.
# Don't forget to check the time…