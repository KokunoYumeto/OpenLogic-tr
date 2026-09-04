# Turkish all-722 reader inclusion design

The existing driver and all 722 translated source files remain unchanged.
`generate_all722.py` creates an auditable body/import overlay and a new
`repo/locale/tr/open-logic-all722.tex` driver. It does not run TeX.

## What is preserved

The normal reader's exact entry points, source bodies, import ordering,
conditional tags, grouping, section-level import arguments, formula macros,
and intentional repeated imports are retained. Import paths are resolved to
the closure's canonical source identity before generation. Document wrappers
are removed in precisely the way subfiles ignores child preambles; the one
raw fragment OLP-0660 is kept as a raw body. Only import instructions are
rewritten. Original files and the published reader are never overwritten.

The 642-count historical CSV describes olimport reachability, not every
possible include mechanism. The generator additionally resolves direct
subfile imports. Runtime execution, not a graph count, is the final coverage
authority.

## Supplemental material

After the normal reader, the new supplement first follows the original proof
theory and proof-search chapter trees. Eight nested rule tables retain their
parent namespaces and appear at their actual original insertion points.
Next every remaining OLP-0643 through OLP-0722 is attempted once. Supplemental
imports skip canonical identities already executed; normal imports never use
this deduplication, so intentional PL/FOL repeated exposition is retained.
Alternate part/chapter drivers retain their original headings/editorial text,
but do not reprint already included children.

Each of the extra 80 has a Turkish bookmark title, stable module destination,
and a visible source ID adjacent to its body. For a floating rule table the
anchor is inside the table, not on the preceding page. Ordinary source
sectioning commands retain their output; the supplement's optional `[tr]`
driver argument is not misused as a literal table-of-contents title.

## Explicit compatibility overlays

- OLP-0643 and existing OLP-0121 share the file ID `fol:axd:prv` (or the
  propositional variant). Only the supplemental OLP-0643 namespace becomes
  `prv-legacy`. The one explicitly qualified exercise reference to that
  module's own provability proposition receives the same namespace. Its
  prose and formulas are unchanged.
- A runtime label registry preserves the first label written when a
  supplemental alternate driver repeats an existing chapter/part label.
  These suppressed duplicate writes are logged. Normal reader labels retain
  their original behavior.
- The raw OLP-0660 fragment receives `pt:cut:intuitionistic-extra` context.
  Four unimported standalone rule tables receive `pt:seq:extra-rules` context.
- OLP-0653 uses a plain section command rather than the Open Logic wrapper;
  its module bookmark is inserted after that heading to prevent a preceding
  page destination. The same roundtrip verification covers this insertion.
- Source experimental/incomplete warnings remain. A short new reader note
  distinguishes their historical exclusion from their inclusion here.

## Evidence and validation

`SOURCE_IMPORT_MANIFEST.json` records every original target hash, extracted
body hash, overlay hash, source path, exact rewritten edge and compatibility
transformation. TeX writes `open-logic-all722.modules.csv` with actual include,
skip, anchor and retained-label events. Final QA must establish 722 distinct
include IDs, all 80 supplemental anchors and readable body content at their
destinations, source hash identity, successful compilation, and resolved
references/citations. Compile from `repo/locale/tr` using the parent's
machine-wide mutex runner; this design does not acquire or launch TeX.

The normal reader retains its deferred exercises. Supplementary exercises are
rendered inline using the already loaded problem theorem style, with separate
chapter-based numbering and hyperlink identities. Supplemental chapter-end
deferral hooks are disabled: otherwise an orphan module's pending exercise
could be silently lost when a subsequent alternate chapter clears the buffer.
All 30 supplemental problem objects stay with their source module body.
The generator proves original-body roundtrip identity after undoing every
declared import, namespace and anchor transformation. Final build QA must
inspect float placement, source experimental formula issues, and any new
undefined-reference warnings.

Build command inside the already-held mutex:

