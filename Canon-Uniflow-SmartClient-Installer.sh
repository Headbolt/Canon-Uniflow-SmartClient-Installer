#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	Canon-Uniflow-SmartClient-Installer.sh
#	https://github.com/Headbolt/Canon-Uniflow-SmartClient-Installer
#
#   This Script is designed for use in JAMF and was designed to create a config file that the Canon Uniflow SmartClient Installer
#	relies on during install
#
###############################################################################################################################################
#
# Usage Guide
#
#	Use this Script as a "BEFORE" script in the policy, Add the Application Package Twice
#	1 : As a "Cache Installer"
#	2 : As an "Install Cached"
#
#	This way the script puts the corrdct file in the "JAMF Waiting Room" the installer will cache there, and then install with the
#	config file in place, it is reccomended to run a script or command "AFTER" the install to clean up the file from the "Waiting Room"
#
#	The Following Variables should be defined
#	Variable 4 - Named "Config File Name - eg. .tenantcfg.plist"
#	Variable 5 - Named "UFO Tenant Domain - eg. company.region.uniflowonline.com"
#	Variable 6 - Named "Secure PrintQueue Name - eg. Secure Print"
#	Variable 7 - Named "Installer Name - eg. CompanyName_Mac_Uniflow"
#	Variable 8 - Named "Silent User Registration - eg. aaaaaabbbbbbccccccc"
#	Variable 9 - Named "Installer ID - eg. aaaaaabbbbbbccccccc"
#	Variable 10 - Named "Product Version  - eg. 2024.1.0"
#	Variable 11 - Named "Package Version  - eg. 2024.1.0.1"
#
###############################################################################################################################################
#
# HISTORY
#
#    Version: 1.0 - 15/03/2024
#
#    15/03/2024 - V1.0 - Created by Headbolt
#
###############################################################################################################################################
#
#   DEFINE VARIABLES & READ IN PARAMETERS
#
###############################################################################################################################################
#
ConfigFileName="$4" # Grab the config file name from JAMF variable #4 eg. .tenantcfg.plist
UFOTenantDomain="$5" # Grab the UFOTenantDomain from JAMF variable #5 eg. company.region.uniflowonline.com
SecurePrintQueueName="$6" # Grab the SecurePrintQueueName from JAMF variable #6 eg. Secure Print
InstallerName="$7" # Grab the InstallerName from JAMF variable #7 eg. CompanyName_Mac_Uniflow
SilentUserRegistration="$8" # Grab the SilentUserRegistration from JAMF variable #8 eg. eg. aaaaaabbbbbbccccccc
InstallerId="$9" # Grab the InstallerId from JAMF variable #9 eg. eg. aaaaaabbbbbbccccccc
ProductVersion="${10}" # Grab the ProductVersion from JAMF variable #10 eg. eg. 2024.1.0
PackageVersion="${11}" # Grab the PackageVersion from JAMF variable #11 eg. eg. 2024.1.0.1
#
ConfigureFolder="/Library/Application Support/JAMF/Waiting Room" # Set the folder that the config file needs to go into
# Now Set the other possible options that we could not fit within the available JAMF Variables
SCStartOption="reboot"
UseIPP="true"
IgnoreSystemLoginInformation="false"
SupportFinishingOptions="true"
#
ScriptName="Application | Canon Uniflow Smart Client | Installer Config" # Set The Scrip Name for logging purposes
ExitCode=0 #Set The ExitCode to a Default "OK"
#
###############################################################################################################################################
#
#   Checking and Setting Variables Complete
#
###############################################################################################################################################
# 
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################################################
#
# Defining Functions
#
###############################################################################################################################################
#
# ConfigFile Function
#
ReWriteConfigFile(){
#
/bin/echo 'Rewriting Config File "'"$ConfigureFolder"/"$ConfigFileName"'"'
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
/bin/echo '<?xml version="1.0" encoding="UTF-8"?>'
/bin/echo '<?xml version="1.0" encoding="UTF-8"?>' > "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">'
/bin/echo '<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '<plist version="1.0">'
/bin/echo '<plist version="1.0">' >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '  <dict>'
/bin/echo '  <dict>' >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '    <key>InstallerId</key>'
/bin/echo '    <key>InstallerId</key>' >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo "    <string>$InstallerId</string>"
/bin/echo "    <string>$InstallerId</string>" >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '    <key>InstallerName</key>'
/bin/echo '    <key>InstallerName</key>' >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo "    <string>$InstallerName</string>"
/bin/echo "    <string>$InstallerName</string>" >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '    <key>ProductVersion</key>'
/bin/echo '    <key>ProductVersion</key>' >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo "    <string>$ProductVersion</string>"
/bin/echo "    <string>$ProductVersion</string>" >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '    <key>PackageVersion</key>'
/bin/echo '    <key>PackageVersion</key>' >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo "    <string>$PackageVersion</string>"
/bin/echo "    <string>$PackageVersion</string>" >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '    <key>UFOTenantDomain</key>'
/bin/echo '    <key>UFOTenantDomain</key>' >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo "    <string>$UFOTenantDomain</string>"
/bin/echo "    <string>$UFOTenantDomain</string>" >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '    <key>SCStartOption</key>'
/bin/echo '    <key>SCStartOption</key>' >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo "    <string>$SCStartOption</string>"
/bin/echo "    <string>$SCStartOption</string>" >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '    <key>UseIPP</key>'
/bin/echo '    <key>UseIPP</key>' >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo "    <string>$UseIPP</string>"
/bin/echo "    <string>$UseIPP</string>" >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '    <key>SecurePrintQueueName</key>'
/bin/echo '    <key>SecurePrintQueueName</key>' >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo "    <string>$SecurePrintQueueName</string>"
/bin/echo "    <string>$SecurePrintQueueName</string>" >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '    <key>IgnoreSystemLoginInformation</key>'
/bin/echo '    <key>IgnoreSystemLoginInformation</key>' >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo "    <string>$IgnoreSystemLoginInformation</string>"
/bin/echo "    <string>$IgnoreSystemLoginInformation</string>" >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '    <key>SupportFinishingOptions</key>'
/bin/echo '    <key>SupportFinishingOptions</key>' >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo "    <string>$SupportFinishingOptions</string>"
/bin/echo "    <string>$SupportFinishingOptions</string>" >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '    <key>SilentUserRegistration</key>'
/bin/echo '    <key>SilentUserRegistration</key>' >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo "    <string>$SilentUserRegistration</string>"
/bin/echo "    <string>$SilentUserRegistration</string>" >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '  </dict>'
/bin/echo '  </dict>' >> "$ConfigureFolder"/"$ConfigFileName"
/bin/echo '</plist>'
/bin/echo '</plist>' >> "$ConfigureFolder"/"$ConfigFileName"
#
}
#
###############################################################################################################################################
#
# Section End Function
#
SectionEnd(){
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
}
#
###############################################################################################################################################
#
# Script End Function
#
ScriptEnd(){
#
/bin/echo Ending Script '"'$ScriptName'"'
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
exit $ExitCode
#
}
#
###############################################################################################################################################
#
# End Of Function Definition
#
###############################################################################################################################################
# 
# Begin Processing
#
###############################################################################################################################################
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
SectionEnd
#
/bin/echo 'Deleting any pre-existing copy of the config file'
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo 'Running Command "'rm "$ConfigureFolder"/"$ConfigFileName"
rm "$ConfigureFolder"/"$ConfigFileName"
#
SectionEnd
ReWriteConfigFile
#
SectionEnd
/bin/echo 'Checking completed file'
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo 'Running Command "'cat "$ConfigureFolder"/"$ConfigFileName"
/bin/echo # Outputting a Blank Line for Reporting Purposes
cat "$ConfigureFolder"/"$ConfigFileName"
#
SectionEnd
ScriptEnd
