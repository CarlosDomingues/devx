# Requires -Version 5

# remote execution:
#   Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://devx.carlo.sh')
echo "Configuring Windows 10 and installing neat programs for software development. Heads up: this script will ask for administrative permissions a few times."

# Installs Scoop and aria2 for faster downloads.
# Scoop is a package manager for Windows.
# Packages are installed under ~/scoop
##################################################
Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
scoop install aria2 

# Installs tools commonly present in most 
# Linux distributions.
###################################################
scoop install bind `
              cacert `
              curl `
              coreutils `
              dig `
              dos2unix `
              ffmpeg `
              gawk `
              git `
              gpg `
              graphviz `
              grep `
              gzip `
              iperf3 `
              jq `
              less `
              nano `
              netcat `
              openssh `
              openssl `
              pandoc `
              png2jpeg `
              pwsh `
              sed `
              shasum `
              shellcheck `
              sudo `
              tar `
              telnet `
              time `
              touch `
              unrar `
              unzip `
              vim `
              wget `
              which `
              youtube-dl

# Installs programming languages and related
# tools.
###################################################
scoop install dotnet-sdk `
              go `
              hadolint `
              leiningen `
              gcc `
              make `
              nodejs `
              nuget `
              python `
              rustup `
              sbt `
              shellcheck `
              shfmt

# Installs cloud infrastructure related tools,
# languages and frameworks.
###################################################
scoop install aws `
              consul `
              nomad `
              packer `
              terraform `
              terragrunt `
              vault

# Configure Windows Explorer to show file
# extension, hidden files and disable 
# path limits.
###################################################
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $key Hidden 1
Set-ItemProperty $key HideFileExt 0
Set-ItemProperty $key ShowSuperHidden 1
Stop-Process -processname explorer
sudo Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1


# Sets up cmder, along with its related,
# extensions and themes.
###################################################
Install-PackageProvider -Force -Name NuGet -Scope CurrentUser
Install-Module -AllowClobber -Force posh-git -Scope CurrentUser
Install-Module -Force Oh-my-posh -Scope CurrentUser
if (!(Test-Path -Path $PROFILE)) {New-Item -Type File -Path $Profile -Force}
Import-Module posh-git
Import-Module oh-my-posh
New-Item -ItemType Directory -Force -Path $ThemeSettings.MyThemesLocation

