"""Read-only PDF inspection; writes a compact QA receipt when invoked."""
from __future__ import annotations
import argparse
import hashlib
import json
import re
from collections import defaultdict
from pathlib import Path
from pypdf import PdfReader


def sha(path: Path) -> str:
    with path.open('rb') as stream:
        return hashlib.file_digest(stream, 'sha256').hexdigest()


def inspect(pdf: Path) -> dict:
    reader = PdfReader(pdf)
    bookmarks = []

    def walk(items):
        for item in items:
            if isinstance(item, list):
                walk(item)
            else:
                bookmarks.append({'title': item.title, 'page': reader.get_destination_page_number(item) + 1})

    walk(reader.outline)
    unresolved_locale_bookmarks = [item for item in bookmarks if re.fullmatch(r'\s*tr\s*', item['title'], re.I)]
    id_pages = defaultdict(list)
    text_errors = []
    texts = []
    bad_patterns = {
        'undefined_reference_marker': re.compile(r'\?\?'),
        'unexpanded_text_token': re.compile(r'!!'),
        'replacement_character': re.compile('\ufffd'),
        'visible_tex_command': re.compile(r'\\(?:begin|end|frac|olref|olfileid|lforall|lexists)\b'),
    }
    chars = 0
    for index, page in enumerate(reader.pages, 1):
        value = page.extract_text() or ''
        texts.append(value)
        chars += len(value)
        normalized = re.sub(r'[\u200e\u200f\u202a-\u202e\u2066-\u2069]', '', value)
        for match in re.finditer(r'OLP\s*[-\u2010-\u2013]\s*(\d{4})', normalized):
            number = int(match[1])
            if index not in id_pages[number]:
                id_pages[number].append(index)
        for kind, pattern in bad_patterns.items():
            for match in pattern.finditer(value):
                text_errors.append({'page': index, 'kind': kind, 'context': value[max(0, match.start()-60):match.end()+90]})
        if index % 200 == 0:
            print(json.dumps({'progress_pages': index, 'total': len(reader.pages)}), flush=True)

    named = reader.named_destinations
    page_refs = {page.indirect_reference.idnum for page in reader.pages if page.indirect_reference}
    internal_links = 0
    broken_links = []
    for page_number, page in enumerate(reader.pages, 1):
        for ref in page.get('/Annots', []):
            annotation = ref.get_object()
            action = annotation.get('/A', {})
            if hasattr(action, 'get_object'):
                action = action.get_object()
            destination = annotation.get('/Dest')
            if action.get('/S') == '/GoTo':
                destination = action.get('/D')
            if destination is None:
                continue
            internal_links += 1
            if isinstance(destination, str):
                if destination not in named:
                    broken_links.append({'page': page_number, 'destination': destination})
            elif isinstance(destination, list) and destination:
                target = destination[0]
                if hasattr(target, 'idnum') and target.idnum not in page_refs:
                    broken_links.append({'page': page_number, 'destination': 'non-page indirect reference'})

    extra_bookmarks = {}
    for item in bookmarks:
        match = re.search(r'OLP\s*-\s*(\d{4})', item['title'])
        if match and 643 <= int(match[1]) <= 722:
            extra_bookmarks.setdefault(int(match[1]), []).append(item)
    extra = []
    for number in range(643, 723):
        extra.append({'id': f'OLP-{number:04d}', 'text_pages': id_pages.get(number, []),
                      'bookmarks': extra_bookmarks.get(number, [])})
    missing = [row['id'] for row in extra if not row['text_pages']]
    missing_bookmarks = [row['id'] for row in extra if not row['bookmarks']]
    misplaced_bookmarks = [row['id'] for row in extra if row['bookmarks'] and
                           not any(mark['page'] in row['text_pages'] for mark in row['bookmarks'])]
    result = {
        'schema_version': 'turkish-reader722-pdf-qa-v1',
        'pdf_file': pdf.name, 'pdf_bytes': pdf.stat().st_size, 'pdf_sha256': sha(pdf),
        'pages': len(reader.pages), 'encrypted': reader.is_encrypted,
        'text_characters': chars, 'bookmarks': len(bookmarks), 'internal_links': internal_links,
        'named_destinations': len(named), 'broken_internal_links': broken_links,
        'text_scan_findings': text_errors, 'extra80': extra, 'missing_extra80_text_ids': missing,
        'missing_extra80_bookmarks': missing_bookmarks,
        'extra80_bookmark_body_page_mismatches': misplaced_bookmarks,
        'unresolved_locale_bookmarks': unresolved_locale_bookmarks,
        'status': 'PASS_TEXT_AND_LINKS_REQUIRES_VISUAL_QA' if not (missing or missing_bookmarks or misplaced_bookmarks or unresolved_locale_bookmarks or broken_links or text_errors) else 'REQUIRES_CORRECTION_OR_EXPLICIT_SOURCE_DISPOSITION',
        'claim_boundary': 'Text/link/inventory inspection, not linguistic-quality or visual-layout certification.'
    }
    return result


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('pdf', type=Path)
    parser.add_argument('receipt', type=Path)
    args = parser.parse_args()
    result = inspect(args.pdf)
    args.receipt.write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps({key: result[key] for key in ('status', 'pages', 'pdf_sha256', 'bookmarks', 'internal_links', 'missing_extra80_text_ids')}))
    print(json.dumps({'text_scan_findings': len(result['text_scan_findings']), 'broken_links': len(result['broken_internal_links'])}))


if __name__ == '__main__':
    main()
