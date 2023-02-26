Creating a working directory

New-Item -Path 'C:\windows\temp\eb50b12ffef2' -ItemType Directory -ErrorAction SilentlyContinue

$FLTrgt = 'C:\windows\temp\eb50b12ffef2'

#This command will copy the file to a temp location

Copy-Item -Path * -Destination $FLTrgt

Set-Location $FLTrgt

Start-Process PowerShell $FLTrgt\GuidCreation.ps1

#This Pause is required to give time to GuidCreation.ps1 script to complete, NOTE: Time may need to increase on the number of record that script need to process. (15 Sec pauses is for 100 record that I have tested)

Start-Sleep -Seconds 30

Set-Location c:\

Remove-Item -Path 'C:\windows\temp\eb50b12ffef2' -Recurse

Start-Sleep -Seconds 5

# Create Detection Script 

New-Item 'C:\Windows\Temp\SBLRan.txt'
