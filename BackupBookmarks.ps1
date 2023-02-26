#Google Chrome Backup Bookmarks
if (Test-Path "$($env:LOCALAPPDATA)\Google\Chrome\User Data\Default\Bookmarks") {
	if (-not (test-path d:\Backup\Chrome)) { New-Item -Path d:\Backup\Chrome -Type Directory -Force:$true }
	Copy-Item -Path "$($env:LOCALAPPDATA)\Google\Chrome\User Data\Default\Bookmarks" -Destination d:\Backup\Chrome\ -Force:$true -Confirm:$false
}

#Google Edge Backup Bookmarks
if (Test-Path "$($env:LOCALAPPDATA)\Microsoft\Edge\User Data\Default\Bookmarks") {
	if (-not (test-path d:\Backup\Edge)) { New-Item -Path d:\Backup\Edge -Type Directory -Force:$true }
	Copy-Item -Path "$($env:LOCALAPPDATA)\Microsoft\Edge\User Data\Default\Bookmarks" -Destination d:\Backup\Edge\Bookmarks -Force:$true -Confirm:$false
}

#Mozilla Firefox Backup Bookmarks
if (Test-Path "$($env:APPDATA)\Mozilla\Firefox\Profiles") {
	if (-not (test-path d:\Backup\FireFox)) { New-Item -Path d:\Backup\FireFox -Type Directory -Force:$true }
	$MozillaPlaces = (get-childitem "$($env:APPDATA)\Mozilla\Firefox\Profiles" -force -recurse -ErrorAction SilentlyContinue | where-object { $_.Name -eq 'places.sqlite' }).DirectoryName
	copy-item -path "$MozillaPlaces" -Destination d:\Backup\Firefox -Force:$true -Confirm:$false
}
