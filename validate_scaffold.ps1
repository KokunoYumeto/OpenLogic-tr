$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$errors = [System.Collections.Generic.List[string]]::new()
$expectedCount = 722
$expectedConceptDoi = '10.5281/zenodo.21921844'
$expectedVersionDoi = '10.5281/zenodo.21927145'
$expectedCommit = '9620cc73f9c8e0ad003c514a5d3748f29611c4c0'
$readerRelative = 'reader\00_OPENLOGIC_tr_COMPLETE_LINKED_READER_OLP-0722.pdf'

$required = @(
    'README.md',
    'CITATION.cff',
    '.zenodo.json',
    'LICENSE',
    'source\README.txt',
    'source\TURKISH.md',
    $readerRelative,
    'reader\README.txt',
    'source\locale\tr\README.md',
    'source\locale\tr\open-logic-complete.tex',
    'source\locale\tr\open-logic-config.sty',
    'source\locale\tr\open-logic-locale.sty',
    'source\locale\tr\include\open-logic-part.tex',
    'source\locale\tr\include\open-logic-chapter.tex',
    'source\locale\tr\include\open-logic-section.tex',
    'source\locale\tr\SOURCE_ADVERSE_0722.md',
    'source\locale\tr\TERMINOLOGY.csv',
    'source\locale\tr\TRANSLATION_MANIFEST.csv',
    'source\locale\tr\TARGET_SHA256SUMS.txt',
    'evidence\SOURCE_AUTHORITY.json',
    'evidence\QA_STATE.json',
    'evidence\UNRESOLVED_ITEMS.tsv',
    'evidence\DATACITE_RELATIONS.json',
    'evidence\PROVENANCE_GRAPH.json',
    'evidence\DEPENDENCY_TREE.json',
    'evidence\DOI_IDENTITY.json',
    'evidence\GITHUB_RELEASE.json',
    'evidence\COMPONENT_COVERAGE.tsv',
    'build\BUILD.ps1'
)

foreach ($relative in $required) {
    if (-not (Test-Path -LiteralPath (Join-Path $root $relative) -PathType Leaf)) {
        $errors.Add("MISSING $relative")
    }
}

$jsonObjects = @{}
$jsonFiles = @(
    '.zenodo.json',
    'evidence\SOURCE_AUTHORITY.json',
    'evidence\QA_STATE.json',
    'evidence\DATACITE_RELATIONS.json',
    'evidence\PROVENANCE_GRAPH.json',
    'evidence\DEPENDENCY_TREE.json',
    'evidence\DOI_IDENTITY.json',
    'evidence\GITHUB_RELEASE.json'
)
foreach ($relative in $jsonFiles) {
    $path = Join-Path $root $relative
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { continue }
    try { $jsonObjects[$relative] = Get-Content -LiteralPath $path -Raw | ConvertFrom-Json }
    catch { $errors.Add("INVALID_JSON $relative") }
}

