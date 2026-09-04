"""Bind successful build, exact source inventory, PDF checks and visual evidence."""
import csv
import hashlib
import json
import re
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
LOCALE = ROOT/'repo/locale/tr'


def sha(path):
    with path.open('rb') as stream:
        return hashlib.file_digest(stream, 'sha256').hexdigest()


def read(name):
    return json.loads((HERE/name).read_text(encoding='utf-8-sig'))


def main():
    build = read('open-logic-all722-BUILD.json')
    assert build['status'] == 'BUILT_REQUIRES_PDF_QA' and build['exit_code'] == 0
    assert build['acquired'] and build['mutex_name'] == r'Global\InterlanguageTeXSlotV1'
    for relative, expected_sha in build['input_sha256'].items():
        assert sha(ROOT/relative) == expected_sha, relative
    for key in ['undefined_control_sequences', 'missing_characters',
                'undefined_references', 'undefined_citations', 'duplicate_labels']:
        assert build['diagnostics'][key] == 0, key
    manifest = read('SOURCE_IMPORT_MANIFEST.json')
    assert sha(ROOT/'control/CLOSURE_0722.csv') == manifest['closure_sha256']
    expected = {f'OLP-{number:04d}' for number in range(1, 723)}
    extra = {f'OLP-{number:04d}' for number in range(643, 723)}
    assert {m['id'] for m in manifest['modules']} == expected
    for module in manifest['modules']:
        assert sha(ROOT/'repo'/module['target_path']) == module['target_sha256']
        assert sha(ROOT/'repo'/module['overlay_path']) == module['overlay_sha256']
        assert module['body_round_trip_verified']
    with (LOCALE/'open-logic-all722.modules.csv').open(encoding='utf-8', newline='') as stream:
        rows = list(csv.DictReader(stream))
    assert rows and all(None not in row and all(v is not None for v in row.values()) for row in rows)
    includes = {row['id'] for row in rows if row['event'] == 'include'}
    anchors = {row['id'] for row in rows if row['event'] == 'anchor'}
    assert includes == expected and anchors == extra
    recorder = (LOCALE/'open-logic-all722.fls').read_text(encoding='utf-8', errors='replace')
    actual_inputs = set(re.findall(r'all722-content[/\\](OLP-\d{4})\.tex', recorder))
    assert actual_inputs == expected
    pdf = read('PDF_QA.json')
    visual = read('VISUAL_QA.json')
    digest = sha(LOCALE/'open-logic-all722.pdf')
    assert build['pdf']['sha256'] == pdf['pdf_sha256'] == visual['pdf_sha256'] == digest
    assert pdf['status'] == 'PASS_TEXT_AND_LINKS_REQUIRES_VISUAL_QA'
    assert visual['status'] == 'PASS' and visual['inspected_pages']
    assert len(pdf['extra80']) == 80
    result = {
        'schema_version': 'turkish-reader722-final-qa-v1', 'status': 'PASS',
        'included_modules': len(includes), 'supplemental_modules': len(anchors),
        'pdf_file': 'open-logic-all722.pdf', 'pdf_sha256': digest,
        'pdf_bytes': (LOCALE/'open-logic-all722.pdf').stat().st_size,
        'pages': pdf['pages'], 'bookmarks': pdf['bookmarks'],
        'internal_links': pdf['internal_links'], 'broken_internal_links': 0,
        'original_source_hashes_verified': 722, 'original_body_roundtrips_verified': 722,
        'closure_sha256': manifest['closure_sha256'],
        'source_import_manifest_sha256': sha(HERE/'SOURCE_IMPORT_MANIFEST.json'),
        'runtime_csv_sha256': sha(LOCALE/'open-logic-all722.modules.csv'),
        'recorder_sha256': sha(LOCALE/'open-logic-all722.fls'),
        'build_log_sha256': build['log_sha256'],
        'build_mutex': build['mutex_name'], 'build_exit_code': build['exit_code'],
        'build_input_sha256': build['input_sha256'],
        'build_diagnostics': build['diagnostics'],
        'visual_qa_sha256': sha(HERE/'VISUAL_QA.json'),
        'pdf_qa_sha256': sha(HERE/'PDF_QA.json'),
        'parser_warning_disposition_sha256': sha(HERE/'PDF_PARSER_WARNING_DISPOSITION.md'),
        'parser_warning_disposition': 'Three inherited duplicate transparency-group dictionaries are limited to title-page logos; successful parsing and visual rendering are documented separately.',
        'retained_label_events': [row for row in rows if row['event'] == 'retained-existing-label'],
        'claim_boundary': 'Reader inclusion, source preservation and PDF rendering. This is not a new linguistic validation or a completion of proofs unfinished in the frozen source.'
    }
    (HERE/'FINAL_QA.json').write_text(json.dumps(result, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    print(json.dumps(result))


if __name__ == '__main__':
    main()
