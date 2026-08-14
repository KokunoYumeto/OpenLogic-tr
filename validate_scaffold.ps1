$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$errors = [System.Collections.Generic.List[string]]::new()
$expectedCount = 722
$expectedConceptDoi = '10.5281/zenodo.21921844'
$expectedVersionDoi = '10.5281/zenodo.21927145'
$expectedCommit = '9620cc73f9c8e0ad003c514a5d3748f29611c4c0'
$expectedClosureBytes = 1058824
$expectedClosureSha = '4F0DFAA58C38B54C00180DE30AE09507D0DF9FBEA1E0ED6729DB7E2FA77AAC2F'
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
    'evidence\CLOSURE_0722.csv',
    'evidence\ARTIFACT_SHA256.tsv',
    'evidence\REVIEW_0722.md',
    'evidence\SOURCE_ADVERSE_0722.md',
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

$closurePath = Join-Path $root 'evidence\CLOSURE_0722.csv'
$closure = @()
if (Test-Path -LiteralPath $closurePath -PathType Leaf) {
    $closureItem = Get-Item -LiteralPath $closurePath
    $closureHash = (Get-FileHash -LiteralPath $closurePath -Algorithm SHA256).Hash
    if ($closureItem.Length -ne $expectedClosureBytes) { $errors.Add('CLOSURE_BYTES_MISMATCH') }
    if ($closureHash -ine $expectedClosureSha) { $errors.Add('CLOSURE_HASH_MISMATCH') }
    $closure = @(Import-Csv -LiteralPath $closurePath)
    if ($closure.Count -ne $expectedCount) { $errors.Add("CLOSURE_COUNT expected=$expectedCount observed=$($closure.Count)") }
    foreach ($row in $closure) {
        if ([string]$row.qa_structural -cne 'PASS_AGGREGATE_CORPUS') { $errors.Add("CLOSURE_STRUCTURAL_STATE $($row.closure_id)") }
        if ([string]$row.qa_semantic -cne 'ADMITTED_AGGREGATE_MODEL_REVIEW') { $errors.Add("CLOSURE_SEMANTIC_STATE $($row.closure_id)") }
        $readerReachable = [string]$row.canonical_reader_reachable -match '^(?i:true)$'
        $expectedBuild = if ($readerReachable) { 'PASS_AGGREGATE_COMPLETE_READER' } else { 'NOT_APPLICABLE_RETAINED_NONREADER' }
        $expectedRender = if ($readerReachable) { 'CLEAN_AGGREGATE_COMPLETE_READER' } else { 'NOT_APPLICABLE_RETAINED_NONREADER' }
        if ([string]$row.qa_build -cne $expectedBuild) { $errors.Add("CLOSURE_BUILD_STATE $($row.closure_id)") }
        if ([string]$row.qa_render -cne $expectedRender) { $errors.Add("CLOSURE_RENDER_STATE $($row.closure_id)") }
        if ([string]$row.review_metadata -notlike '*REVIEW_0722.md*' -or [string]$row.review_metadata -notlike '*COMPLETE_0722_STRUCTURAL_QA.json*') {
            $errors.Add("CLOSURE_REVIEW_METADATA $($row.closure_id)")
        }
        if ([string]$row.next_action -notlike 'No further translation or QA action;*') { $errors.Add("CLOSURE_NEXT_ACTION $($row.closure_id)") }
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
        if ($index -lt $closure.Count) {
            $closureRow = $closure[$index]
            if ([string]$closureRow.closure_id -cne [string]$row.closure_id -or
                [string]$closureRow.target_path -cne [string]$row.target_path -or
                [string]$closureRow.target_sha256 -cne [string]$row.target_sha256 -or
                [string]$closureRow.target_bytes -cne [string]$row.target_bytes) {
                $errors.Add("CLOSURE_MANIFEST_MISMATCH $($row.closure_id)")
            }
            if ([string]$row.structural_qa -cne 'PASS') {
                $errors.Add("MANIFEST_STRUCTURAL_STATE $($row.closure_id)")
            }
            if ([string]$row.semantic_qa -cne [string]$closureRow.qa_semantic) {
                $errors.Add("MANIFEST_SEMANTIC_STATE $($row.closure_id)")
            }
            if ([string]$row.build_qa -cne [string]$closureRow.qa_build) {
                $errors.Add("MANIFEST_BUILD_STATE $($row.closure_id)")
            }
            if ([string]$row.render_qa -cne [string]$closureRow.qa_render) {
                $errors.Add("MANIFEST_RENDER_STATE $($row.closure_id)")
            }
            if ([string]$row.native_review -cne 'NOT_REQUIRED') {
                $errors.Add("MANIFEST_NATIVE_REVIEW_STATE $($row.closure_id)")
            }
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
    if ([int64]$qa.source_replay.closure_bytes -ne $expectedClosureBytes) { $errors.Add('QA_CLOSURE_BYTES_MISMATCH') }
    if ([string]$qa.source_replay.closure_sha256 -ine $expectedClosureSha) { $errors.Add('QA_CLOSURE_HASH_MISMATCH') }
    if ([string]$qa.local_package.status -cne 'COMPLETE_LOCAL') { $errors.Add('QA_LOCAL_PACKAGE_NOT_COMPLETE') }
    if ([string]$qa.local_package.editable_sources_zip.identity -cne 'EXTERNAL_MANIFEST') { $errors.Add('QA_SOURCE_ZIP_IDENTITY_NOT_EXTERNAL') }
    if ([string]$qa.local_package.evidence_and_provenance_zip.identity -cne 'EXTERNAL_MANIFEST') { $errors.Add('QA_EVIDENCE_ZIP_IDENTITY_NOT_EXTERNAL') }
    if ([bool]$qa.external_publication_complete -ne $false) { $errors.Add('QA_EXTERNAL_PUBLICATION_OVERCLAIM') }
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
    if ([string]$doi.publication_status -notmatch '(?i)local four-asset package complete') { $errors.Add('DOI_LOCAL_PACKAGE_STATE_STALE') }
    if ([string]$doi.publication_status -notmatch '(?i)GitHub release exists') { $errors.Add('DOI_GITHUB_STATE_STALE') }
    if ([string]$doi.publication_status -notmatch '(?i)Zenodo files absent') { $errors.Add('DOI_ZENODO_STATE_STALE') }
}

if ($jsonObjects.ContainsKey('evidence\SOURCE_AUTHORITY.json')) {
    $authority = $jsonObjects['evidence\SOURCE_AUTHORITY.json']
    if ([string]$authority.original_or_source_edition -notmatch [regex]::Escape($expectedCommit)) {
        $errors.Add('SOURCE_COMMIT_MISMATCH')
    }
    if ([int]$authority.source_content_files -ne $expectedCount) { $errors.Add('SOURCE_COUNT_MISMATCH') }
    if ([int64]$authority.source_closure_manifest_bytes -ne $expectedClosureBytes) { $errors.Add('AUTHORITY_CLOSURE_BYTES_MISMATCH') }
    if ([string]$authority.source_closure_manifest_sha256 -ine $expectedClosureSha) { $errors.Add('AUTHORITY_CLOSURE_HASH_MISMATCH') }
    if ([string]$authority.publication_state -notmatch '(?i)complete local four-asset package') { $errors.Add('AUTHORITY_PACKAGE_STATE_STALE') }
}

if ($jsonObjects.ContainsKey('evidence\GITHUB_RELEASE.json')) {
    $github = $jsonObjects['evidence\GITHUB_RELEASE.json']
    if ([bool]$github.release_exists_publicly -ne $true) { $errors.Add('GITHUB_RELEASE_EXISTENCE_STALE') }
    if ([string]$github.public_asset_state -notmatch '(?i)superseded') { $errors.Add('GITHUB_ASSET_STATE_STALE') }
    if ([bool]$github.corrective_asset_replacement_complete -ne $false) { $errors.Add('GITHUB_REPLACEMENT_OVERCLAIM') }
    if ([bool]$github.readback_verified -ne $false) { $errors.Add('GITHUB_READBACK_OVERCLAIM') }
}

if ($jsonObjects.ContainsKey('evidence\DATACITE_RELATIONS.json')) {
    $relations = $jsonObjects['evidence\DATACITE_RELATIONS.json']
    if (-not [string]::IsNullOrWhiteSpace([string]$relations.global_collection_concept_doi)) {
        $errors.Add('INVENTED_GLOBAL_HUB_DOI')
    }
    $activeHub = @($relations.relations | Where-Object { $_.relationType -in @('IsPartOf', 'HasPart') })
    if ($activeHub.Count -gt 0) { $errors.Add('UNSUPPORTED_ACTIVE_HUB_RELATION') }
}

$artifactPath = Join-Path $root 'evidence\ARTIFACT_SHA256.tsv'
if (Test-Path -LiteralPath $artifactPath -PathType Leaf) {
    $artifactRows = @(Import-Csv -LiteralPath $artifactPath -Delimiter ([char]9))
    $outerNames = @(
        '01_OPENLOGIC_tr_EDITABLE_SOURCES_OLP-0722.zip',
        '02_OPENLOGIC_tr_EVIDENCE_AND_PROVENANCE_OLP-0722.zip',
        '03_OPENLOGIC_tr_SHA256_MANIFEST_OLP-0722.txt'
    )
    foreach ($name in $outerNames) {
        $row = @($artifactRows | Where-Object relative_path -ceq $name)
        if ($row.Count -ne 1) { $errors.Add("ARTIFACT_OUTER_ROW_COUNT $name"); continue }
        if (-not [string]::IsNullOrWhiteSpace([string]$row[0].bytes) -or -not [string]::IsNullOrWhiteSpace([string]$row[0].sha256)) {
            $errors.Add("ARTIFACT_OUTER_IDENTITY_RECURSIVE $name")
        }
        if ([string]$row[0].state -notmatch '^EXTERNAL_MANIFEST:') { $errors.Add("ARTIFACT_OUTER_STATE $name") }
    }
    $closureArtifact = @($artifactRows | Where-Object relative_path -ceq 'source_authority/CLOSURE_0722.csv')
    if ($closureArtifact.Count -ne 1 -or [int64]$closureArtifact[0].bytes -ne $expectedClosureBytes -or [string]$closureArtifact[0].sha256 -ine $expectedClosureSha) {
        $errors.Add('ARTIFACT_CLOSURE_IDENTITY_MISMATCH')
    }
    if (@($artifactRows | Where-Object { [string]$_.state -match '(?i)PENDING|not yet generated' }).Count -gt 0) {
        $errors.Add('ARTIFACT_PENDING_STATE')
    }
}

$unresolvedPath = Join-Path $root 'evidence\UNRESOLVED_ITEMS.tsv'
if (Test-Path -LiteralPath $unresolvedPath -PathType Leaf) {
    $unresolved = @(Import-Csv -LiteralPath $unresolvedPath -Delimiter ([char]9))
    if (@($unresolved | Where-Object item_id -ceq 'PACKAGE-0001').Count -gt 0) { $errors.Add('STALE_PACKAGE_UNRESOLVED_ROW') }
    foreach ($requiredItem in @('GIT-0001', 'ZENODO-0001')) {
        $row = @($unresolved | Where-Object item_id -ceq $requiredItem)
        if ($row.Count -ne 1 -or [string]$row[0].status -cne 'pending_external') { $errors.Add("EXTERNAL_UNRESOLVED_STATE $requiredItem") }
    }
    if (($unresolved | ConvertTo-Csv -NoTypeInformation) -match '(?i)not yet generated|ZIPs? and manifest.*not generated') {
        $errors.Add('STALE_UNRESOLVED_PACKAGE_TEXT')
    }
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

$activeStateFiles = @(
    'README.md',
    'evidence\SOURCE_AUTHORITY.json',
    'evidence\QA_STATE.json',
    'evidence\DOI_IDENTITY.json',
    'evidence\GITHUB_RELEASE.json',
    'evidence\DEPENDENCY_TREE.json',
    'evidence\PROVENANCE_GRAPH.json',
    'evidence\UNRESOLVED_ITEMS.tsv',
    'evidence\ARTIFACT_SHA256.tsv'
)
$activeStateText = ($activeStateFiles | ForEach-Object { Get-Content -LiteralPath (Join-Path $root $_) -Raw }) -join "`n"
if ($activeStateText -match '(?i)2B424C62612499B15AF475E77367A06FF|829,?550|C0CCC44E4E2EEB65|D3A81C36C0A96300|ABCB0B57D9A78980') {
    $errors.Add('SUPERSEDED_ACTIVE_IDENTITY')
}
if ($activeStateText -match '(?i)PACKAGE-0001|local (?:four-file|four-asset) package.{0,80}(?:pending|not yet generated)|ZIPs? and manifest.{0,80}not (?:yet )?generated|planned tag not created|no Git push, release') {
    $errors.Add('STALE_ACTIVE_PACKAGE_OR_GITHUB_STATE')
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
