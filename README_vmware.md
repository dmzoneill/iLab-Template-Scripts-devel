# iLab Template checklist for vmware
- David O Neill <david.m.oneill@intel.com>
- Michal Redlarski <michal.redlarski@intel.com>

Check the ilab website for the groups vm templates and match the naming convention they are using.

Do not call machines by projects names etc. projects come and go, Fedora 16 32bit is a better name.

Login to a hypervisor in your ilab cluster. create a new virtual machine - and choose the folowing options

## Create virtual machine
- Configuration - > Typical
- Name -> Fedora_16_IA32
- Storage -> The nfs location of the ilab vms
- Guest OS -> linux -> 2.6 kernel
- Network -> Choose vmnetwork and e1000 driver for compatability
- Create Disk -> 40gb linux / 60-80gb windows (nfs directories used for data)
- Finish

## Edit Virtual machine
- Add
- - 4vcpu 
- - 8gb ram 
- - usb device
- Remove
- - floppy 
- - disk printer
- Set
- - cdrom iso 
- - vtx (nested virtualisation)
- - enable 5 seconds delay time on boot
- - Enable sync time with host
- - Enable automatic update of vmware tools

Apply the post configuration as described in the linux/windows manual
