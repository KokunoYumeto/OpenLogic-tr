$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$errors = [System.Collections.Generic.List[string]]::new()
$required = @(
  'README.md','CITATION.cff','.zenodo.json','LICENSE','source\README.txt','reader\README.txt',
  'evidence\SOURCE_AUTHORITY.json','evidence\QA_STATE.json','evidence\UNRESOLVED_ITEMS.tsv',
  'evidence\ARTIFACT_SHA256.tsv','evidence\DATACITE_RELATIONS.json','build\BUILD.ps1'
)
foreach ($rel in $required) {
  $p = Join-Path $root $rel
  if (-not (Test-Path -LiteralPath $p -PathType Leaf)) { $errors.Add("MISSING $rel") }
}
foreach ($jsonRel in @('.zenodo.json','evidence\SOURCE_AUTHORITY.json','evidence\QA_STATE.json','evidence\DATACITE_RELATIONS.json')) {
  $p = Join-Path $root $jsonRel
  if (Test-Path -LiteralPath $p) {
    try { Get-Content -LiteralPath $p -Raw | ConvertFrom-Json | Out-Null } catch { $errors.Add("INVALID_JSON $jsonRel") }
  }
}
$placeholderHits = Get-ChildItem -LiteralPath $root -Recurse -File | Where-Object Name -ne 'validate_scaffold.ps1' | Select-String -Pattern 'REPLACE_' -SimpleMatch
if ($placeholderHits) { $errors.Add("UNRESOLVED_PLACEHOLDERS $($placeholderHits.Count)") }
if ($errors.Count) { $errors | ForEach-Object { Write-Error $_ }; exit 1 }
Write-Output 'PASS: release scaffold has required files, valid JSON, and no unresolved REPLACE_ placeholders.'
