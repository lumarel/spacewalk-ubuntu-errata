# Spacewalk/Uyuni Errata Import for Ubuntu
Modified version of https://github.com/philicious/spacewalk-scripts

- **parseUbuntu.py** parses https://lists.ubuntu.com/archives/ubuntu-security-announce/$DATE.txt.gz into an XML which can be read by errata-import.py
- **errata-import.py** By https://github.com/pandujar Ported version of the previous one. Includes some enhancenments like date, author and better package processing. Its quite faster than the Per>
- **errata-sync.sh** Modified version from uyuni import scripts.

This script will download errata information from Ubuntu, parse it, and import it into a spacewalk or Uyuni server for use as patch data. This allows you to see if an update contains a bugfix, security update, etc.
### Requirements
 - Python
 - An administrative account on your Spacewalk/Uyuni server


### Usage
First, clone the repository onto the Uyuni server
`git clone https://github.com/Twhitehouse-SSHIS/spacewalk-ubuntu-errata /opt/spacewalk-ubuntu-errata`
*Ensure the files are executable by root.*

Secondly, edit the **errata-import.py** script and modify the ***login*** and ***passwd*** at the top of the script. This needs to be an administrative account on Spacewalk/Uyuni

Thirdly, amend the excluded/included channels as necessary. The defaults are Uyuni\'s 1806 default channel names.

Finally, run the **errata-sync.sh** script either with or without the "all" switch, and add it to your CRON as appropriate, I suggest daily, early in the morning.


#### Example:

**Run this at least once**
To sync data from the first full month of Ubuntu updates
`/opt/spacewalk-ubuntu-errata/errata-sync.sh all`

**Run this moving forward** (This should be your CRON command)
To sync data from the current calendar month ONLY
`/opt/spacewalk-ubuntu-errata/errata-sync.sh`

**Cron Entry**
`0 2 * * * /opt/spacewalk-ubuntu-errata/errata-sync.sh`

