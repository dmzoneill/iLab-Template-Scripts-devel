
On Error Resume Next

Dim NetworkInterfaceID
Dim RegKeyValue
Dim Temp


' WriteReg  write a specified registry key into the defined regestry location
' @param RegPath The path to the new / existing key
' @param Value the value of the key value pair
' @param RegType the type of the registry entry ( REG_DWORD ) or whatever
Function WriteReg( RegPath , Value , RegType )

	Dim objRegistry, Key
	Set objRegistry = CreateObject( "Wscript.shell" )
	Key = objRegistry.RegWrite( RegPath , Value , RegType )
	WriteReg = Key
	
End Function


' ReadReg read a specified registry key into the defined registry location
' @param RegPath The path to the required key
' @return the value at the specifified location
Function ReadReg( RegPath )

	Dim objRegistry , Key
	Set objRegistry = CreateObject( "Wscript.shell" )
	Key = objRegistry.RegRead( RegPath )
	ReadReg = Key
	
End Function


' KeyExists determines if a specified registry key exists at the defined location
' @param RegPath The path to the ky to look for
' @return boolean true or false		
Function KeyExists( key )

	Dim objShell
	On Error Resume Next
	Set objShell = CreateObject( "WScript.Shell" )
	objShell.RegRead( key )
	Set objShell = Nothing
	If Err = 0 Then KeyExists = True
	
End Function


' set the timezone based upon the site chosen
Sub changetimezone( timezone )
	Set objShell = CreateObject( "WScript.shell" )  
	objShell.Run "c:\temp\tzset.exe /p " & chr(34) & timezone & chr(34)
End Sub


' Restarts the computer	
Sub restart()

	Set objShell = CreateObject( "WScript.Shell" )
	objShell.Run "C:\WINDOWS\system32\shutdown.exe -r -t 0"

End Sub


' activation for non domain machines
Sub activation()

	cmdkms = "C:\Windows\System32\cscript.exe C:\Windows\System32\slmgr.vbs /skms kms.intel.com"
	cmdact = "C:\Windows\System32\cscript.exe C:\Windows\System32\slmgr.vbs /ato"
							
	' set activation server
	Set objShell = CreateObject( "WScript.Shell" )
	setkms = objShell.Run( cmdkms , 0 , true )

	' attempt activation
	Set objShell = CreateObject( "WScript.Shell" )
	tryact = objShell.Run( cmdact , 0 , true )

End Sub

' Chnages the computer name and joins it to the domain
Sub changename( domainrequired, ou, addomain)

	Dim wmiServices
	Dim objComputer
	Dim retVal
	Dim pw
	Dim user
	Dim fqdom
	Dim cmd
	Dim bits
	
	' Get as instances of the management object 
	Set wmiServices = GetObject( "Winmgmts:root\cimv2" )

	' Call always gets only one Win32_ComputerSystem object.
	For Each objComputer in wmiServices.InstancesOf( "Win32_ComputerSystem" )
		
		' Rename the computer in this iteration of the loop
		retVal = objComputer.rename( edComputerName.value )
		
		' If unable to rename then through an error
		If retVal <> 0 Then
		
			window.alert( "Rename failed. Error = " & Err.Number )
			
		Else
			
			' Adjust machine for best performance
			WriteReg "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\VisualFXSetting", 2, "REG_DWORD" 
			
			' Check system architecture for proper next step
			bits = GetObject("winmgmts:root\cimv2:Win32_Processor='cpu0'").AddressWidth

			' Set HEFE primary reboot contact
			If bits = 32 Then
				WriteReg "HKEY_LOCAL_MACHINE\SOFTWARE\Intel\ECAT\PrimaryRebootContact", edComputerOwner.value, "REG_SZ"
			Else
				WriteReg "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Intel\ECAT\PrimaryRebootContact", edComputerOwner.value, "REG_SZ"
			End If
						
			pw = "/.PGqwD\6N`9.t:EBM&`\VP{"
			user = "amr\ecsys_ilabbuild"
			fqdom = addomain & ".corp.intel.com"
			
			cmd = "c:\Temp\JoinDom.exe " & user & " """ & pw & """ " & fqdom & " """ & ou & """"
			
			joindom = -1
			
			If domainrequired = True Then
			
				' execute joindom command
				Set objShell = CreateObject( "WScript.Shell" )
				joindom = objShell.Run( cmd , 0 , true )
				
			Else	
			
				' activation for non domain machines
				activation()
				restart()
				joindom = 0
				
			End If
			
			' It it fails give them an alert
			If joindom <> 0 Then
			
				window.alert( "Join domain failed, try a differnet hostname" )
			
			Else
			
				' turn on 'Use this connections DNS suffic in DNS registration
				' This will register it into the SITECODE.intel.com
				' For the first 20 nics
			
				For i = 0 to 20

					RegistryKeyName = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkCards\" & i & "\"
					
					If KeyExists( RegistryKeyName ) Then
					
						Reg = RegistryKeyName + "ServiceName"
						NetworkInterfaceID = ReadReg( Reg ) 
						RegKeyValue = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters\Interfaces\" + NetworkInterfaceID + "\RegisterAdapterName"
						WriteReg RegKeyValue , 1 , "REG_DWORD" 
						
					End If
					
				Next
			
				' call reboot countdown ticker
				Call rebootcountdown()		
			
			End If			
		End If
	Next
End Sub
			