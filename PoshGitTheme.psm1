#requires -Version 2 -Modules posh-git

function Write-Theme {
    param(
        [bool]
        $lastCommandFailed,
        [string]
        $with
    )
    # check for elevated prompt
    If (Test-Administrator) {
        $prompt += Write-Prompt -Object "$($sl.PromptSymbols.ElevatedSymbol) " -ForegroundColor $sl.Colors.AdminIconForegroundColor
    }

    # write user
    $user = [System.Environment]::UserName
    if (Test-NotDefaultUser($user)) {
        $prompt += Write-Prompt -Object "[" -ForegroundColor $sl.Colors.SeparatorColor
        $prompt += Write-Prompt -Object "$user" -ForegroundColor $sl.Colors.HostColor
        $prompt += Write-Prompt -Object "]" -ForegroundColor $sl.Colors.SeparatorColor
        # write at (devicename)
        $device = Get-ComputerName
        $prompt += Write-Prompt -Object "@" -ForegroundColor $sl.Colors.SeparatorColor
        $prompt += Write-Prompt -Object "[" -ForegroundColor $sl.Colors.SeparatorColor
        $prompt += Write-Prompt -Object "$device" -ForegroundColor $sl.Colors.HostColor
        $prompt += Write-Prompt -Object "]" -ForegroundColor $sl.Colors.SeparatorColor
        # write in for folder
        $prompt += Write-Prompt -Object ":" -ForegroundColor $sl.Colors.SeparatorColor
    }
    # write folder
    $dir = Get-FullPath -dir $pwd
    $prompt += Write-Prompt -Object "[" -ForegroundColor $sl.Colors.SeparatorColor
    $prompt += Write-Prompt -Object "$dir" -ForegroundColor $sl.Colors.FolderColor
    $prompt += Write-Prompt -Object "] " -ForegroundColor $sl.Colors.SeparatorColor
    # write on (git:branchname status)
    $status = Get-VCSStatus
    if ($status) {
        $prompt += Write-Prompt -Object $sl.PromptSymbols.Arrow -ForegroundColor $sl.Colors.FirstArrow
        $prompt += Write-Prompt -Object $sl.PromptSymbols.Arrow -ForegroundColor $sl.Colors.SecondArrow
        $prompt += Write-Prompt -Object $sl.PromptSymbols.Arrow -ForegroundColor $sl.Colors.ThirdArrow
        $themeInfo = Get-VcsInfo -status ($status)
        $prompt += Write-Prompt -Object " [" -ForegroundColor $sl.Colors.SeparatorColor
        $prompt += Write-Prompt -Object "$($themeInfo.VcInfo)" -ForegroundColor $sl.Colors.GitDefaultColor
        $prompt += Write-Prompt -Object "]" -ForegroundColor $sl.Colors.SeparatorColor
    }
    # write virtualenv
    if (Test-VirtualEnv) {
        $prompt += Write-Prompt -Object 'inside env:' -ForegroundColor $sl.Colors.PromptForegroundColor
        $prompt += Write-Prompt -Object "$(Get-VirtualEnvName) " -ForegroundColor $themeInfo.VirtualEnvForegroundColor
    }
    # write [time]
    $timeStamp = Get-Date -Format T
    $prompt += Write-Prompt " [$timeStamp]" -ForegroundColor $sl.Colors.PromptForegroundColor

    # check the last command state and indicate if failed
    $foregroundColor = $sl.Colors.PromptHighlightColor
    If ($lastCommandFailed) {
        $foregroundColor = $sl.Colors.CommandFailedIconForegroundColor
    }

    if ($with) {
        $prompt += Write-Prompt -Object "$($with.ToUpper()) " -BackgroundColor $sl.Colors.WithBackgroundColor -ForegroundColor $sl.Colors.WithForegroundColor
    }

    $prompt += Set-Newline
    $prompt += Write-Prompt -Object $sl.PromptSymbols.PromptIndicator -ForegroundColor $foregroundColor
    $prompt += ' '
    $prompt
}

function Get-TimeSinceLastCommit {
    return (git log --pretty=format:'%cr' -1)
}

$sl = $global:ThemeSettings #local settings
$sl.PromptSymbols.StartSymbol = ''
$sl.PromptSymbols.PromptIndicator = [char]::ConvertFromUtf32(0x03BB)
$sl.PromptSymbols.Arrow = [char]::ConvertFromUtf32(0x276F)
$sl.Colors.PromptForegroundColor = [ConsoleColor]::White
$sl.Colors.PromptHighlightColor = [ConsoleColor]::Gray
$sl.Colors.WithForegroundColor = [ConsoleColor]::DarkRed
$sl.Colors.WithBackgroundColor = [ConsoleColor]::Red
$sl.Colors.VirtualEnvForegroundColor = [ConsoleColor]::Red
$sl.Colors.GitDefaultColor = [ConsoleColor]::DarkCyan
$sl.Colors.FolderColor = [ConsoleColor]::DarkYellow
$sl.Colors.HostColor = [ConsoleColor]::Green
$sl.Colors.SeparatorColor = [ConsoleColor]::Gray
$sl.Colors.FirstArrow = [ConsoleColor]::Green
$sl.Colors.SecondArrow = [ConsoleColor]::DarkBlue
$sl.Colors.ThirdArrow = [ConsoleColor]::DarkCyan
