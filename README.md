# iLab-Template-Scripts
## Template Preparation

Before using the ilab templates scripts, we have defined some general setup guidelines for templates.  

- [Vmware ESXi](README_vmware.md)
- [Linux](README_linux.md) --- [Helpful setup scripts](https://github.intel.com/dmoneil2/EC-SI-OsPostConfig)
- [Windows](README_windows.md)

## Clone
  1. # git clone https://github.intel.com/ilab/iLab-Template-Scripts<br />
  2. # cd iLab-Template-Scripts<br />
  
## Linux Usage
  
##### Modify sites
  1. # vi input/unix/common_config/opt/ilab/<b>XXX</b>-sites.sh

##### Create Self extracting setup file
  1. # ./create-unix-installer.sh<br />

##### Prepare your ilab template
  1. # scp output/ilab.run root@<b>TEMPLATE</b>:/root<br />
  2. # ssh root@<b>TEMPLATE</b><br />
  3. # ./ilab.run<br />

## Windows Usage
  
##### Modify sites
  1. # notepad input/windows/sites.js

##### Create Self extracting setup file
  1. # ./create-windows-installer.bat<br />

##### Prepare your ilab template
  1. # net use x: \\\\<b>TEMPLATE</b>\\c$
  2. # copy output\ilab.exe x:\
  3. # mstsc /v:"<b>TEMPLATE</b>"
  4. # c:\ilab.exe
