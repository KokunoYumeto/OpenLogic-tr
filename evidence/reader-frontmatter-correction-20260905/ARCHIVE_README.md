# Archive use / Arşiv kullanımı

This correction archive is additive. To reproduce the reader, unpack
`01_OPENLOGIC_tr_EDITABLE_SOURCES_OLP-0722.zip` and
`04_OPENLOGIC_tr_READER_CORRECTION_OLP-0722.zip` into the same empty directory,
then run `build/BUILD_ALL722.ps1` on Windows with Git, MiKTeX, `latexmk`, and
PowerShell 7. The build script obtains the named machine-wide TeX mutex before
launching TeX.

Bu düzeltme arşivi eklemelidir. Okuyucuyu yeniden üretmek için `01` kaynak
arşivi ile `04` düzeltme arşivini aynı boş klasöre çıkarın ve ardından
`build/BUILD_ALL722.ps1` dosyasını çalıştırın.

The translated source bodies and historical provenance payload do not change,
but the `01` and `02` archives are rebuilt deterministically. Their inherited
top-level `ARTIFACT_SHA256.tsv` files described pre-redaction member bytes, so
this successor regenerates those tables against the actual enclosed bytes.
Asset `01` also repairs `SOURCE_AUTHORITY.json` so its closure locator resolves
to the actual archive-root `SOURCE_CLOSURE_0722.csv`; asset `02` retains its
own valid `source_authority/CLOSURE_0722.csv` layout.
Asset `02` also replaces two whitespace-split local-profile occurrences in one
build log with `[maintainer]`; all other non-manifest member bytes remain exact.
The current `04` archive replaces the title-page driver, active reader QA, and
correction evidence. The exact frozen English source revision remains in
authority and closure evidence; it is absent only from the reader-facing title
page.

For standalone verification, each of `01`, `02`, and `04` contains a
top-level `ARTIFACT_SHA256.tsv` that covers every other archive member. The
`04` evidence subtree also carries the exact reviewer-index configuration,
match rules, evidence crosswalk, generator, validator, and package-repair
scripts used for this successor, together with the current repository and
deposit metadata.

Only the root `/ARTIFACT_SHA256.tsv` in each ZIP is the active whole-archive
member-integrity manifest. Nested methodology, template, and publication
metadata tables are preserved provenance records with narrower historical or
template scopes; they are not current whole-archive inventories. In
particular, asset `02` retains one inert scaffold template and one predecessor
publication-metadata snapshot. Their exact identities and row dispositions are
recorded in `INHERITED_ARCHIVE_MANIFEST_AND_PRIVACY_REPAIR.json` rather than
being overclaimed as current manifest passes.

The repository-level `evidence/ARTIFACT_SHA256.tsv` is likewise preserved as
an explicitly labelled historical predecessor snapshot. It is included in
this correction archive for audit, but it is not an active successor asset
manifest; the dated outer manifest and checksum file govern the successor.

Expected corrected reader:

- filename: `00_OPENLOGIC_tr_COMPLETE_LINKED_READER_OLP-0722.pdf`
- bytes: 6,200,714
- pages: 1,198
- SHA-256: `b21aea2ea90b7129ba8a11e6548a4b8b116e1fa9ef3228d59414c5be58099675`

See `READER_FRONTMATTER_QA.json` for the exact source delta and deterministic
build/readback checks. See `README.md` for the bilingual evidence guide.