$manifestPath = Join-Path $root 'source\locale\tr\TRANSLATION_MANIFEST.csv'
if (Test-Path -LiteralPath $manifestPath -PathType Leaf) {
    $manifest = @(Import-Csv -LiteralPath $manifestPath)
    if ($manifest.Count -ne $expectedCount) {
        $errors.Add("TARGET_COUNT expected=$expectedCount observed=$($manifest.Count)")
    }
    $expectedIds = 1..$expectedCount | ForEach-Object { 'OLP-{0:D4}' -f $_ }
    for ($index = 0; $index -lt $manifest.Count; $index++) {
        $row = $manifest[$index]
        if ($index -lt $expectedIds.Count -and $row.closure_id -cne $expectedIds[$index]) {
            $errors.Add("TARGET_ORDER row=$($index + 1) observed=$($row.closure_id)")
        }
        $relative = ([string]$row.target_path) -replace '^locale/tr/', ''
        $target = Join-Path (Join-Path $root 'source\locale\tr') ($relative -replace '/', '\')
        if (-not (Test-Path -LiteralPath $target -PathType Leaf)) {
            $errors.Add("TARGET_MISSING $($row.closure_id) $relative")
            continue
        }
        $observed = (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash.ToLowerInvariant()
        if ($observed -cne ([string]$row.target_sha256).ToLowerInvariant()) {
            $errors.Add("TARGET_HASH_MISMATCH $($row.closure_id) $relative")
        }
    }
}

$contentRoot = Join-Path $root 'source\locale\tr\content'
if (Test-Path -LiteralPath $contentRoot -PathType Container) {
    $contentCount = @(Get-ChildItem -LiteralPath $contentRoot -Recurse -File -Filter '*.tex').Count
    if ($contentCount -ne $expectedCount) {
        $errors.Add("CONTENT_TEX_COUNT expected=$expectedCount observed=$contentCount")
    }
}

if ($jsonObjects.ContainsKey('evidence\QA_STATE.json')) {
    $qa = $jsonObjects['evidence\QA_STATE.json']
    if ([bool]$qa.release_closed -ne $true) { $errors.Add('QA_RELEASE_NOT_CLOSED') }
    if ([string]$qa.version -cne 'OLP-0722-20260814') { $errors.Add('QA_VERSION_MISMATCH') }
    $reader = Join-Path $root $readerRelative
    if (Test-Path -LiteralPath $reader -PathType Leaf) {
        $readerItem = Get-Item -LiteralPath $reader
        $readerHash = (Get-FileHash -LiteralPath $reader -Algorithm SHA256).Hash
        if ([int64]$qa.reader_bytes -ne $readerItem.Length) { $errors.Add('QA_READER_BYTES_MISMATCH') }
        if ([string]$qa.reader_sha256 -ine $readerHash) { $errors.Add('QA_READER_HASH_MISMATCH') }
        if ([int]$qa.reader_pages -lt 1) { $errors.Add('QA_READER_PAGE_COUNT_INVALID') }
    }
}

if ($jsonObjects.ContainsKey('evidence\DOI_IDENTITY.json')) {
    $doi = $jsonObjects['evidence\DOI_IDENTITY.json']
    if ([string]$doi.language_concept_doi -cne $expectedConceptDoi) { $errors.Add('CONCEPT_DOI_MISMATCH') }
    if ([string]$doi.exact_version_doi -cne $expectedVersionDoi) { $errors.Add('VERSION_DOI_MISMATCH') }
    if ([string]$doi.zenodo_record_id -cne '21927145') { $errors.Add('ZENODO_RECORD_MISMATCH') }
}

if ($jsonObjects.ContainsKey('evidence\SOURCE_AUTHORITY.json')) {
    $authority = $jsonObjects['evidence\SOURCE_AUTHORITY.json']
    if ([string]$authority.original_or_source_edition -notmatch [regex]::Escape($expectedCommit)) {
        $errors.Add('SOURCE_COMMIT_MISMATCH')
    }
    if ([int]$authority.source_content_files -ne $expectedCount) { $errors.Add('SOURCE_COUNT_MISMATCH') }
}

if ($jsonObjects.ContainsKey('evidence\DATACITE_RELATIONS.json')) {
    $relations = $jsonObjects['evidence\DATACITE_RELATIONS.json']
    if (-not [string]::IsNullOrWhiteSpace([string]$relations.global_collection_concept_doi)) {
        $errors.Add('INVENTED_GLOBAL_HUB_DOI')
    }
    $activeHub = @($relations.relations | Where-Object { $_.relationType -in @('IsPartOf', 'HasPart') })
    if ($activeHub.Count -gt 0) { $errors.Add('UNSUPPORTED_ACTIVE_HUB_RELATION') }
}

$surfaceFiles = @('README.md', 'CITATION.cff', '.zenodo.json')
$surfaceText = ($surfaceFiles | ForEach-Object { Get-Content -LiteralPath (Join-Path $root $_) -Raw }) -join "`n"
foreach ($requiredText in @('OLP-0722', '722/722', $expectedConceptDoi, $expectedVersionDoi, $expectedCommit, 'Complete Turkish Edition', 'OpenAI 5.6 Sol, Ultra mode')) {
    if ($surfaceText.IndexOf($requiredText, [StringComparison]::OrdinalIgnoreCase) -lt 0) {
        $errors.Add("SURFACE_TEXT_MISSING $requiredText")
    }
}
if ($surfaceText -match '(?i)REPLACE_|publication candidate|local checkpoint|\bcumulative\b|Kümülatif') {
    $errors.Add('STALE_OR_PLACEHOLDER_PUBLICATION_SURFACE')
}

$placeholderHits = @(Get-ChildItem -LiteralPath $root -Recurse -File |
    Where-Object { $_.FullName -notmatch '\\.git\\' -and $_.Name -ne 'validate_scaffold.ps1' } |
    Select-String -Pattern 'REPLACE_' -SimpleMatch)
if ($placeholderHits) { $errors.Add("UNRESOLVED_PLACEHOLDERS $($placeholderHits.Count)") }

if ($errors.Count) {
    $errors | ForEach-Object { Write-Error $_ }
    exit 1
}
Write-Output 'PASS: complete Turkish Open Logic standalone surface has 722 exact targets, final reader identity, valid metadata, and no invented global hub relation.'
