#!/bin/bash

### Processes Ubuntu Errata and imports them to Spacewalk

## Configure Variables ##

# https://github.com/stevemeier/cefs/ location (With trailing slash)
export CEFS_PATH='/opt/cefs/'

# Spacewalk/Uyuni Username/Password with administrator access 
export SPACEWALK_USER='errata'
export SPACEWALK_PASS='pass'

# INCLUDE_CHANNELS - Comma separated list of Channel labels
INCLUDE_CHANNELS='ubuntu-1804-amd64-main-uyuni,ubuntu-1804-amd64-main-security-uyuni,ubuntu-1804-amd64-main-updates-uyuni,ubuntu-1804-amd64-universe-uyuni,ubuntu-1804-amd64-universe-updates-uyuni'

## End of variables ##


# Get the base path for the script #
BASE_PATH="$(echo ${0} | sed 's/errata-sync.sh//')"

# Make sure we have English locale
export LC_TIME="en_US.utf8"

# Obtains the current date and year.
DATE=`date +"%Y-%B"`

# Cleanup before download
cd ${BASE_PATH}
rm -rf errata/$DATE.txt
rm -f ubuntu-errata.xml

# Download Errata
curl https://lists.ubuntu.com/archives/ubuntu-security-announce/$DATE.txt.gz > errata/$DATE.txt.gz
gunzip -f errata/$DATE.txt.gz

# Processes and imports the errata.
${BASE_PATH}parseUbuntu.py errata/$DATE.txt
${CEFS_PATH}errata-import.pl --server localhost --errata ${BASE_PATH}ubuntu-errata.xml --include-channels="${INCLUDE_CHANNELS}"} --publish


# Unset for security
unset SPACEWALK_USER
unset SPACEWALK_PASS
