# Reader inclusion correction decisions

## D01 - Repair the reader, not the completed source translations

The defect is reader inclusion: existing target files cover all 722 source modules. Preserve these translations and add the omitted content to a newly versioned reader. Do not treat non-reader reachability in the old closure as permission to omit material from this corrected PDF.

## D02 - Preserve old receipts and the original reader

Use a new reader driver and output name. Existing build/render/publication receipts remain historical. New evidence must prove the new reader's actual 722-source inclusion and rendering.

## D03 - Source and public metadata privacy

Public-facing new metadata will not contain the user's personal name. Do not copy account credentials, session rollouts, or private filesystem paths into public evidence. Existing historical files remain unchanged unless explicitly superseded as part of this correction.

## D04 - Preserve original archive authority; publish privacy-safe derivatives

The original `01_OPENLOGIC_tr_EDITABLE_SOURCES_OLP-0722.zip` (SHA256 `fdfb4e6b7361f9a84be621e8b0ccd03baa9f855113a62d01e44e870128ae5b8b`) and `02_OPENLOGIC_tr_EVIDENCE_AND_PROVENANCE_OLP-0722.zip` (SHA256 `b18be2748b744a1ee5782cafb759648e80c86297b3be65460b2fedab160b69ba`) remain immutable public provenance authorities. The current privacy requirement supersedes the earlier plan to reissue these ZIPs byte-for-byte: the new version uses privacy-safe derivatives under the same asset filenames. Only the case-insensitive private profile identifier is replaced by `[maintainer]`; all entry names and every other entry byte are preserved. All 722 Turkish target bodies must retain their frozen closure hashes. The new `04` correction ZIP includes a per-entry original/derivative hash receipt, while the new outer manifest identifies the derivative archive bytes. Historical releases remain public and unchanged.

## D05 - Use the current public repository base

The existing standalone publication checkout was fast-forwarded from `b20c7f9c76a18c21485f746e965f7116ee99c482` to remote `main` at `c6b5f91f25e70c99736627c9347a3bd2772990a4`. This preserves the central translation-catalogue link added independently on 2026-09-04. No force push is authorized or needed.

## D06 - Distinguish render compatibility from linguistic revision

OLP-0643 reuses identifiers already present in OLP-0121. Several alternative chapter/part drivers repeat labels. Some auxiliary files inherit namespaces from their importing sections, and OLP-0660 is a raw proof fragment rather than a standalone subfile. The correction may use logged, deterministic rendering overlays to resolve inclusion/namespace issues while preserving original target bytes. An overlay must never silently omit a proof, formula, or nested rule table. The final inclusion evidence must count auxiliary fragments as actual rendered content rather than metadata-only bookmarks.

## D07 - Audit privacy substitutions without rewriting historical evidence

Generate the new source/evidence archives only from the verified historical archive hashes. For every entry, require that its derivative bytes equal the original bytes after only the permitted profile-identifier substitution. Preserve ZIP entry names and ordering. Log each changed entry's original and new SHA-256, byte counts, replacement count, and privacy-only reason in `PRIVACY_REDACTION_RECEIPT.json`; do not copy the removed identifier or source excerpts into that receipt. Recheck all 722 target bodies against `CLOSURE_0722.csv`. Embedded historical hashes remain historical records, with the receipt supplying the before/after mapping for metadata and logs. New-publication validation must prove the derivative package and included receipt agree before upload. The previous public version is never edited, deleted, or access-restricted.
