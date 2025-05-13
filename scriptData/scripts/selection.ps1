param (
	[string]$Version
)
$selected = 1
$options = @("Video (MP4)", "Playlist (MP4)", "Video (OGG)", "Playlist (OGG)", "Video (MP3)", "Playlist (MP3)")
$outputopt = @("A","B","C","D","E","F")

do {
	Clear-Host
	Write-Host "========================================="
	Write-Host "Welcome to YTDLP AUTO - Taco_PC - V$Version"
	Write-Host "========================================="
	Write-Host "Use UP and DOWN arrow keys to select an option"
	Write-Host "Press Enter to confirm your selection"
	Write-Host ""
	for ($i = 0; $i -lt $options.Count; $i++) {
		if ($i -eq $selected) {
			Write-Host "$($options[$i]) <-- Selected"
		} else {
			Write-Host "$($options[$i])"
		}
	}
	$key = [System.Console]::ReadKey($true).Key
	if ($key -eq 'UpArrow' -and $selected -gt 0) {
		$selected--
	} elseif ($key -eq 'DownArrow' -and $selected -lt $options.Count - 1) {
		$selected++
	} elseif ($key -eq 'Enter') {
		break
	}
} while ($true)
"$($outputopt[$selected])" | Out-File "scriptData/settings/tempoption.cfg" -NoNewline -Encoding ASCII
Clear-Host