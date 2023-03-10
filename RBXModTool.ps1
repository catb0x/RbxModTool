# Setup
$tParent = Split-Path $($(New-Object -ComObject WScript.Shell).CreateShortcut("C:\Users\$($Env:Username)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Roblox\Roblox Player.lnk").TargetPath) -Parent
Function Show-Art {
Cls
Echo  "_____  __        ___  ___          __________         __ " "|  __ \| |       |  \/  |         | |__   __|        | |" "| |__) | |____  _| \  / | ___   __| |  | | ___   ___ | |" "|  _  /| '_ \ \/ / |\/| |/ _ \ / _ ` |  | |/ _ \ / _ \| |" "| | \ \| |_) >  <| |  | | (_) | (_| |  | | (_) | (_) | |" "|_|  \_\_.__/_/\_\_|  |_|\___/ \__,_|  |_|\___/ \___/|_|" "Version 1.0" ""
}

# Code
Show-Art
$Mode = Read-Host "Choose:" "Modify[1] Export[2] Echo Roblox Dir.[3] Help[4]"
if ($Mode -eq "1") {
 Show-Art
 $ModMode = Read-Host "Skybox[1] Fonts[2] Sounds[3] (2D) Textures[4]"

 if ($ModMode -like "*1*") {
  Show-Art
  $Path = Read-Host "Skybox Path? [Path]"
  Robocopy $Path $tParent\PlatformContent\pc\textures\sky *.* /copy:DAT /mt /z
 } if ($ModMode -like "*2*") {
  Show-Art
  $Path = Read-Host "Fonts Path? [Path]"
  Robocopy $Path $tParent\content\fonts *.* /copy:DAT /mt /z
 } if ($ModMode -like "*3*") {
  Show-Art
  $Path = Read-Host "Sounds Path? [Path]"
  Robocopy $Path $tParent\content\sounds ouch.ogg /copy:DAT /mt /z
 } if ($ModMode -like "*4*") {
  Show-Art
  $Path = Read-Host "(2D) Textures Path? [Path]"
  Robocopy $Path $tParent\content\textures *.* /copy:DAT /mt /z /e
 }
 Show-Art
 Echo "Done!" "Current Roblox Directory:" $tParent
 Pause
} elseif ($Mode -eq 2) {
 Robocopy $tParent\PlatformContent\pc\textures\sky .\RobloxModTool\$($(Get-Date).ToString() -Replace('\W', '-'))\CustomSkybox s*.* /copy:DAT /mt /z
 Robocopy $tParent\content\fonts .\RobloxModTool\$($(Get-Date).ToString() -Replace('\W', '-'))\CustomFonts SourceSans*.ttf /copy:DAT /mt /z
 Robocopy $tParent\content\sounds .\RobloxModTool\$($(Get-Date).ToString() -Replace('\W', '-'))\CustomSounds *.* /copy:DAT /mt /z
 Robocopy $tParent\content\textures\Cursors .\RobloxModTool\$($(Get-Date).ToString() -Replace('\W', '-'))\CustomCursors\Cursors *.* /copy:DAT /mt /z /e
 Robocopy $tParent\content\textures .\RobloxModTool\$($(Get-Date).ToString() -Replace('\W', '-'))\CustomCursors MouseLockedCursor.png /copy:DAT /mt /z
 Show-Art
 Echo "Done! Files located at:" "C:\Users\$($Env:Username)\Desktop\RobloxModTool"
 Pause
} elseif ($Mode -eq 3) {
 Show-Art
 Echo "Current Roblox Directory:" $tParent
 Pause
} elseif ($Mode -eq 4) {
 Show-Art
 Echo "Skybox Path: Path to a folder with .tex files (textures for the skybox) inside." "Fonts Path: Path to a folder with fonts inside. Usually named SourceSans to replace the default fonts." "Sounds Path: Path to a folder with sounds in it. Everything but volume_slider and ouch (ogg) are mp3." "Textures Path: Path with (2D) textures. You can replace the default face, cursors, etc." "When replacing cursors put shiftlock here, camtoggle on \YourFolder\Cursors, and the others on \YourFolder\Cursors\KeyboardMouse" "(Note: Only cursors export.)"
 Pause
}