# Download latest release
Invoke-WebRequest -Uri "www.autohotkey.com/download/ahk-v2.exe" -OutFile "ahk-v2.exe"

# Install
start -wait .\ahk-v2.exe /silent

# Remove installer
del .\ahk-v2.exe

# Enable our shortcuts at sign-in
Copy-Item "config/autohotkey.exe" -Destination "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
