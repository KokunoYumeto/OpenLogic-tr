[CmdletBinding()]
param(
    [string]$WorkDirectory = '',
    [string]$OutputDirectory = ''
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

# The active entry point builds all 722 modules. The old complete-reader
# import graph reaches only 642 and is intentionally not a fallback here.
$all722Builder = Join-Path $PSScriptRoot 'BUILD_ALL722.ps1'
if (-not (Test-Path -LiteralPath $all722Builder -PathType Leaf)) {
    throw 'The all-722 reader builder is missing. Unpack the original source ZIP and the 04 reader-correction ZIP together.'
}

# BUILD_ALL722.ps1 owns the frozen-source checkout, captured TeX process,
# machine-wide mutex, bounded build, log checks, and output copy.
& $all722Builder -WorkDirectory $WorkDirectory -OutputDirectory $OutputDirectory
