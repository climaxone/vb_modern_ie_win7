#!/bin/bash

# Simon Zhang
# Installing VirtualBox and Windows 7 IE11 Modern.ie

printf "VirtualBox and Modern.IE auto install for OSX\n\n"

# Username Variable
USER=$(ls -l /dev/console | cut -d " " -f 4)

# URL to the ISO
WINVM_DOWNLOAD_URL="https://az412801.vo.msecnd.net/vhd/VMBuild_20141027/VirtualBox/IE11/Windows/IE11.Win7.For.Windows.VirtualBox.zip" 

# file path to the directory
FILEPATH="/Users/$USER/Documents/VirtualBox/"

# file path to the zip file
VB_ZIP_PATH="/tmp/IE11.Win7.For.Windows.VirtualBox.zip"

# file to tmp folder
VB_TMP_PATH="/tmp/"

# Path to VirtualBox app
VB_APP_PATH="/Applications/VirtualBox.app"



# write the function

function download_iso() {
	#Creates the VM directory in user downloads folder
	mkdir -p "$FILEPATH"
	printf "Creating VirtualBox directory...\n"

	#downloads the VM from https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/mac/
	/usr/bin/curl -o "$VB_ZIP_PATH" --url "$WINVM_DOWNLOAD_URL"
	printf "Downloading Modern IE iso...\n"

	#unzips it and extracts to user downloads folder
	unzip "$VB_ZIP_PATH" -d "$FILEPATH"
	printf "unzipping ISO to VirtualBox directory...\n"

	#imports the OVA file into VirtualBox
	VBoxManage import /Users/$USER/Documents/VirtualBox/IE11\ -\ Win7.ova
	printf "importing VM into VirtualBox...\n"

	#removes the downloaded zip file
	printf "deleting temporary files...\n"
	rm -rf "$VB_TMP_PATH"
	
}


# Start of the action

if [ ! -d "$VB_APP_PATH" ]; then 
    printf "EvernoteIT: No VirtualBox installed, will install now\n"
	#create a -event in your JSS and name it installvirtualbox. The event would be to install a dmg or pkg of VirtualBox
	sudo jamf policy -event installvirtualbox
fi

printf "EvernoteIT: VirtualBox installed, downloading Modern.IE ISO...\n"

download_iso
	
printf "exiting...completed installation\n"




#END
