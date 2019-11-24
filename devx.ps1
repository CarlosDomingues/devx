# Requires -Version 5

# remote execution:
#   Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://devx.carlo.sh')
echo "Configuring Windows 10 and installing neat programs for software development. Heads up: this script will ask for administrative permissions a few times."

# Installs Scoop and aria2 for faster downloads.
# Scoop is a package manager for Windows.
# Packages are installed under ~/scoop
###################################################
function Install-Scoop
{
  Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
  scoop install aria2 
  
}

# Installs tools commonly present in most 
# Linux distributions.
###################################################
function Install-LinuxTools
{
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
}

# Installs programming languages and related
# tools.
###################################################
function Install-DeveloperTools
{
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
}

# Installs cloud infrastructure related tools,
# languages and frameworks.
###################################################
function Install-InfraTools
{
  scoop install aws `
                consul `
                nomad `
                packer `
                terraform `
                terragrunt `
                vault
}

# Configure Windows Explorer to show file
# extension, hidden files and disable 
# path limits.
###################################################
function Set-ExplorerConfiguration
{
  $key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
  Set-ItemProperty $key Hidden 1
  Set-ItemProperty $key HideFileExt 0
  Set-ItemProperty $key ShowSuperHidden 1
  Stop-Process -processname explorer
  sudo Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1
}

# Install-Scoop
# Install-LinuxTools
# Install-DevTools
# Install-InfraTools
# Set-ExplorerConfiguration


