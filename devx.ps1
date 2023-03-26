# Requires -Version 5

# remote execution:
#   Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://devx.carlo.sh')
Write-Host "Configuring Windows 10 and installing neat programs for software development. Heads up: this script will ask for administrative permissions a few times." -ForegroundColor Green

# Install Dektop programs
###################################################
winget install -e --id AgileBits.1Password.Beta
winget install -e --id AgileBits.1Password.CLI
winget install -e --id Brave.Brave.Beta
winget install -e --id Discord.Discord
winget install -e --id Microsoft.AppInstallerFileBuilder
winget install -e --id Microsoft.BingWallpaper
winget install -e --id Microsoft.Git
winget install -e --id Microsoft.GitCredentialManagerCore
winget install -e --id GitHub.cli
winget install -e --id GitHub.GitHubDesktop.Beta
winget install -e --id Microsoft.MouseWithoutBorders
winget install -e --id Microsoft.OpenSSH.Beta
winget install -e --id Microsoft.PCManager
winget install -e --id Microsoft.PerfView
winget install -e --id Microsoft.Sysinternals.Desktops
winget install -e --id Microsoft.Sysinternals.ProcessExplorer
winget install -e --id Microsoft.Sysinternals.ProcessMonitor
winget install -e --id Microsoft.VisualStudioCode.Insiders
winget install -e --id Microsoft.WindowsTerminal.Preview
winget install -e --id RedHat.Podman
winget install -e --id RedHat.Podman-Desktop
winget install -e --id Transmission.Transmission
winget install -e --id Valve.Steam
winget install -e --id VideoLAN.VLC 
winget install -e --id Telegram.TelegramDesktop.Beta
winget install -e --id WhatsApp.WhatsApp

# Installs Scoop, aria2 for faster downloads and
# Git as a dependecy for several packages.
# Scoop is a package manager for Windows.
# Packages are installed under ~/scoop
##################################################
Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
scoop update
scoop install aria2 git

# Installs common tools
###################################################
scoop install `
              1password-cli `
              base64 `
              bind `
              cacert `
              curl `
              coreutils `
              dagger `
              dd `
              diffutils `
              direnv `
              dos2unix `
              findutils `
              gawk `
              gnupg `
              gpg `
              graphviz `
              grep `
              gzip `
              hadolint `
              iperf3 `
              gh `
              jid `
              jq `
              k3d `
              kind `
              kops `
              kubeadm `
              kubectl `
              kubectx `
              kubens `
              latex `
              less `
              mdcat `
              nano `
              netcat `
              nvm `
              openssl `
              pandoc `
              powersession `
              pyenv `
              python `
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
              vimtutor `
              wget `
              which

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

# Create common directories
###################################################
mkdir -Force ~/code
