"""Render changed reader pages and contact sheets; never assigns a visual PASS."""
import argparse
import hashlib
import json
import subprocess
from pathlib import Path
from PIL import Image, ImageDraw


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('pdf', type=Path)
    parser.add_argument('pdf_qa', type=Path)
    parser.add_argument('poppler', type=Path)
    parser.add_argument('output', type=Path)
    args = parser.parse_args()
    qa = json.loads(args.pdf_qa.read_text(encoding='utf-8'))
    assert hashlib.sha256(args.pdf.read_bytes()).hexdigest() == qa['pdf_sha256']
    first_extra = min(page for row in qa['extra80'] for page in row['text_pages'])
    ranges = [(1, min(50, qa['pages'])), (max(1, first_extra-4), qa['pages'])]
    args.output.mkdir(parents=True, exist_ok=True)
    pages = []
    for start, end in ranges:
        prefix = args.output / 'page'
        subprocess.run([str(args.poppler), '-f', str(start), '-l', str(end),
                        '-scale-to', '1100', '-png', str(args.pdf), str(prefix)],
                       check=True, timeout=600, capture_output=True)
        pages.extend(range(start, end+1))
    selected = []
    for page in sorted(set(pages)):
        choices = list(args.output.glob(f'page-*{page}.png'))
        matches = [p for p in choices if int(p.stem.split('-')[-1]) == page]
        assert len(matches) == 1
        selected.append((page, matches[0]))
    sheets = []
    for offset in range(0, len(selected), 12):
        group = selected[offset:offset+12]
        canvas = Image.new('RGB', (2200, 2400), '#ddd9d2')
        draw = ImageDraw.Draw(canvas)
        for index, (page, path) in enumerate(group):
            with Image.open(path) as im:
                im = im.convert('RGB')
                im.thumbnail((530, 750))
                x = (index % 4)*550 + (550-im.width)//2
                y = (index // 4)*800 + 35
                canvas.paste(im, (x, y))
            draw.text(((index % 4)*550+15, (index // 4)*800+10), f'PDF page {page}', fill='black')
        target = args.output/f'contact-{offset//12+1:02d}.jpg'
        canvas.save(target, quality=88)
        sheets.append({'file': target.name, 'pages': [p for p,_ in group],
                       'sha256': hashlib.sha256(target.read_bytes()).hexdigest()})
    result = {'status': 'RENDERED_REQUIRES_VISUAL_INSPECTION',
              'pdf_sha256': qa['pdf_sha256'], 'ranges': ranges,
              'rendered_pages': [p for p,_ in selected], 'contact_sheets': sheets}
    (args.output/'RENDER_INVENTORY.json').write_text(json.dumps(result, indent=2)+'\n', encoding='utf-8')
    print(json.dumps(result))


if __name__ == '__main__':
    main()
