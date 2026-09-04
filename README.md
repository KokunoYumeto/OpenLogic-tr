[**Türkçe PDF'yi aç / Read the Turkish PDF — 1,198 pages**](reader/00_OPENLOGIC_tr_COMPLETE_LINKED_READER_OLP-0722.pdf)

# Open Logic Project — Türkçe

**722 modülün tamamı tek okuyucuda. / All 722 modules in one reader.**

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
These checks verify the PDF itself. The [public release receipt](evidence/reader722/PUBLICATION_RECEIPT.json)
separately confirms anonymous download, byte-count, and SHA-256 verification
of all five release files on both GitHub and Zenodo.

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

The new source and evidence ZIPs are privacy-safe derivatives. Across
48 metadata/log entries, the private profile identifier is replaced
with `[maintainer]`, case-insensitively. Entry names and every other entry
byte are preserved. **None of the 722 translated target bodies changed.**
The [privacy receipt](evidence/reader722/PRIVACY_REDACTION_RECEIPT.json)
records each changed entry's original and derivative hashes and verifies
the complete translated corpus against its frozen closure.

The previous public archives and releases remain unchanged. Historical
hashes inside the derivative evidence still identify historical bytes;
the privacy receipt supplies the explicit before/after mapping. Historical
reader QA does not certify the corrected PDF.

## Dosyalar / Release files

| File | What it contains |
|---|---|
| `00_OPENLOGIC_tr_COMPLETE_LINKED_READER_OLP-0722.pdf` | The corrected reader |
| `01_OPENLOGIC_tr_EDITABLE_SOURCES_OLP-0722.zip` | Privacy-safe source package; all 722 target bodies unchanged |
| `02_OPENLOGIC_tr_EVIDENCE_AND_PROVENANCE_OLP-0722.zip` | Privacy-safe derivative of the original translation/provenance evidence |
| `03_OPENLOGIC_tr_SHA256_MANIFEST_OLP-0722.txt` | Hashes of this correction payload |
| `04_OPENLOGIC_tr_READER_CORRECTION_OLP-0722.zip` | Reader inputs, reproducible build, decisions, and new QA |

Reader identity: **6,200,006 bytes**; SHA-256
`4af08c16e61aa058500cc1e96acb5d700c988718a729d4d6cbbe4aea9664df94`.

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

- Version: `OLP-0722-READER-20260904`.
- [Corrected 722-module Zenodo edition](https://doi.org/10.5281/zenodo.22306530).
- [Download the GitHub correction release](https://github.com/KokunoYumeto/OpenLogic-tr/releases/tag/tr-olp-0722-reader-complete-20260904).
- Stable Turkish concept DOI: [10.5281/zenodo.21921844](https://doi.org/10.5281/zenodo.21921844).
- [Previous published version](https://doi.org/10.5281/zenodo.21927145): 722 translated source modules, but a 642-module reader.
- [Historical GitHub release](https://github.com/KokunoYumeto/OpenLogic-tr/releases/tag/tr-olp-0722-20260814).
- [GitHub repository and release inventory](https://github.com/KokunoYumeto/OpenLogic-tr).
- Open Logic Project remains the credited source author; existing translation credit is “OpenAI 5.6 Sol, Ultra mode”.
- Language: Turkish / Türkçe (`tr`; Zenodo `tur`). License: CC BY 4.0, subject to upstream attribution and exceptions.
