cls
@ECHO off

ECHO.
ECHO ================================================================
ECHO                iLab Windows Template Preparation
ECHO ================================================================
ECHO.

set root="%cd%\input\windows"
cd %root%
mkdir c:\temp 2> nul

SET index=1

SETLOCAL ENABLEDELAYEDEXPANSION
FOR /D %%f IN (unattend\*.*) DO (
   SET file!index!=%%f
   ECHO !index! - %%f
   SET /A index=!index!+1
)

ECHO.
SETLOCAL DISABLEDELAYEDEXPANSION
SET /P selection="Select the windows version:"
SET file%selection% >nul 2>&1

IF ERRORLEVEL 1 (
   ECHO invalid number selected   
   EXIT /B 1
)

CALL :RESOLVE %%file%selection%%%

ECHO.
ECHO ================================================================
ECHO                      Preparing files
ECHO ================================================================
ECHO.

rem copy files to c:\temp
ECHO Copying files into place
copy /Y prep.bat c:\temp > nul 2>&1
copy /Y JoinDom.exe c:\temp > nul 2>&1
copy /Y rencomp.hta c:\temp > nul 2>&1
copy /Y %file_name%\unattend.xml c:\temp > nul 2>&1
copy /Y tzset.exe c:\temp > nul 2>&1
copy /Y main.css c:\temp > nul 2>&1
copy /Y main.js c:\temp > nul 2>&1
copy /Y main.vbs c:\temp > nul 2>&1
copy /Y sites.js c:\temp > nul 2>&1

ECHO.
ECHO ================================================================
ECHO      Running prep will shutdown the machine for templating
ECHO ================================================================
ECHO.

rem Gets a User Yes-No Choice 
set /p UserInput="Run c:\temp\prep.bat [Y/N]:"
set UserChoice=%UserInput:~0,1%
if "%UserChoice%"=="y" set UserChoice=Y
if "%UserChoice%"=="Y" (
    CALL c:\temp\prep.bat
) else (
    ECHO Run c:\temp\prep.bat manually
)

pause

GOTO :EOF

:RESOLVE
SET file_name=%1
GOTO :EOF
