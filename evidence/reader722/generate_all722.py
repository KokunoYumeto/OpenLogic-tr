"""Deterministic body/import overlay; never edits any translated source module.

Run from any directory. Produces only new all722-* files in locale/tr and a
manifest here. TeX is not launched. The normal reader traversal is preserved;
deduplication starts only after the normal reader has finished.
"""
from __future__ import annotations
import csv
import hashlib
import json
import posixpath
import re
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
REPO = ROOT / 'repo'
LOCALE = REPO / 'locale/tr'
OUT = LOCALE / 'all722-content'
CLOSURE = ROOT / 'control/CLOSURE_0722.csv'
ROWS = list(csv.DictReader(CLOSURE.open(encoding='utf-8-sig', newline='')))
BY_PATH = {r['source_path']: r for r in ROWS}
BY_ID = {r['closure_id']: r for r in ROWS}
assert len(ROWS) == 722 and len(BY_PATH) == 722
IMPORT = re.compile(r'\\olimport(\*)?\s*(?:\[([^\]]*)\])?\s*\{([^{}]+)\}(?:\[([^\]]*)\])?')
SUBFILE = re.compile(r'\\subfile\s*\{([^{}]+)\}')
HEADERS = re.compile(r'\\(?:ol(?:section|chapter|part)|allmodules(?:chapter|part))\b')

TITLES = '''
643|İspatlanabilirliğin özellikleri
644|Maksimal tutarlı kümeler
645|Birinci dereceden sözdizim ve semantiğe giriş
646|Sözdizim ve semantik: alternatif bölüm düzeni
647|C ile temsil edilebilirlik
648|C fonksiyonları
649|Sezgisel semantikte önermeler
650|Listeler
651|Dönüştürme ve indirgeme
652|İspat kuramsal kavramlar
653|Standart olmayan aritmetik
654|Normal modal mantıklar
655|En büyük kesmelerin kaldırılması
656|En üst kesmelerin kaldırılması
657|Kesme kaldırma
658|Maehara lemması ve Craig ara değerleme teoremi
659|Kesme kaldırmaya giriş
660|Sezgisel kesme kaldırma: ek ispat parçası
661|Orta sekant ve Herbrand teoremleri
662|İspatların aşılanması
663|Doğal türetime giriş
664|Doğal türetim
665|Doğal türetimde niceleyiciler
666|N1 kuralları
667|N2 kuralları
668|Doğal türetim kuralları ve ispatlar
669|Sekantlar
670|G2i sistemine çeviri
671|N2i sistemine çeviri
672|Normalleştirmeye giriş
673|Normalleştirme teoremi
674|Normalleştirme
675|Permütasyon dönüştürmeleri
676|İndirgeme dönüştürmeleri
677|Parçalar ve kesmeler
678|Normalleştirme çevirileri
679|İspat aramanın tamlığı
680|İspat aramaya giriş
681|İspat arama
682|Tc kuralları
683|Arama algoritması
684|Tablolar
685|İspat teorisi
686|Tipler olarak önermelere giriş
687|Tipli ispatların normalleştirilmesi
688|İspat terimleri
689|İspatlardan terimlere
690|Tipler olarak önermeler
691|İndirgeme
692|tN2 kuralları
693|tN3 kuralları
694|Sekant biçiminde doğal türetim
695|Terimlerden ispatlara
696|Tipin korunması
697|Tipler
698|Kabul edilebilir ve türetilebilir kurallar
699|Kuralların yorumu
700|Sekant hesabına giriş
701|Kuralların tersinirliği
702|İspat örnekleri
703|Düzenli ispatlar ve yerine koyma
704|G1c kuralları
705|G1i kuralları
706|G2c kuralları
707|G3c kuralları
708|G3i kuralları
709|LK kuralları
710|mG3i kuralları
711|Sekant kuralları ve ispatlar
712|Sekant hesabı
713|G1c ile G3c arasında çeviri
714|Önerme mantığının tamlığı
715|Önerme mantığının sağlamlığı
716|İkinci dereceden mantığın dili
717|İzomorfizma
718|Tümevarımlı tanımlara ve ispatlara giriş
719|Bağıntılar: alternatif bölüm düzeni
720|Kümeler, bağıntılar, fonksiyonlar: alternatif kısım düzeni
721|Kümeler hakkında ispatlar
722|Kümelerin büyüklüğü: alternatif bölüm düzeni
'''
TITLE = {f'OLP-{int(n):04}': t for n,t in
         (line.split('|',1) for line in TITLES.strip().splitlines())}

