# Open Logic Project — Türkçe Kümülatif Sürüm

[Open the current Turkish reader (OLP-0062, 62/722)](reader/00_OPENLOGIC_tr_CUMULATIVE_LINKED_READER_OLP-0062.pdf)

- Stable Turkish concept DOI: [10.5281/zenodo.21921844](https://doi.org/10.5281/zenodo.21921844)
- Exact OLP-0062 release DOI: [10.5281/zenodo.21921845](https://doi.org/10.5281/zenodo.21921845)
- Declared object: Turkish cumulative edition of the Open Logic Project
- Current coverage: OLP-0001–OLP-0062, 62/722 frozen content modules
- Language: Turkish / Türkçe (BCP 47 `tr`; Zenodo `tur`)
- Frozen source authority: Open Logic Project commit
  `9620cc73f9c8e0ad003c514a5d3748f29611c4c0`, tree
  `f67757bb9305b173634082ab4cefd5601a707a34`
- Workbench mirror release:
  [tr-olp-0062-20260813](https://github.com/KokunoYumeto/OpenLogic/releases/tag/tr-olp-0062-20260813)

This repository is the standalone publication surface for the independently
maintained Turkish edition. The default `main` branch is Turkish. It does
not claim that the remaining 660 content modules have been translated.

The OLP-0062 reader contains the complete introductory Sets, Relations,
Functions, Size of Sets, Arithmetization, and Infinite Sets chapters, plus the
complete reader-reachable Propositional Logic chapter “Syntax and Semantics.”
The cumulative driver suppresses untranslated imports, so the reader contains
no English fallback modules.

## Public artifacts

- `reader/00_OPENLOGIC_tr_CUMULATIVE_LINKED_READER_OLP-0062.pdf`: the
  immediately readable 103-page edition.
- `source/locale/tr/`: editable Turkish LaTeX, cumulative driver,
  terminology, source-adverse disclosure, and translation manifest.
- `build/BUILD.ps1`: build recipe pinned to the exact upstream commit.
- `evidence/SOURCE_AUTHORITY.json`: source identity, topology, and scope.
- `evidence/QA_STATE.json`: source replay, model checks, build, render, and
  release closure.
- `evidence/UNRESOLVED_ITEMS.tsv`: honest scope and metadata backlog.
- `evidence/ARTIFACT_SHA256.tsv`: file-byte and SHA-256 bindings.
- `evidence/DATACITE_RELATIONS.json`: exact relation graph, including
  `IsTranslationOf`, which Zenodo cannot yet express directly.

The matching Zenodo version presents four files: the reader, editable-source
ZIP, evidence-and-provenance ZIP, and SHA-256 manifest. The evidence archive
contains the full translation and typesetting decision trail, terminology and
adverse ledgers, authority and closure records, model/agent review receipts,
build/extraction/render evidence, Git publication/readback receipts, and DOI
metadata.

There is not yet a genuine global Open Logic multilingual collection DOI.
Consequently this edition does not invent an `IsPartOf` relation. That
relation can be added through a metadata-only update when the real hub exists.

Source/canonical defects remain tied to the frozen English authority and are
disclosed with exact locations and Turkish dispositions. Publication is
closed by direct source replay, independent model/agent checking,
deterministic build, all-page rendered inspection, hashes, and unresolved-item
disclosure. Human review is not a release gate.
