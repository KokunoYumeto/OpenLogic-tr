# OLP-0722 corrected local package receipt

Date: 2026-08-14  
State: **COMPLETE LOCAL FOUR-ASSET PACKAGE / INDEPENDENT REPLAY CLEAN**

## Release identity

- Product: complete Turkish edition of the frozen Open Logic Project corpus,
  OLP-0001--0722 (722/722 editable Turkish targets).
- Source authority: commit
  `9620cc73f9c8e0ad003c514a5d3748f29611c4c0`, tree
  `f67757bb9305b173634082ab4cefd5601a707a34`.
- Stable Turkish concept DOI: `10.5281/zenodo.21921844`.
- Reserved exact version DOI: `10.5281/zenodo.21927145`, record
  `21927145`.
- Release date: 2026-08-14.
- Planned standalone tag: `tr-olp-0722-20260814`.
- Output root: `output/doi/OLP-0722`.

## Exact corrected public surface

| File | Bytes | SHA-256 |
|---|---:|---|
| `00_OPENLOGIC_tr_COMPLETE_LINKED_READER_OLP-0722.pdf` | 5,470,171 | `2D9939692A971EDF468D3B41F38C57283C046BE9D110783CF50D10CDB3152900` |
| `01_OPENLOGIC_tr_EDITABLE_SOURCES_OLP-0722.zip` | 1,631,874 | `FDFB4E6B7361F9A84BE621E8B0CCD03BAA9F855113A62D01E44E870128AE5B8B` |
| `02_OPENLOGIC_tr_EVIDENCE_AND_PROVENANCE_OLP-0722.zip` | 5,120,364 | `B18BE2748B744A1EE5782CAFB759648E80C86297B3BE65460B2FEDAB160B69BA` |
| `03_OPENLOGIC_tr_SHA256_MANIFEST_OLP-0722.txt` | 393 | `8A51D94346A9E3A8489355D524E769B441DE5BB049B44D1451BFEE4CAAC6782A` |

The public manifest has three payload rows and independently replays all byte
counts and SHA-256 identities. The manifest's own identity is recorded above.

## Independent corrected-package audit

- Output-root file-name/set check: exactly four files, `PASS`.
- Reader: 1,037 pages; PDF identity matches the frozen reader, `PASS`.
- Editable-source ZIP: 746 entries / 4,881,985 uncompressed bytes; 745/745
  internal manifest rows replay exactly; zero missing, extra, byte, hash, read,
  duplicate, case-duplicate, traversal, or forbidden-path errors.
- Editable corpus: 722 content `.tex` targets and 722 closure/translation rows;
  all target byte counts and SHA-256 identities replay, errors 0.
- Evidence/provenance ZIP: 312 entries / 34,782,729 uncompressed bytes; 311/311
  internal manifest rows replay exactly; zero missing, extra, byte, hash, read,
  duplicate, case-duplicate, traversal, or forbidden-path errors.
- All five packaged closure copies are byte-identical to the final closure.
  Translation and QA ledgers contain 722 rows each and agree with that closure:
  structural replay `PASS` for 722, semantic state
  `ADMITTED_AGGREGATE_MODEL_REVIEW` for 722, build/render scope limited to 642
  reader-reachable targets, and `NOT_APPLICABLE_RETAINED_NONREADER` for 80.
  No native or institutional review is represented as a gate.
- All 46 packaged JSON files parse. Source sums, the 3-row outer manifest,
  current-state metadata, credential redactions, and exclusion controls replay
  cleanly. No credential, cache, VCS, render-page, contact-sheet, or transient
  intermediate residual entered the public surface.
- `release_identity/EXCLUDED_PATHS.tsv` records eleven explicit exclusions:
  ten methodology `_qa` PNG renders and this nonembedded package receipt.

## Frozen control identities

- `CLOSURE_0722.csv`: 1,058,824 bytes, SHA-256
  `4F0DFAA58C38B54C00180DE30AE09507D0DF9FBEA1E0ED6729DB7E2FA77AAC2F`.
- `TRANSLATION_MANIFEST_0722.csv`: 317,385 bytes, SHA-256
  `330BF4DB4F059F841B7405968BBF9B8103ABFD14767BC685C48FEA3713D96BED`.
- `QA_0722.csv`: 201,939 bytes, SHA-256
  `4CEF27ED85D1E3430D890B967E82A22AC9FC19EA3CF87C168E937D26C0C3467D`.
- `COMPLETE_0722_STRUCTURAL_QA.json`: 2,443,209 bytes, `PASS`, SHA-256
  `46F5FE080693D3A99DE234A9588C28D5A683D0FDACFA62AD2323AC3B8EB01499`.
- `REVIEW_0722.md`: 5,692 bytes, SHA-256
  `7A0EF8BDB8735CC10D94ED8116C1D0CB09CD7B6F05037A6F4840A06D091A4AF0`.
- `SOURCE_ADVERSE_0722.md`: 24,130 bytes, SHA-256
  `CF29D81C32C53FAE4567034F4B683E45CB8E60EA90B0735C338917085D47BD3C`.

This receipt was written after the immutable corrected four-asset package was
sealed and therefore is not recursively embedded in that package. The local
package is ready for corrective GitHub asset replacement and Zenodo upload.
The GitHub release exists, but its earlier assets are superseded until replaced
and read back; the Zenodo record has no OLP-0722 files and is unpublished. No
build, Git operation, network request, Zenodo mutation, or public readback was
performed by the local packager or claimed in this receipt.
