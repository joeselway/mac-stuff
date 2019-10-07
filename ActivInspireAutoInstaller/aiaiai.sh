#!/bin/sh

#############################################################
#															#
#				      aiaiai.sh								#
#															#
#	  activ inspire almost intelligent auto installer		#
#															#
#	   written by Joe Selway in 2019. copytotheleft	        #
#															#
#     Run this script in a directory containing: 			#
#															#
#     1. ONE ActivInspire_XX_XX_mac.dmg from Promethean		#
#     2. valid installer_choices.xml						#
#															#
#	  KNOWN ISSUES:											#
#															#
#	  -  horrible code										#
#	  -  extreme danger to users							#
#															#
#############################################################

prometheanDMG=$(ls ./ActivInspire_*_mac.dmg)

if [ -z $prometheanDMG ]; then echo "*** ERROR: Promethean .dmg missing, aborting. ***"; exit 1; fi
if [ -z `ls ./installer_choices.xml` ]; then echo "*** ERROR: installer_choices.xml missing, aborting.***"; exit 1; fi

langCode=$(echo $prometheanDMG | cut -d "_" -f 2,3)

hdiutil mount $prometheanDMG >./ai_hdiutil.log

prometheanPKG=$(ls /Volumes/ActivInspire/)
aiVersion=$(echo $prometheanPKG | cut -d " " -f 2 | tail -c +2)
rwDmgPath="./ActivInspire-$langCode-$aiVersion-rw.dmg"
roDmgPath="./ActivInspire-$langCode-$aiVersion.dmg"

hdiutil detach /Volumes/ActivInspire/ >./ai_hdiutil.log

echo "ActivInspire version is $aiVersion"

if [ -a "$roDmgPath" ]; then echo "*** ERROR: $roDmgPath already exists, aborting. ***"; exit 1; fi

echo "Converting $prometheanDMG to $rwDmgPath"
hdiutil convert -format UDRW -o "$rwDmgPath" "$prometheanDMG" >./ai_hdiutil.log

echo "Applying installer_choices.xml to $rwDmgPath"
hdiutil mount "$rwDmgPath" >./ai_hdiutil.log
cp ./installer_choices.xml /Volumes/ActivInspire/
hdiutil detach /Volumes/ActivInspire/ >./ai_hdiutil.log

echo "Converting $rwDmgPath to $roDmgPath"
hdiutil convert -format UDBZ -o "$roDmgPath" "$rwDmgPath" 1>./ai_hdiutil.log
rm "$rwDmgPath"

if [ -a "$roDmgPath" ]; then echo "$roDmgPath ready for upload to Jamf"; exit 0; else echo "*** ERROR: No output found, something went wrong. ***"; exit 1; fi

exit 0