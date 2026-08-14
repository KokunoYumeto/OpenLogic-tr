[CmdletBinding()]
param(
    [string]$WorkDirectory = '',
    [string]$OutputDirectory = ''
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$authority = '9620cc73f9c8e0ad003c514a5d3748f29611c4c0'
$repoRoot = Split-Path -Parent $PSScriptRoot
$localeSource = Join-Path $repoRoot 'source\locale\tr'

if (-not $WorkDirectory) {
    $WorkDirectory = Join-Path ([IO.Path]::GetTempPath()) ('openlogic-tr-' + [guid]::NewGuid().ToString('N'))
}
if (-not $OutputDirectory) {
    $OutputDirectory = Join-Path $repoRoot 'output'
}

New-Item -ItemType Directory -Path $WorkDirectory -Force | Out-Null
New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null

$checkout = Join-Path $WorkDirectory 'OpenLogic'
if (Test-Path -LiteralPath $checkout) {
    throw "Refusing to overwrite existing checkout: $checkout"
}

git clone --filter=blob:none --no-checkout https://github.com/OpenLogicProject/OpenLogic.git $checkout
if ($LASTEXITCODE -ne 0) { throw 'git clone failed' }
git -C $checkout checkout --detach $authority
if ($LASTEXITCODE -ne 0) { throw 'authority checkout failed' }

$observed = (git -C $checkout rev-parse HEAD).Trim()
if ($observed -cne $authority) { throw "authority mismatch: $observed" }

$targetLocale = Join-Path $checkout 'locale\tr'
New-Item -ItemType Directory -Path $targetLocale -Force | Out-Null
Copy-Item -Path (Join-Path $localeSource '*') -Destination $targetLocale -Recurse -Force

Push-Location $targetLocale
try {
    latexmk -pdf -interaction=nonstopmode -halt-on-error -file-line-error open-logic-complete.tex
    if ($LASTEXITCODE -ne 0) { throw 'latexmk failed' }
    Copy-Item -LiteralPath 'open-logic-complete.pdf' -Destination (Join-Path $OutputDirectory '00_OPENLOGIC_tr_COMPLETE_LINKED_READER_OLP-0722.pdf') -Force
} finally {
    Pop-Location
}

$pdf = Join-Path $OutputDirectory '00_OPENLOGIC_tr_COMPLETE_LINKED_READER_OLP-0722.pdf'
$hash = (Get-FileHash -LiteralPath $pdf -Algorithm SHA256).Hash
Write-Output "Built $pdf"
Write-Output "SHA-256 $hash"
