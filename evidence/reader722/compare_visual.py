"""Compare actual rendered pixels to a visually inspected reader candidate."""
import argparse
import hashlib
import json
from pathlib import Path
from PIL import Image


def pixels(path):
    with Image.open(path) as image:
        image = image.convert('RGB')
        return list(image.size), hashlib.sha256(image.tobytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('baseline', type=Path)
    parser.add_argument('current', type=Path)
    parser.add_argument('receipt', type=Path)
    args = parser.parse_args()
    old_inventory = json.loads((args.baseline/'RENDER_INVENTORY.json').read_text())
    new_inventory = json.loads((args.current/'RENDER_INVENTORY.json').read_text())
    old = {int(path.stem.split('-')[-1]): path for path in args.baseline.glob('page-*.png')}
    current = {int(path.stem.split('-')[-1]): path for path in args.current.glob('page-*.png')}
    unchanged, changed, added = [], [], []
    rows = []
    for page, path in sorted(current.items()):
        size, digest = pixels(path)
        previous = pixels(old[page]) if page in old else None
        same = previous == (size, digest)
        if same:
            unchanged.append(page)
        elif page in old:
            changed.append(page)
        else:
            added.append(page)
        rows.append({'page': page, 'size': size, 'pixel_sha256': digest,
                     'identical_to_inspected_candidate': same})
    report = {'status': 'PIXEL_COMPARISON_REQUIRES_CHANGED_PAGE_INSPECTION',
              'baseline_pdf_sha256': old_inventory['pdf_sha256'],
              'current_pdf_sha256': new_inventory['pdf_sha256'],
              'unchanged_pages': unchanged, 'changed_pages': changed,
              'new_pages': added, 'pages': rows}
    args.receipt.write_text(json.dumps(report, indent=2)+'\n', encoding='utf-8')
    print(json.dumps({k:v for k,v in report.items() if k != 'pages'}))


if __name__ == '__main__':
    main()
