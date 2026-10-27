# iLab-Template-Scripts

<p align="center">
  <img src=".github/logo.png" alt="iLab-Template-Scripts-devel logo" width="128" />
</p>

## Template Preparation

Before using the ilab templates scripts, we have defined some general setup guidelines for templates.

- [Vmware ESXi](README_vmware.md)
- [Linux](README_linux.md) --- [Helpful setup scripts](https://github.intel.com/dmoneil2/EC-SI-OsPostConfig)
- [Windows](README_windows.md)

## Clone

1. `git clone <https://github.intel.com/ilab/iLab-Template-Scripts>`
2. `cd iLab-Template-Scripts`

## Linux Usage

### Modify sites

1. `vi input/unix/common_config/opt/ilab/XXX-sites.sh`

### Create Self extracting setup file

1. `./create-unix-installer.sh`

### Prepare your ilab template

1. `scp output/ilab.run root@TEMPLATE:/root`
2. `SSH root@TEMPLATE`
3. `./ilab.run`

## Windows Usage

### Modify sites (Windows)

1. `notepad input/windows/sites.js`

### Create Self extracting setup file (Windows)

1. `./create-windows-installer.bat`

### Prepare your ilab template (Windows)

1. `net use x: \\\\TEMPLATE\\c$`
2. `copy output\ilab.exe x:\`
3. `mstsc /v:"TEMPLATE"`
4. `c:\ilab.exe`
