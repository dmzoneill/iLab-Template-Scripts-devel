#!/bin/bash

rc-update add ilab default


# delete udev rules
rm -rvf /etc/udev/rules.d/70-persistent-net.rules

