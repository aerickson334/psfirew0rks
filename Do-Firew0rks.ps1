#! /usr/bin/pwsh

[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [string]
    [ValidateSet('fireworks', 'fireplace', 'rick_ascii')]
    $Animation = 'fireworks',
    [Parameter(Mandatory = $false)]
    [int]
    $Loops = 20
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path (Join-Path $PSScriptRoot $Animation))) {
    throw "Animation '$Animation' not found"
}

$textFiles = Get-ChildItem -Path (Join-Path $PSScriptRoot $Animation) -Filter '*.txt' | Sort-Object { [int]$_.Name.Replace('.txt', '') } | Get-Content -Raw

if ($textFiles.Count -eq 0) {
    throw "No text art files found in '$Animation'"
}

Clear-Host

$esc = [char]27
$setCursorTop = "$esc[0;0H"

$i = 0
$first = $true
while ($i -lt $Loops -or $Loops -eq -1) {
    foreach ($frame in $textFiles) {

        if (-not $first) {
            Write-Host $setCursorTop -NoNewline
        }
        Write-Host $frame -NoNewline
        $first = $false
        Start-Sleep -Milliseconds 50
    }
    $i++
}



