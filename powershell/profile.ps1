#Aliases
function profile { nvim $PROFILE.CurrentUserAllHosts }

function dow { cd ~\Downloads }
function dot { cd ~\dotfiles }
function perforce { cd ~\perforce }

function mv { move $Args }
function cp { copy $Args }
function rm { del $Args }
function which { where $Args }
function man { Get-ConciseHelp $Args }
function py { python.exe $Args }

function lg { lazygit $Args }

function manl { wsl -- man $Args }

Remove-Alias -Name ls -Force
function ls() {
    exa -la @Args
}

function lsg() {
    exa -la --git @Args
}

function export($name, $value) {
    set-item -force -path "env:$name" -value $value;
}

function pkill($name) {
    get-process $name -ErrorAction SilentlyContinue | stop-process
}

function pgrep($name) {
    get-process $name
}

function ln($target, $link) {
    New-Item -ItemType SymbolicLink -Path $link -Value $target
}

function df {
    get-volume
}

function open { explorer.exe $Args }

function touch { New-Item -ItemType file $Args }

# Like a recursive sed
function edit-recursive($filePattern, $find, $replace) {
    $files = get-childitem . "$filePattern" -rec # -Exclude
        write-output $files
        foreach ($file in $files) {
            (Get-Content $file.PSPath) |
                Foreach-Object { $_ -replace "$find", "$replace" } |
                Set-Content $file.PSPath
        }
}

function grep($regex, $dir) {
    if ( $dir ) {
        get-childitem $dir | select-string $regex
            return
    }
    $input | select-string $regex
}

function grepv($regex) {
    $input | where-object { !$_.Contains($regex) }
}

function show-links($dir){
    get-childitem $dir | where-object {$_.LinkType} | select-object FullName,LinkType,Target
}

function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

function reboot {
    shutdown /r /t 0
}

function msvc([ValidateSet('x86','amd64','arm','arm64')]$Arch = 'amd64') {
    $VsWherePath = Join-Path ${env:ProgramFiles(x86)} "\Microsoft Visual Studio\Installer\vswhere.exe"
        $VsPath = & $VsWherePath -products * -latest -property installationPath
        if ($null -eq $VsPath) {
            throw "'vswhere.exe' could not find any MSVC installation."
        }
    Import-Module (Join-Path $VsPath "\Common7\Tools\Microsoft.VisualStudio.DevShell.dll")
        Enter-VsDevShell -Arch $Arch -HostArch amd64 -VsInstallPath $VsPath
}

# Winfetch
winfetch

# Starship
Invoke-Expression (&starship init powershell)

