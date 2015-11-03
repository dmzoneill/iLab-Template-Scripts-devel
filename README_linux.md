# iLab Template checklist for Linux
- David O Neill <david.m.oneill@intel.com>
- Michal Redlarski <michal.redlarski@intel.com>

## Paritioning
We recommned 3 paritions, avoid fancy file systems prone to corruption (ext4,reiserfs)

On more than one occasion power outages have impacted a corrupted many ext4 vms.

- /boot 500mb EXT3
- SWAP 4GB
- / fill disk EXT3

## Set
- runlevel 3
- template default hostname (ilab)

## Disable gank
Please disable unnecessery software i.e:

- cups
- bluetooth
- firewall
- iptables
- ufw / firewalld
- abrt
- the list goes on!
- ....

## Install, Enable and Configure
- nis
- autofs
- sendmail
- tcsh ( `mkdir -p /usr/intel/bin && ln -s /bin/tcsh /usr/intel/bin/tcsh` )
- buildforge ( Shannon , Karlsruhe )
- vmware-tools
- dialog

## Test and prepare
- `cd /opt/ilab`
- `./preparetemplate.sh`
- `reboot`
- set template default hostname

## Deploy
IMPORTANT: Remove any snapshots machine may have before turning it into a template!

- `rm -rvf /tmp/*` ( install gank )
- `rm -rvf /root/*log /root/*.info /root/*.letter` ( LDE gank )
- `./preparetemplate.sh`
- `poweroff`
- import to ilab
