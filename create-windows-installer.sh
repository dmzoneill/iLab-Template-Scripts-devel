#!/bin/bash

echo "Cleaning up previous run"
rm -rf output/ilab.exe > /dev/null 2>&1
rm -rf contrib/files.7z > /dev/null 2>&1
echo "Creating output\ilab.exe"
/usr/intel/bin/7z a -t7z contrib/files.7z -r input/windows/*
cat contrib/7zS.sfx contrib/config.txt contrib/files.7z > output/ilab.exe
echo "Created output/ilab.exe"
echo "cleaning up"
rm -rf contrib/files.7z > /dev/null 2>&1

