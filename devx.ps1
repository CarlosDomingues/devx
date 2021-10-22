# Requires -Version 5

# remote execution:
#   Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://devx.carlo.sh')
Write-Host "Configuring Windows 10 and installing neat programs for software development. Heads up: this script will ask for administrative permissions a few times." -ForegroundColor Green

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
scoop install aws-copilot `
              azure-cli `
              aws `
              bind `
              cacert `
              curl `
              coreutils `
              dig `
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
              jq `
              kubectl `
              kubens `
              less `
              mdcat `
              nano `
              netcat `
              nvm `
              openssl `
              pandoc `
              pshazz `
              powersession `
              pyenv `
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
              which

              `
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

# Create ssh keys for Github
###################################################
ssh-keygen -b 2048 -t rsa -f "${HOME}/.ssh/github-${env:COMPUTERNAME}" -q -N '""'
Add-Content ${HOME}/.ssh/config "Host github.com`n  IdentityFile ~/.ssh/github-${env:COMPUTERNAME}"

# Add keys to the ssh agent
###################################################
 sudo Set-Service ssh-agent -StartupType Automatic
 Start-Service ssh-agent
 Get-Service ssh-agent
 ssh-add $HOME/.ssh/gitlab-${env:COMPUTERNAME}
 ssh-add $HOME/.ssh/github-${env:COMPUTERNAME}
 

# Setup WSL 2 + Ubuntu 20.04 LTS
###################################################
sudo Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile ~/Ubuntu2004.zip -UseBasicParsing
Expand-Archive ~/Ubuntu2004.zip ~/Ubuntu2004
 ~/Ubuntu2004/ubuntu2004.exe
 wsl --setdefault Ubuntu-20.04
 ~/Ubuntu2004/ubuntu2004.exe run 'echo \"carlos ALL=(ALL:ALL) NOPASSWD:ALL\" | sudo tee --append /etc/sudoers'
 ~/Ubuntu2004/ubuntu2004.exe run 'sudo apt-get update --yes && sudo apt-get upgrade --yes && mkdir --parents ~/code'
New-Item -ItemType HardLink -Path C:\ProgramData\Microsoft\Windows\Start Menu\Programs -Value ~/Ubuntu2004/ubuntu2004.exe # Not working, fix 