`latexmk -pdf -interaction=nonstopmode -halt-on-error -file-line-error open-logic-all722.tex`

## First-pass correction

The initial TeX attempt found an invalid digit-bearing command prefix.
All executable command names now use the alphabetic prefix `allmodules`.
Filenames and csname-managed registry keys retain `all722`. No original
translation content changed during this compatibility correction.

The second attempt completed the normal 642-module traversal before finding
that plain TeX aliases of xparse sectioning commands shared their underlying
implementation helpers. Renewing the wrapper then caused recursion. Original
section/part/chapter/label commands are now preserved with `NewCommandCopy`,
which copies the command implementations independently. The problem-theorem
alias does not redefine its source command and does not have this failure mode.

Runtime evidence uses literal commas, with exactly five columns: event, id,
source_path, page, context. TeX normalizes tab characters while tokenizing,
so the initial tab-separated diagnostic output was unsuitable for parsing.
The generator now validates that every source path, module ID and literal
label key contains no comma, quote or newline; the other columns contain
only controlled event names, page numbers and context names.

## Corrections following the first fully compiled reader

- `olpart[tr]` and `olchapter[tr]` used a language marker as the short title.
  The reversible overlay now redirects exactly those commands through aliases
  that retain their full Turkish titles in the contents and running heads.
  Any legitimate non-`tr` short title is preserved. Printed mathematical and
  prose bodies are not replaced.
- Memoir uppercased `N2i`/`G2i` inside mathematical running headings into
  Turkish dotted-capital-I strings. This accounted for all nine missing glyph
  warnings. `nouppercaseheads` preserves the source identifiers and proper
  sentence case; it is a header-format correction, not a formula edit.
- Supplemental bookmark depth is explicitly three; otherwise the default
  depth silently excluded the level-two module bookmarks from the outline.
- The duplicate-label guard is installed after cleveref's begin-document
  patch and wraps the full label operation, including its companion `@cref`
  metadata writes.
- OLP-0644's seven obsolete connective-property citations now target the
  equivalent frozen `seq:ppr` and `ntd:ppr` propositions. Conjunction item
  labels survive; disjunction and implication cases now share their enclosing
  proposition labels. Explicit `cref` targets also avoid empty labels produced
  by the legacy two-item `tagrefs` call. Target propositions and their actual
  labels were checked in the source and compiled auxiliary file.
- OLP-0714's two missing `prop:phi` citations now identify the existing
  `pl:axd:prv:prop:provability-exhaustive` result: the consistent-choice step
  is exactly its contrapositive. Its provability/inconsistency citation is
  fully qualified. OLP-0715's semantic-facts reference is fully qualified to
  `pl:syn:sem`, where its cited third fact actually occurs.
- The reader omits the generated photo-credit page only when the actual
  photo-credit list is empty. This wrapper is outside the 722 source bodies;
  any future nonempty list is displayed normally.

All source-level reference and heading rewrites are recorded individually
and undone by the independent 722-body roundtrip check. No reference repair
invents or changes a mathematical assertion, omits an unresolved passage,
or edits a frozen translation file.

The otherwise clean 1,199-page candidate had one pagination mismatch:
OLP-0660's destination preceded its visible marker by one page. This uniquely
unsectioned fragment now starts after an explicit page break, placing its
destination, visible module ID and actual source body together. The QA
condition is unchanged; no source text or formula is removed.

The empty-credit-page guard now tests the actual `.pcr` byte count through
the fixed reader engine's `pdffilesize` primitive. The earlier token-list
emptiness check admitted an endline from `CatchFile` and printed a heading
for a verified zero-byte file. For an empty or absent credit file, the new
guard still calls memoir's `@starttoc{pcr}` without the list heading, so its
normal end-document stream registration is retained. Consequently future
credits are not silently lost: nonempty files use the original `photocredits`
command, and newly generated credits appear on the following normal pass.
