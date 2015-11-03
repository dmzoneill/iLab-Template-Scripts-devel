IF EXIST %systemroot%\system32\sysprep\sysprep.exe (
	%systemroot%\system32\sysprep\sysprep.exe /oobe /generalize /shutdown /unattend:c:\temp\unattend.xml
) ELSE IF EXIST %systemroot%\sysnative\sysprep\sysprep.exe (
	%systemroot%\sysnative\sysprep\sysprep.exe /oobe /generalize /shutdown /unattend:c:\temp\unattend.xml
) ELSE ( echo "Uhhuh. sysprep.exe not found. Man the lifeboats!" )