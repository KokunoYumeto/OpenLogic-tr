[**Türkçe PDF'yi aç / Read the Turkish PDF — 1,198 pages**](reader/00_OPENLOGIC_tr_COMPLETE_LINKED_READER_OLP-0722.pdf)

[**Karar dizininden başlayın / Start with the translation-decision index**](START_HERE.md) · [Öncelikli inceleme / Priority review](evidence/reviewer-index/PRIORITY_REVIEW.md) · [Tam dizin / Full index](evidence/reviewer-index/TRANSLATION_DECISIONS_FULL.md)

# Open Logic Project — Türkçe

**722 modülün tamamı tek okuyucuda. / All 722 modules in one reader.**

The current reader removes one internal source-revision hash from the title
page while retaining that exact revision in the technical provenance. No
translation body, mathematical content, pagination, bookmark, or link changed.
[Correction evidence](evidence/reader-frontmatter-correction-20260905/README.md)
contains the exact source delta, deterministic build receipts, PDF checks, and
before/after visual evidence.

Önceki PDF, çevrilmiş 722 modülden yalnızca 642'sini içeriyordu. Diğer
80 modülün çevirileri kaynak paketindeydi, fakat okuyucuda yoktu. Bu sürüm,
o 80 modülün metinlerini, kanıtlarını, alıştırmalarını ve kural tablolarını
okuyucuya ekler. PDF'deki yer imleri ve OLP kimlikleri, eklenen bölümlere
doğrudan ulaşmayı sağlar.

The translation already covered all 722 source modules. The earlier PDF
omitted 80 of them. This correction makes their actual text, proofs,
exercises, and rule tables readable in the PDF, with bookmarks and stable
OLP identifiers. It repairs reader coverage; it is not a claim that those
modules have just been translated.

> Bu sürüm [Open Logic çevirileri ana kataloğunda](https://github.com/KokunoYumeto/OpenLogic-translations) yer alır; katalog, çevrilmiş kaynak kapsamı ile bağımsız okuyucu kapsamını ayrı bildirir.

## Bu sürümde ne var? / What is in this edition?

| Verified feature | Result |
|---|---:|
| Translated source modules | 722 / 722 |
| Modules included in the reader | 722 / 722 |
| Previously omitted modules now included | 80 / 80 |
| PDF pages | 1,198 |
| Bookmarks | 904 |
| Internal links | 3,172 |
| Broken internal links | 0 |

The additional material follows the original reader as a supplement.
Nested rule tables stay with their importing sections, and supplementary
exercises print inline. All 722 original translated target files retain
their frozen hashes. Logged, reversible overlays handle the alternative
reader contexts without silently dropping source bodies.

The exact PDF passed the build, source-preservation, text/link, and visual
checks recorded in [FINAL_QA.json](evidence/reader722/FINAL_QA.json).
These checks verify the PDF itself. The
[preceding public release receipt](evidence/reader722/PUBLICATION_RECEIPT.json)
remains immutable historical evidence for the preceding PDF; publication of
these successor bytes receives a separate receipt after public readback.

## Çeviri karar dizini / Translation-decision index

This successor keeps the accepted Turkish corpus unchanged and rebinds the
translation-decision index to the corrected reader PDF. It indexes all **194
historical term decisions** recorded through the OLP-0068 production
checkpoint against all 722 current target modules, yielding **6,944 located
occurrences**. The readable index records the recovered rationale, confidence,
source evidence, and concrete review questions; the CSV, JSON, schema, and QA
files provide the replayable data surfaces. The historical ledger did not
record rejected alternatives for these 194 rows, so the machine-readable
`alternatives` arrays are explicitly empty rather than invented. Exact scope,
locator caveats, and the later evidence-backfill boundary are stated in
[START_HERE.md](START_HERE.md).

Bu ek sürüm, kabul edilmiş Türkçe çeviri gövdelerini değiştirmeden karar
dizinini düzeltilmiş okuyucu PDF'sine bağlar ve çeviri yöntemini incelenebilir
hâle getirir. OLP-0068 üretim noktasına kadar
kaydedilmiş **194 tarihsel terim kararı**, 722 güncel hedef modülün tamamına
karşı taranmış ve **6.944 konumlandırılmış oluşum** elde edilmiştir. Kapsam ve
konum sınırlamaları [START_HERE.md](START_HERE.md) dosyasında açıkça belirtilir.

## Kaynaklar ve kararlar / Sources and decisions

This is **Turkish**, not Inter-Turkic and not a substitute edition for other
Turkic languages. The authority is the frozen English Open Logic Project
[commit 9620cc73f9c8e0ad003c514a5d3748f29611c4c0](https://github.com/OpenLogicProject/OpenLogic/commit/9620cc73f9c8e0ad003c514a5d3748f29611c4c0).
The correction does not complete proofs left unfinished in that source,
claim new linguistic validation, or claim human comprehension testing.

- [Reader decisions](evidence/reader722/DECISIONS.md) explain inclusion and compatibility choices.
- [Source import manifest](evidence/reader722/SOURCE_IMPORT_MANIFEST.json) connects every original target to its reversible reader overlay.
- [Runtime module record](evidence/reader722/RUNTIME_MODULES.csv) records actual inclusion and anchor events.
- [PDF checks](evidence/reader722/PDF_QA.json) and [visual checks](evidence/reader722/VISUAL_QA.json) concern this corrected PDF, not the historical reader.

## Mahremiyet ve geçmiş / Privacy and historical evidence

The successor source and evidence ZIPs are privacy-safe derivatives. The prior
redaction changed 48 metadata/log entries; this successor additionally catches
two line-wrapped occurrences in one build log by scanning text again after
ASCII-whitespace normalization. Every unaffected member byte is preserved,
and both top-level member manifests are regenerated against the actual enclosed
bytes. **None of the 722 translated target bodies changed.**
The [privacy receipt](evidence/reader722/PRIVACY_REDACTION_RECEIPT.json)
records each changed entry's original and derivative hashes and verifies
the complete translated corpus against its frozen closure. The additive
[archive-repair receipt](evidence/reader-frontmatter-correction-20260905/INHERITED_ARCHIVE_MANIFEST_AND_PRIVACY_REPAIR.json)
binds the successor ZIP identities, the 48 repaired manifest rows, and the two
additional split-log replacements.

The previous public archives and releases remain unchanged. Historical
hashes inside the derivative evidence still identify historical bytes;
the privacy receipt supplies the explicit before/after mapping. Historical
reader QA does not certify the corrected PDF.

The unversioned repository path
[`evidence/ARTIFACT_SHA256.tsv`](evidence/ARTIFACT_SHA256.tsv) is explicitly a
historical predecessor snapshot, not the active successor manifest. Current
successor asset identities are governed by
`PUBLICATION_ASSET_MANIFEST_FRONTMATTER_CORRECTION_20260905.json` and
`SHA256SUMS_FRONTMATTER_CORRECTION_20260905`.

## Dosyalar / Release files

| File | What it contains |
|---|---|
| `00_OPENLOGIC_tr_COMPLETE_LINKED_READER_OLP-0722.pdf` | The corrected reader with a clean title page |
| `01_OPENLOGIC_tr_EDITABLE_SOURCES_OLP-0722.zip` | Frozen 722-target source base with its embedded member manifest repaired |
| `02_OPENLOGIC_tr_EVIDENCE_AND_PROVENANCE_OLP-0722.zip` | Historical translation/provenance base with split-path privacy repair and a regenerated member manifest |
| `03_OPENLOGIC_tr_SHA256_MANIFEST_OLP-0722.txt` | Hashes of the current four-part reader payload |
| `04_OPENLOGIC_tr_READER_CORRECTION_OLP-0722.zip` | Current reader inputs, reproducible build material, QA, and front-matter evidence |

The translated source bodies and historical evidence payload remain unchanged,
but `01` and `02` are rebuilt because their inherited top-level member manifests
still described pre-redaction bytes; `02` also removes two whitespace-split
private-profile occurrences from one build log. Asset `01` additionally repairs
its source-authority closure locator to the actual archive-root
`SOURCE_CLOSURE_0722.csv`. The PDF, `03`, and `04` are rebuilt for this
successor as well. The successor also carries the seven
standalone files under
[evidence/reviewer-index](evidence/reviewer-index),
`OPENLOGIC_tr_TRANSLATION_DECISION_REVIEW_INDEX_OLP-0722_20260905.zip`,
`PUBLICATION_ASSET_MANIFEST_FRONTMATTER_CORRECTION_20260905.json`, and
`SHA256SUMS_FRONTMATTER_CORRECTION_20260905`.

Reader identity: **6,200,714 bytes**; SHA-256
`b21aea2ea90b7129ba8a11e6548a4b8b116e1fa9ef3228d59414c5be58099675`.

## Yeniden derleme / Rebuild

On Windows with Git, MiKTeX, latexmk, and PowerShell 7, run:

```powershell
pwsh -File build/BUILD.ps1
```

The entry point calls `build/BUILD_ALL722.ps1`, which obtains the frozen
upstream commit, installs the supplied Turkish sources and reader overlays,
acquires the machine-wide TeX mutex, and builds `open-logic-all722.tex` with
a bounded captured process. Output goes to `output/`; optional
`-WorkDirectory` and `-OutputDirectory` arguments select other locations.
It does not silently rebuild the old 642-module reader.

For an archive-only rebuild, unpack this version's `01` source ZIP and `04`
correction ZIP into the same empty directory, then run
`build/BUILD_ALL722.ps1`. The correction ZIP alone is not a complete source
distribution.

## Sürüm ve atıf / Version and citation

- Version: `OLP-0722-READER-FRONTMATTER-CORRECTION-20260905`.
- [GitHub successor release](https://github.com/KokunoYumeto/OpenLogic-tr/releases/tag/tr-olp-0722-reader-frontmatter-correction-20260905).
- [Preceding reviewer-index Zenodo edition](https://doi.org/10.5281/zenodo.22347312) · [GitHub release](https://github.com/KokunoYumeto/OpenLogic-tr/releases/tag/tr-olp-0722-review-index-20260905).
- Stable Turkish concept DOI: [10.5281/zenodo.21921844](https://doi.org/10.5281/zenodo.21921844).
- [Preceding reader-completeness version](https://doi.org/10.5281/zenodo.22306530) · [GitHub release](https://github.com/KokunoYumeto/OpenLogic-tr/releases/tag/tr-olp-0722-reader-complete-20260904).
- [Previous published version](https://doi.org/10.5281/zenodo.21927145): 722 translated source modules, but a 642-module reader.
- [Historical GitHub release](https://github.com/KokunoYumeto/OpenLogic-tr/releases/tag/tr-olp-0722-20260814).
- [GitHub repository and release inventory](https://github.com/KokunoYumeto/OpenLogic-tr).
- Open Logic Project remains the credited source author; existing translation credit is “OpenAI 5.6 Sol, Ultra mode”.
- Language: Turkish / Türkçe (`tr`; Zenodo `tur`). License: CC BY 4.0, subject to upstream attribution and exceptions.
