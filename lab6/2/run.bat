@echo off

echo Task of XCOPY is set
schtasks /CREATE /SC MINUTE /MO 1 /RU "SYSTEM" /TN NCOPY /TR "C:\WINDOWS\SYSTEM32\xcopy.exe /Z /Y C:\WINDOWS\test2.txt \\%COMPUTERNAME%\temp"
echo:

call :wait_xcopy
ping 127.0.0.1 -n 6 > NUL

taskkill /IM "xcopy.exe" /F

echo Comparing files after emergency termination [dif.txt]
fc C:\WINDOWS\test2.txt \\%COMPUTERNAME%\temp\test2.txt > dif.txt
echo:

echo Rerun XCOPY process
C:\WINDOWS\SYSTEM32\xcopy.EXE /Z /Y C:\WINDOWS\test2.txt \\%COMPUTERNAME%\temp\
echo XCOPY process finished
echo:

echo Comparing files after rerun [complete.txt]
fc C:\WINDOWS\test2.txt \\%COMPUTERNAME%\temp\test2.txt > complete.txt
echo:

schtasks /DELETE /TN NCOPY /F

EXIT /B %ERRORLEVEL%

:wait_xcopy
	echo Waiting for XCOPY process
	:loop
		tasklist | findstr /I "xcopy" > NUL
		if %ERRORLEVEL%==0 goto break
		goto loop
	:break
	echo XCOPY process is running
EXIT /B 0
