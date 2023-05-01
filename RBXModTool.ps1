# Setup
$TParent = Split-Path $($(New-Object -ComObject WScript.Shell).CreateShortcut("C:\Users\$Env:Username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Roblox\Roblox Player.lnk").TargetPath) -Parent
Write-Host "
 _____ __        ___  ___          __________         __
|  __ \| |       |  \/  |         | |__   __|        | |
| |__) | |____  _| \  / | ___   __| |  | | ___   ___ | |
|  _  /| '_ \ \/ / |\/| |/ _ \ / _  |  | |/ _ \ / _ \| |
| | \ \| |_) >  <| |  | | (_) | (_| |  | | (_) | (_) | |
|_|  \_\_.__/_/\_\_|  |_|\___/ \__,_|  |_|\___/ \___/|_|
Version 1.1 Development$(" " * 33)
" -ForegroundColor DarkMagenta -BackgroundColor White

# Code
$Mode = Read-Host "Choose:" "Modify[1] Export[2] Echo Roblox Dir.[3] Help[4]"
if ($Mode -eq "1") { # Modify
 $ModMode = Read-Host "Skybox[1] Fonts[2] Sounds[3] (2D) Textures[4]"
 if ($ModMode -like "*1*") { ## Skybox
  $Path = Read-Host "Skybox Path? [Path]"
  Robocopy $Path $TParent\PlatformContent\pc\textures\sky *.* /copy:DAT /mt /z | Out-Null
 } if ($ModMode -like "*2*") { ## Fonts
  $Path = Read-Host "Fonts Path? [Path]"
  Robocopy $Path $TParent\content\fonts *.* /copy:DAT /mt /z | Out-Null
 } if ($ModMode -like "*3*") { ## Sounds
  $Path = Read-Host "Sounds Path? [Path]"
  if ($Path -like "*,*") { 
   $AudParts = $Path -split ","
   $AudPath = $AudParts[1]
   $SoundId = $AudParts[0]
   $AcceptHeader = "audio/$(([System.IO.Path]::GetExtension($AudPath)).Substring(1))"
   Invoke-WebRequest -Uri https://api.hyra.io/audio/$SoundId -Headers @{"Accept" = "audio/$(([System.IO.Path]::GetExtension($AudPath)).Substring(1))"} -OutFile $tParent\content\sounds\$AudPath
   Echo "$($AudParts[2])"
  } else {
   Robocopy $Path $TParent\content\sounds *.ogg *.mp3 /copy:DAT /mt /z | Out-Null
  }
 } if ($ModMode -like "*4*") { ## Textures
  $Path = Read-Host "(2D) Textures Path? [Path]"
  if ($Path -like "*,*") {
   $TexParts = $($Path -split ",")
   $DecalId = $TexParts[0]
   $TexPath = $TexParts[1]
   $TexWidth = [int]$TexParts[2]
   $TexHeight = [int]$TexParts[3]
   Invoke-WebRequest -Uri $(Invoke-RestMethod -Uri "https://thumbnails.roblox.com/v1/assets?assetIds=$($DecalId)&size=420x420&format=Png&isCircular=false").data[0].imageUrl -OutFile $TParent\content\textures\temp.png
   if ($TexWidth -and $TexHeight) {
    $Image = [System.Drawing.Image]::FromFile("$TParent\content\textures\temp.png")
    $NewImage = New-Object System.Drawing.Bitmap $TexWidth, $TexHeight
    $Graphics = [System.Drawing.Graphics]::FromImage($NewImage)
    $Graphics.DrawImage($Image, 0, 0, $TexWidth, $TexHeight)
    $Graphics.Dispose(); $Image.Dispose()
    $NewImage.Save("$TParent\content\textures\temp.png", [System.Drawing.Imaging.ImageFormat]::Png)
    $NewImage.Dispose()
   }
   Remove-Item $TParent\content\textures\$TexPath
   Rename-Item $TParent\content\textures\temp.png $TParent\content\textures\$TexPath -Force
  } else {
   Robocopy $Path $TParent\content\textures *.* /copy:DAT /mt /z /e  | Out-Null
  }
 }
 Write-Host "Done! Current Roblox Directory:`n$TParent"
 Pause
} elseif ($Mode -eq 2) { # Export
 Robocopy $TParent\PlatformContent\pc\textures\sky .\RobloxModTool\$($(Get-Date).ToString() -Replace('\W', '-'))\CustomSkybox s*.* /copy:DAT /mt /z | Out-Null
 Robocopy $TParent\content\fonts .\RobloxModTool\$($(Get-Date).ToString() -Replace('\W', '-'))\CustomFonts SourceSans*.ttf /copy:DAT /mt /z | Out-Null
 Robocopy $TParent\content\sounds .\RobloxModTool\$($(Get-Date).ToString() -Replace('\W', '-'))\CustomSounds *.* /copy:DAT /mt /z | Out-Null
 Robocopy $TParent\content\textures\Cursors .\RobloxModTool\$($(Get-Date).ToString() -Replace('\W', '-'))\CustomCursors\Cursors *.* /copy:DAT /mt /z /e | Out-Null
 Robocopy $TParent\content\textures .\RobloxModTool\$($(Get-Date).ToString() -Replace('\W', '-'))\CustomCursors MouseLockedCursor.png /copy:DAT /mt /z | Out-Null
 Write-Host "Done! Files located at:`nC:\Users\$($Env:Username)\Desktop\RobloxModTool"
 Pause
} elseif ($Mode -eq 3) { # Echo Dir
 Write-Host "Current Roblox Directory:`n$TParent"
 Pause
} elseif ($Mode -eq 4) { # Help
 Write-Host "Skybox Path: Path to a folder with .tex files (textures for the skybox) inside.`nFonts Path: Path to a folder with fonts inside. Usually named SourceSans to replace the default fonts.`nSounds Path: Path to a folder with sounds in it. Everything but volume_slider and ouch (ogg) are mp3. Can be an audio ID`n(in this format: audioid,subfolder-optional\...\file.ogg OR .mp3).`nTextures Path: Path with (2D) textures. You can replace the default face, cursors, etc.`nWhen replacing cursors put shiftlock (MouseLockedCursor) here, camtoggle (CrossMouseIcon) on \YourFolder\Cursors,`nand the others on \YourFolder\Cursors\KeyboardMouse (Note: Only cursors export.) Can be a decal id (in this format:`ndecalid,subfolder-optional\...\file.png,width-optional,height-optional)."
 Pause
}
