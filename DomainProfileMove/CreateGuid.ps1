$data = Import-Csv -Path C:\windows\temp\eb50b12ffef2\data.csv

# Regex pattern for SIDs
$PatternSID = 'S-1-5-21-\d+-\d+\-\d+\-\d+$'

# Get Username, SID, and location of ntuser.dat for all users.

$ProfileList = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*' | Where-Object {$_.PSChildName -match $PatternSID} |
    Select  @{name="SID";expression={$_.PSChildName}},
            @{name="GUID";expression={$_.GUID}},
            @{name="UserHive";expression={"$($_.ProfileImagePath)\ntuser.dat"}},
            @{name="Username";expression={$_.ProfileImagePath -replace '^(.*[\\\/])', ''}}


Foreach ($item1 in $data) 
{

    # Load User profile SID and match with the CSV data.
   
   Foreach ($item in $ProfileList) 
   {

   try{
        IF ($item1.sid -eq $item.sid) {
            
            $profileGUIDvalue = $item1.GUID
            $profileSID = $item.sid
          
           if((Test-Path -path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileGuid") -eq $False) {New-Item "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileGuid" -ErrorAction SilentlyContinue};
            
            New-Item -path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileGuid\$profileGUIDvalue" -ErrorAction SilentlyContinue
                
            New-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileGuid\$profileGUIDvalue" -Name "SidString" -PropertyType String -Value $item.sid -ErrorAction SilentlyContinue

            New-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Profilelist\$profileSID" -Name "GUID" -PropertyType String -Value $item1.GUID -ErrorAction SilentlyContinue      
                     
        }
    }catch{
       Write-host "No Match found."
     }
    }
} 
