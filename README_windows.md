# iLab Template checklist for Windows
- David O Neill <david.m.oneill@intel.com>
- Michal Redlarski <michal.redlarski@intel.com>

## Set
- template default hostname (ilab)

## Disable gank 
- hibernation  
- system restore 

## Install, Enable and Configure
Below list is a collection of common software being used in Labs - please treat
that as general guidance rather then strict rule.

- Visual Studio 2008 2010
- Eclipse ganymede helios galileo europa Juno 
- Notepad++
- 7zip
- Winscp
- Putty tool kit
- Fsecure
- Daemon tools
- Clearcase
- Mcafee
- Chrome
- Firefox
- Tortoise Svn / Git

## Access
- Remote Desktop
- Disable firewall
- GER\Domain Users -> Administrators local group (User must remove this group after adding themselves)

## Copy
- run the ilab.exe

## Test
IMPORTANT: you will need local administrator's password to proceed

- Unjoin domain
- Sysprep:
-- `cmd`
-- `%systemroot%\system32\sysprep\sysprep.exe /oobe /generalize /shutdown /unattend:c:\temp\.xml`
- Snapshot VM
- Power on and test scripts funtionality
- Revert current snapshot

## Deploy
WARNING: Remove any snapshots machine may have before turning it into a template!

- Import to ilab ENV
- Save as template
