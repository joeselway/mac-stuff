#!/bin/sh

# Set AppleLocale in User Library.

# Check console user if not running at login.
if [ -z $3 ]; then
    currentUser=`w | grep console | awk '{ print $1 }'`
# Bail out if no user is logged in.
    if [ -z $currentUser ]; then
        exit 1
    fi
    sudo -u $currentUser /usr/bin/defaults write -g AppleLocale en_AU
    exit 0
fi

# Else continue as login script.
sudo -u $3 /usr/bin/defaults write -g AppleLocale en_AU
exit 0