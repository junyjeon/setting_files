param($File)
Add-Type -AssemblyName presentationCore
$player = New-Object System.Windows.Media.MediaPlayer
$player.Open([System.Uri]"file:///$File")
$player.Play()
Start-Sleep -Seconds 2
$player.Close()