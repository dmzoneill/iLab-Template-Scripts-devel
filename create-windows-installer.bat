cls
@echo off
echo Cleaning up previous run
del /f /q output\ilab.exe 2> nul
del /f /q contrib\files.7z 2> nul
echo Creating output\ilab.exe
"c:\Program Files (x86)\7-Zip\7z" a -t7z contrib\files.7z -r input\windows\*
copy /b contrib\7zS.sfx + contrib\config.txt + contrib\files.7z output\ilab.exe
echo Created output\ilab.exe
echo cleaning up
del /f /q contrib\files.7z 2> nul