def sha(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()

def active_line(line: str) -> tuple[str,str]:
    """Split comment without treating escaped percent signs as comments."""
    for i,c in enumerate(line):
        if c == '%' and len(re.match(r'\\*', line[:i][::-1]).group()) % 2 == 0:
            return line[:i],line[i:]
    return line,''

def resolve(row: dict, path: str | None, name: str, star: bool=False) -> str:
    base = 'content' if star else posixpath.dirname(row['source_path'])
    target = posixpath.normpath(posixpath.join(base,path or '',name))
    if not target.endswith('.tex'):
        target += '.tex'
    if target not in BY_PATH:
        raise ValueError(f"Unresolved import in {row['closure_id']}: {target}")
    return BY_PATH[target]['closure_id']

def main() -> None:
    OUT.mkdir(exist_ok=True)
    inventory=[]
    definitions=[]
    edges={}
    for row in ROWS:
        ident=row['closure_id']
        source=REPO / row['target_path']
        raw=source.read_bytes()
        text=raw.decode('utf-8-sig')
        assert not any(c in row['source_path']+ident for c in ',\r\n"'), ident
        # Literal label keys occupy the third field of duplicate-label rows.
        # Namespace macros are fixed ASCII IDs without commas.
        for label in re.findall(r'\\(?:ol)?label\{([^{}]*)\}', text):
            assert not any(c in label for c in ',\r\n"'), (ident,label)
        begin='\\begin{document}'
        end='\\end{document}'
        if begin in text:
            assert text.count(begin)==1 and text.count(end)==1, ident
            body=text.split(begin,1)[1].rsplit(end,1)[0]
            extraction='subfiles document body'
        else:
            assert '\\documentclass' not in text,ident
            body=text
            extraction='raw fragment'
        original_body=body
        transforms=[]
        found=[]
        def replace_import(m:re.Match)->str:
            child=resolve(row,m[2],m[3],bool(m[1]))
            level=m[4] or 'section'
            found.append({'kind':'olimport','target':child,'section_command':level})
            out=f'\\allmodulesimport[{level}]{{{child}}}'
            transforms.append({'before':m[0],'after':out})
            return out
        def replace_subfile(m:re.Match)->str:
            child=resolve(row,None,m[1])
            found.append({'kind':'subfile','target':child,'section_command':'inherit'})
            out=f'\\allmodulessubfile{{{child}}}'
            transforms.append({'before':m[0],'after':out})
            return out
        def replace_language_shorttitle(m:re.Match)->str:
            out='\\allmodules'+m[1]
            transforms.append({'kind':'language_marker_shorttitle',
                               'before':m[0],'after':out,
                               'reason':'The literal tr language marker was misread as a short title; retain the actual full Turkish title in navigation.'})
            return out
        rebuilt=[]
        for line in body.splitlines(keepends=True):
            active,comment=active_line(line)
            active=IMPORT.sub(replace_import,active)
            active=SUBFILE.sub(replace_subfile,active)
            active=re.sub(r'\\ol(chapter|part)\[tr\]',replace_language_shorttitle,active)
            rebuilt.append(active+comment)
        body=''.join(rebuilt)
        if ident=='OLP-0644':
            successor={'prop:provability-land-left':'prop:provability-land-left',
                       'prop:provability-land-right':'prop:provability-land-right',
                       'prop:provability-lor-left':'prop:provability-lor',
                       'prop:provability-lor-right':'prop:provability-lor',
                       'prop:provability-mp':'prop:provability-lif',
                       'prop:provability-lif':'prop:provability-lif'}
            def replace_obsolete_tagref(m:re.Match)->str:
                target=successor[m[1]]
                out='\\cref{fol:seq:ppr:'+target+',fol:ntd:ppr:'+target+'}'
                transforms.append({'kind':'obsolete_reference',
                    'before':m[0],'after':out,
                    'reason':'Same stated connective facts occur in frozen seq/ntd provability-propositional modules (ppr). Old prv names and the old double-comma tagrefs helper made invalid destinations. Lor and implication cases now share proposition-level labels.'})
                return out
            body,n=re.subn(r'\\tagrefs\{prfSC/\{fol:seq:prv:(prop:provability-(?:land-left|land-right|lor-left|lor-right|mp|lif))\},prfND/\{fol:ntd:prv:\1\}\}',replace_obsolete_tagref,body)
            assert n==7,(ident,n)
        reference_repairs={
            'OLP-0714':[
                ('\\olref[axd]{prop:phi}', '\\olref[pl][axd][prv]{prop:provability-exhaustive}',
                 'The cited consistent-choice fact is the contrapositive of the frozen exhaustive-inconsistency proposition.'),
                ('\\olref[axd]{prop:prov-incons}', '\\olref[pl][axd][prv]{prop:prov-incons}',
                 'Fully qualify the existing propositional axiomatic provability/inconsistency proposition.')],
            'OLP-0715':[
                ('\\olref[sem]{prop:semanticalfacts}', '\\olref[pl][syn][sem]{prop:semanticalfacts}',
                 'The frozen semantic-notions source locates its third semantic fact in pl:syn:sem, not pl:prp:sem.')]
        }
        for before,after,reason in reference_repairs.get(ident,[]):
            assert before in body,(ident,before)
            count=body.count(before)
            body=body.replace(before,after)
            transforms.extend({'kind':'obsolete_reference','before':before,'after':after,'reason':reason} for _ in range(count))
        # Preserve all original formula/prose bytes; namespace only the legacy
        # duplicate provability module so its labels cannot overwrite OLP0121.
        if ident=='OLP-0643':
            before=body
            body=body.replace('{axd}{prv}', '{axd}{prv-legacy}')
            assert body!=before
            transforms.append({'kind':'label_namespace','before':'{axd}{prv}',
                               'after':'{axd}{prv-legacy}',
                               'reason':'Avoid collision with OLP-0121; formulas/prose unchanged.'})
            local_ref='\\olref[fol][axd][prv]{prop:provability}'
            legacy_ref='\\olref[fol][axd][prv-legacy]{prop:provability}'
            assert local_ref in body
            body=body.replace(local_ref,legacy_ref)
            transforms.append({'kind':'local_reference_namespace',
                               'before':local_ref,'after':legacy_ref,
                               'reason':'This exercise refers to the proposition in the same legacy source module.'})
        active_body='\n'.join(active_line(line)[0] for line in body.splitlines())
        has_header=bool(HEADERS.search(active_body))
        plain_heading='\\section{Aritmetiğin Standart Olmayan Modelleri}'
        plain_heading_anchor=ident=='OLP-0653'
        if plain_heading_anchor:
            assert plain_heading in body
            body=body.replace(plain_heading,plain_heading+'\n\\allmodulesmark',1)
            has_header=True
            transforms.append({'kind':'plain_section_anchor',
                               'reason':'Place module bookmark after the source plain section heading.'})
        is_table=ident in TITLE and not has_header and '\\begin{table}' in active_body
        if is_table:
            body=body.replace('\\begin{table}', '\\begin{table}\n\\allmodulesmark',1)
            transforms.append({'kind':'float_anchor','reason':'Place bookmark in rendered rule table, not preceding text.'})
        # Independently reverse only declared mechanical edits. This proves
        # that prose, mathematical material and editorial text were not lost.
        restored=body
        if is_table:
            restored=restored.replace('\\begin{table}\n\\allmodulesmark','\\begin{table}',1)
        if plain_heading_anchor:
            restored=restored.replace(plain_heading+'\n\\allmodulesmark',plain_heading,1)
        if ident=='OLP-0643':
            restored=restored.replace('{axd}{prv-legacy}','{axd}{prv}')
        for transform in transforms:
            if 'before' in transform and transform.get('kind')!='label_namespace':
                restored=restored.replace(transform['after'],transform['before'],1)
        assert restored==original_body, f'Body round-trip failed: {ident}'
        path=OUT / f'{ident}.tex'
        generated=('% Generated from '+row['target_path']+'; do not hand-edit.\n'+body).encode('utf-8')
        path.write_bytes(generated)
        title=TITLE.get(ident,'')
        definitions.append(f'\\allmodulesdefine{{{ident}}}{{{row["source_path"]}}}{{{title}}}{{'+
                           ('header' if has_header else 'table' if is_table else 'body')+'}')
        edges[ident]=found
        inventory.append({'id':ident,'source_path':row['source_path'],
            'target_path':row['target_path'],'target_sha256':sha(raw),
            'target_bytes':len(raw),'extraction':extraction,
            'original_body_sha256':sha(original_body.encode('utf-8')),
            'overlay_path':str(path.relative_to(REPO)).replace('\\','/'),
            'overlay_sha256':sha(generated),'overlay_bytes':len(generated),
            'normal_reader_reachable':row['canonical_reader_reachable']=='true',
            'source_role':row['source_role'],'title':title,
            'body_round_trip_verified':True,
            'transformations':transforms,'imports':found})
    (LOCALE/'all722-definitions.tex').write_text('\n'.join(definitions)+'\n',encoding='utf-8')
    # Original normal-reader entry points, configuration, and content stay intact.
    driver=(LOCALE/'open-logic-complete.tex').read_text(encoding='utf-8-sig')
    driver=driver.replace('% Complete Turkish Open Logic reader driver.',
                          '% All-722 Turkish reader: original reader plus actual supplemental bodies.')
    driver=driver.replace('\\begin{document}',
        '\\input{all722-support.tex}\n\\input{all722-definitions.tex}\n\\begin{document}',1)
    driver=driver.replace('Tam Derleme (Türkçe / tr)','Tam Derleme: 722 Kaynak Modülü (Türkçe)')
    driver=driver.replace('12 Temmuz 2026','4 Eylül 2026')
    driver=driver.replace('\\include{content/open-logic-about}',
                          '\\clearpage\\allmodulesimport{OLP-0001}\\clearpage')
    driver=driver.replace('\\olimport[content]{content}',
                          '\\allmodulesimport{OLP-0002}\n\\input{all722-supplement.tex}')
    driver=driver.replace('\\pagestyle{headings}',
                          '\\pagestyle{headings}\n\\nouppercaseheads')
    driver=driver.replace('\\photocredits','\\allmodulesphotocredits')
    (LOCALE/'open-logic-all722.tex').write_text(driver,encoding='utf-8')
    # Normal import-order DFS includes actual subfile edges, unlike the historical CSV.
    # This static reachability is an upper bound when source tag conditionals exist;
    # runtime modules.csv proves which source bodies TeX actually executed.
    def walk(root,seen):
        if root in seen:return
        seen.add(root)
        for edge in edges[root]:walk(edge['target'],seen)
    normal=set()
    walk('OLP-0001',normal);walk('OLP-0002',normal)
    extra_graph=set()
    walk('OLP-0685',extra_graph);walk('OLP-0681',extra_graph)
    manifest={'schema':'turkish-all722-overlay-v1',
              'closure_sha256':sha(CLOSURE.read_bytes()),
              'modules':inventory,'count':len(inventory),
              'static_normal_unique':len(normal),
              'static_proof_theory_plus_search_unique':len(extra_graph),
              'normal_ids':sorted(normal),
              'proof_theory_plus_search_ids':sorted(extra_graph),
              'runtime_inventory':'repo/locale/tr/open-logic-all722.modules.csv',
              'runtime_schema':['event','id','source_path','page','context'],
              'runtime_delimiter':',',
              'runtime_field_delimiter_validation':'source IDs, paths and literal label keys contain no comma, quote or newline; page/context/event fields are controlled',
              'original_files_modified':False}
    (HERE/'SOURCE_IMPORT_MANIFEST.json').write_text(
        json.dumps(manifest,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'generated':722,'normal_unique':len(normal),
                      'proof_theory_plus_search_unique':len(extra_graph),
                      'manifest':str(HERE/'SOURCE_IMPORT_MANIFEST.json')},ensure_ascii=False))

if __name__=='__main__': main()
