#Google Chrome Restore Bookmarks
if (Test-Path "$($env:LOCALAPPDATA)\Google\Chrome\User Data\Default\Bookmarks") {
	if (test-path d:\Backup\Chrome) {
		Copy-Item -Path d:\Backup\Chrome\bookmarks -destinatiom	"$($env:LOCALAPPDATA)\Google\Chrome\User Data\Default\" -Force:$true -Confirm:$false
	}
}

#Google Edge Restore Bookmarks
if (Test-Path "$($env:LOCALAPPDATA)\Microsoft\Edge\User Data\Default\Bookmarks") {
	if (test-path d:\Backup\Edge) {
		Copy-Item -Path d:\Backup\Edge\bookmarks -destination "$($env:LOCALAPPDATA)\Microsoft\Edge\User Data\Default\" -Force:$true -Confirm:$false
	}
}
#Mozilla Firefox Restore Bookmarks
# To copy it back... SIDE NOTE*** if mozilla being re-installed or fresah installed, must open mozilla first to recreate a default place.sqlite to replace
if (Test-Path "$($env:APPDATA)\Mozilla\Firefox\Profiles") {
	if (test-path d:\Backup\FireFox) {
		$MozillaPlaces = (get-childitem "$($env:APPDATA)\Mozilla\Firefox\Profiles" -force -recurse -ErrorAction SilentlyContinue | where-object Name -eq 'places.sqlite').DirectoryName
		Copy-Item D:\Backup\FireFox\*.* -Recurse -Destination "$($MozillaPlaces)" -Force:$true -Confirm:$false
	}
}
