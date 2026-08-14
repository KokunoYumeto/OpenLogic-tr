# Source/adverse provenance ledger — complete Turkish corpus OLP-0722

Date: 2026-08-14  
Status: cumulative source/translation provenance record; not a build,
publication, or certification receipt.

## Authority and corpus boundary

- Frozen upstream: The Open Logic Project, official repository
  `https://github.com/OpenLogicProject/OpenLogic.git`, commit
  `9620cc73f9c8e0ad003c514a5d3748f29611c4c0`, tree
  `f67757bb9305b173634082ab4cefd5601a707a34`.
- Complete closure: every tracked `content/**/*.tex` at that commit, 722 files:
  642 canonical-reader-reachable files plus 80 deliberately retained non-reader
  files. `AUTHORITY.json` and `CLOSURE.csv` are the controlling records.
- At ledger generation, all 722 frozen source hashes replayed exactly and all
  722 corresponding `repo/locale/tr/...` targets were present and hash-bound in
  the regenerated closure. The English checkout remains byte-untouched.
- `AUTHORITY.json`: 1,835 bytes, SHA-256
  `2FD26B3F70589EA0A74E0639F67420093B788A260BA1F97E29F2CA1DB8F99275`.
  `CLOSURE.csv`: 1,058,824 bytes, SHA-256
  `4F0DFAA58C38B54C00180DE30AE09507D0DF9FBEA1E0ED6729DB7E2FA77AAC2F`.
  It contains 722/722 `translated_file_present` rows and 722 target hashes.
- `COMPLETE_0722_STRUCTURAL_QA.json`: 2,443,209 bytes, SHA-256
  `46F5FE080693D3A99DE234A9588C28D5A683D0FDACFA62AD2323AC3B8EB01499`.
  Result `PASS` for 722/722 files and locale-token coverage 66/66. Its stated
  scope is exact-source, target-presence, encoding, structural, localization-
  token, and selected sequence replay; semantic, build, text, and render
  evidence remain separate.

This record uses three distinct classes. A **source emendation** corrects a
specific defect in the frozen English material, only in Turkish. A **Turkish
repair** changes morphology, register, or exposition without alleging an
upstream defect. An **unresolved limitation** is disclosed rather than silently
filled. None of these is an edit to, or an endorsement by, upstream.

## Earlier provenance chain (OLP-0001--0068)

The detailed early findings are incorporated by reference, not duplicated:

| Record | Purpose | SHA-256 |
|---|---|---|
| `SOURCE_BUNDLE_CORRECTION_0010.md` | Withdraws one defective early source ZIP whose copied license text was altered; not an upstream-content defect. | `699BA789C9343D41E7B5C232EA77759C36640240322DE897148CCFF69D393BCB` |
| `SOURCE_ADVERSE_0019.md` | OLP-0011--0019. | `D67393A5B15B2626F330702383116FEC0563505DBB7341625CFE66E7BEF0C625` |
| `SOURCE_ADVERSE_0026.md` | Extends through OLP-0026. | `13A81E7C2839937B68CD1C5440895C024DDCEC4B33B7A73C27765E8678A7D9BA` |
| `SOURCE_ADVERSE_0040.md` | OLP-0031--0040 and foundational qualifications. | `C4680A780E2014A6ACF130003EFCF2DD30AB642BFCB9B30026384CC3507B74D9` |
| `SOURCE_ADVERSE_0048.md` | OLP-0041--0048. | `3CD7D46097D247409172050604A8EFEA6A7546F26B7131774B2A2E0996DFCF74` |
| `SOURCE_ADVERSE_0054.md` | OLP-0049--0054. | `D054017DA257BE35C99F6319783A38767278B2D295E7234267F0155300046C86` |
| `SOURCE_ADVERSE_0062.md` | OLP-0055--0062. | `58CF7624D6B9A1C539ED49C3F678CEB7742622F4B3CBDE328BF8F8B88764E973` |
| `SOURCE_ADVERSE_0068.md` | OLP-0063--0068. | `7D5CCD31E993C417778E3B867A59B4C547115938C7206314B4B8F50B607A0BF3` |

`repo/locale/tr/SOURCE_ADVERSE.md` is only a convenience condensation through
OLP-0068. The control records above retain the fuller evidence.

## Recovered middle-corpus production findings

No per-tranche control ledgers were written during the continuous run after
OLP-0068. The following range reports were nevertheless preserved in the task
record and are bound here to the exact OLP-to-path/source-hash mapping in the
regenerated `CLOSURE.csv`. They are grouped at the granularity actually
reported; a more exact file attribution is made only where the report and the
current pair support it.

### OLP-0126--0137 — first-order completeness

The affected files are within
`content/first-order-logic/completeness/`:

- OLP-0130 `henkin-expansions.tex`: an existential witness step uses
  `\prvEx`, not the source's universal-proof form `\prvAll`.
- OLP-0131 `lindenbaums-lemma.tex`: the empty-subset base case is made
  explicit.
- OLP-0132 `construction-of-model.tex`: the formula metavariable is `B` in the
  reported model-construction step.
- OLP-0133 `identity.tex`: a duplicated comma is removed and the representative
  used with `R(t')` is made consistent.
- OLP-0135 `compactness.tex`: the empty-`\Delta` case is separated before a
  “largest index” is chosen.
- OLP-0136 `compactness-direct.tex`: propositional-logic tag scope is restored
  around the direct compactness argument.

OLP-0126--0129, OLP-0134, and OLP-0137 are in the reviewed range, but this
report does not assert a separate source emendation for them.

### OLP-0286--0288 — arithmetized proof predicates

- OLP-0286 `content/incompleteness/arithmetization-syntax/proofs-in-lk.tex`:
  malformed variables/components in the `\Gn`, `\EndSeq`, `\InitialSeq`, and
  `\Deriv` encodings, including the conclusion component, are made mutually
  consistent.
- OLP-0287
  `content/incompleteness/arithmetization-syntax/proofs-in-nd.tex`: the
  natural-deduction correctness condition
  repairs formula bracketing and the child index.
- OLP-0288
  `content/incompleteness/arithmetization-syntax/proofs-in-ax.tex`: the bound is
  `j<i`, the `x/c` roles are kept distinct, and the `\hCond` recursion uses the
  intended recursive component.

### OLP-0312--0321 — incompleteness and provability

Within `content/incompleteness/incompleteness-provability/`, the range report
records these formal repairs: bare theory `T` is typed as `\Th{T}` where a
theory object is required; `\Prf`/`\Prov` are replaced by the object-language
forms `\OPrf`/`\OProv`; `\gn{G}` is corrected to `\gn{!G}`; “axiomatized” is
corrected to “axiomatizable”; `\OCon` receives the required typing; and a bad
cross-reference plus another bare-`T` typing site are corrected. The report did
not preserve a trustworthy one-to-one allocation of every item among
OLP-0313--0321, so this cumulative ledger does not invent one.

### OLP-0323--0335 — second-order syntax, semantics, and metatheory

- OLP-0323--0329, under
  `content/second-order-logic/syntax-and-semantics/`: malformed `\Obj` argument
  bracing is repaired; the assignment clause supplies the omitted
  relation/predicate assignment; and the finite-enumeration construction maps
  its last element as required rather than leaving that case undefined.
- OLP-0330--0335, under `content/second-order-logic/metatheory/`: the binding of
  `u(w')` and the domain-closure condition are repaired; malformed `\Sat`
  argument braces are closed; a compactness step uses `\Gamma_0` rather than
  `\Gamma` and treats the empty finite subset separately. One duplicated
  upstream label is intentionally retained as source evidence, not silently
  renamed.

### OLP-0407--0449 — normal modal logic

- OLP-0407--0418, `content/normal-modal-logic/syntax-and-semantics/`: removes a
  stray parenthesis from `\defIf`; distinguishes `\prvIf` from `\prvIff` and
  fixes `\prvBox`/substitution scope; restores an omitted world index; repairs
  `\prvNot`, biconditional, and `\mSat` forms; replaces a caption placeholder;
  and closes the model-tuple braces.
- OLP-0419--0426, `content/normal-modal-logic/frame-definability/`: fixes copied
  metadata, missing model/relation data in nonreflexive examples and their
  irreflexivity loops, a missing world index, a false/true typo in `\prvTrue`,
  and brace scope.
- OLP-0427--0440, `content/normal-modal-logic/axioms-systems/`: corrects `B` to
  the formula metavariable `!B`, a `Log`/schema form to the intended `Ax` form,
  reversed rewrite prose, missing tags/formal replays/reference order, and an
  accidentally commented `Rule-T` item.
- OLP-0441--0449, `content/normal-modal-logic/completeness/`: repairs a malformed
  `\Sigma \Proves` judgment, the negation clause for complete-consistent sets,
  a `B_k` index, a missing modality annotation/backslash, the truth-lemma
  citation, and a problem tag.

These are exact-source dispositions in the Turkish targets, not claims that the
upstream modal-logic development has been globally re-proved.

### OLP-0475--0490 — temporal and epistemic logic

Within `content/applied-modal-logic/`, the preserved report records repaired
chapter hooks; the `\Ftemp` macro; the spelling of “Hintikka”; the agent set
`G`; public-announcement grammar and its tag; the announcement formula
`[!A]!B`; and a false equality for the restricted model. The corrections lie
in the temporal-logic and epistemic-logic files mapped to OLP-0475--0490 in the
closure; the report does not justify a finer item-by-item source claim.

## Later source emendations verified in the settled targets

For every entry below, the Turkish target is exactly
`repo/locale/tr/<frozen source path>`. Source hashes are those in the complete
closure.

### OLP-0672 — normalization introduction

Source: `content/proof-theory/normalization/introduction.tex`, SHA-256
`e7d822cb037c302eab15903e0b9111f4143cf9feab4dbb2e22e8c3411bc88f89`.

The source uses `\delta_1` both for the proof of `A` and for the proof of
`A \lif B`, then labels both displayed subproofs `\delta_2`. Turkish reserves
`\delta` for the conditional proof, `\delta_1` for the proof of `A`, and
`\delta_2` for the derivation of `B`, including the corresponding displayed
labels. This repairs identifiers only; the reduction described is unchanged.

### OLP-0675--0676 — permutation and reduction conversions

- OLP-0675, `content/proof-theory/normalization/permutations.tex`, source
  SHA-256
  `594005d50c359946d7ff673f0b6eb86dcf0c56e8cd9bd001a66981bdf6602310`:
  the introductory formula says `A \ident B \lor C` although the displayed
  elimination and both branches use `B \land C`; Turkish uses the conjunction.
  One literally repeated active implication-permutation row is retained once.
  The exercise and later eigenvariable prose use the undefined/mismatched
  `\Elim{\exists}` beside the actual `\Elim{\lexists}` rule; Turkish uses the
  defined latter form consistently.
- OLP-0676, `content/proof-theory/normalization/reductions.tex`, source SHA-256
  `97d1a7e894ca1acaceafe77023cda83c19b85717dc5e97f5b5bd0ef751d0d419`:
  the displayed falsehood/disjunction reduction labels both case assumptions
  `x` and fails to show the two-label discharge. Turkish uses `B^x`, `C^y` and
  `\DischargeRule{\Elim{\lor}}{x\,y}`. The formulas and reducts otherwise stay
  fixed.

### OLP-0678 — translation between normal deduction and G2i

Source: `content/proof-theory/normalization/translations.tex`, SHA-256
`a4c49477d57cd7f79e43992953978e3c672db43ff1d0010edb42603665ba34f4`.

- The opening corollary starts from `\Log{G2i} \Proves \Gamma \Sequent
  \Delta` but concludes with `C` and calls the result an `N2c` proof despite
  the section and cited proposition being the G2i-to-N2i translation. Turkish
  states `\Gamma \Sequent C` and `N2i`.
- The proposition maps conclusion `\lfalse` to an empty succedent. In the
  conjunction and disjunction cases the source nevertheless right-weakens the
  empty succedent back to `A`; Turkish leaves it empty. In the implication
  case, right weakening is retained only when `D=\lfalse` to supply the first
  premise required by the implication-left rule; no `A` is inserted when
  `A=\lfalse`, so the second premise and conclusion stay empty.
- The prose assigns the transformed second subproof context `\Gamma_1'` while
  its construction and final rule require `\Gamma_2'`; Turkish uses
  `\Gamma_2'`.

These are local proof-tree repairs, not a new normalization theorem.

### OLP-0684 — tableau start for a sequent

Source: `content/proof-theory/proof-search/tableaux.tex`, SHA-256
`21be4b2a208c359f5fd90b18911e1363fbb03292d09a8d8a756707abae255884`.

For `A,B \Sequent C,D`, the source starts with `T A`, `T B`, `F C`, but
incorrectly `T D`. A countermodel search must falsify both succedent formulas;
Turkish uses `F D`. Later tableau-to-G3c terminology is consistently rendered
as sequent-calculus terminology.

### OLP-0687 — propositions-as-types normalization

Source: `content/proof-theory/propositions-as-types/normalization.tex`,
SHA-256
`abb9f9bc4d5a50031e5db507cf7a164d07625cccefc98a9c2c90ae0eb03223cc`.

- The disjunction-redex rank refers to unbound `A,B`; Turkish uses the displayed
  branch types `A_1,A_2`. The maximum-rank formula now includes `{0}`, as the
  prose requires for a term with no redex. The substitution discussion states
  the rank of the resulting redex directly instead of identifying it with the
  rank of the variable `x`; a stray closing parenthesis is not reproduced.
- The source's proof measures three displayed beta-redex families, but its
  opening and theorem sound like full natural-deduction normalization. Turkish
  scopes the theorem to those three families and explicitly excludes
  permutation conversions from that measure.
- Strong normalization is asserted but not proved in the source. Turkish
  labels it a standard stronger result and states that the subsequent argument
  uses it as an assumption.
- The weak Church--Rosser argument omits the identical-redex case, says redexes
  cannot overlap and immediately allows nesting, and its projection example
  ends at `O_2` where both paths reach `O_1'`. Turkish adds the identical case,
  distinguishes disjoint positions from nesting, uses `O_1'`, calls the proof a
  sketch, and discloses the omitted finite critical-pair audit.
- In the Newman-lemma argument, the common reduct `N'''` need not itself be
  normal. Turkish first reduces it to a normal form `P`, then compares `P` with
  the two alleged distinct normal forms before iterating the contradiction.

The critical-pair enumeration and a proof of strong normalization remain
unresolved source/pedagogical gaps; the Turkish edition does not claim to have
supplied them.

### OLP-0693--0694 — type-system cross-reference and conjunction

- OLP-0693, `content/proof-theory/propositions-as-types/rules-tN3.tex`, source
  SHA-256
  `920460915c6fb200b4ab1a785aa84affce15e404b04512f11319b5976a2a66c0`:
  the caption names `tN3ip`, but the table label says `tab:tN2ip`. Turkish
  labels it `tab:tN3ip`.
- OLP-0694,
  `content/proof-theory/propositions-as-types/sequent-natural-deduction.tex`,
  source SHA-256
  `6fbab7c45c11e351116316cfcfd77f71931428c35c32303dbd93413235eb679a`:
  the opening example first writes `A \land A`, while the next sentence and
  both displayed projections use `A \land B`. Turkish uses `A \land B`
  throughout.

### OLP-0697--0699 — typing, weakening, and XOR rules

- OLP-0697, `content/proof-theory/propositions-as-types/types.tex`, source
  SHA-256
  `0129408d5454176b6a10e8bd7cf503d66373d3d2fa13c9f3c2fb517de665b7c6`:
  the disjunction typing clause introduces binders `x,y` but builds its case
  term with `x_1,x_2`; Turkish uses `x,y`. The proposition that every term has
  exactly one type is false for untypable terms; Turkish states the proved
  uniqueness claim as “at most one type,” equivalently uniqueness for a
  well-typed term. Its table reference follows OLP-0693's corrected `tN3ip`
  label.
- OLP-0698,
  `content/proof-theory/sequent-calculus/admissible-derivable.tex`, source
  SHA-256
  `42bd3c0e07c6be9b6c82e85adee3933c295c10411c3d60a4778221db0b864862`:
  the proposition covers both right and left weakening, but the written
  induction develops only right weakening. Turkish explicitly records the
  symmetric left construction—add the formula to every antecedent—without
  presenting it as a separate theorem.
- OLP-0699,
  `content/proof-theory/sequent-calculus/interpretation-rules.tex`, source
  SHA-256
  `54866e2d7c5736d5719a516e6193f8e805fb78504089ec01844d0b7cc5bd79db`:
  the second XOR rule has `A\oplus B` in the antecedent but is labelled a right
  rule. Turkish labels it `\LeftR{\oplus}`; the first, succedent rule remains
  `\RightR{\oplus}`.

### OLP-0700--0722 — final closure tranche

The independent final-tranche pass validated the already-applied formal repairs
in OLP-0701, OLP-0702, OLP-0703, OLP-0707, and OLP-0713, and made the following
source dispositions explicit:

- OLP-0705 `content/proof-theory/sequent-calculus/rules-G1i.tex`, source
  SHA-256
  `0d23c141ee1f2cd75dd6eced909f5952ac2103ff49991cae288bd4da57be840b`;
  OLP-0708 `content/proof-theory/sequent-calculus/rules-G3i.tex`, SHA-256
  `322da67057a42c3ebe53c965b06a4df8ae914b873779e9d7125546312f84fa6f`;
  OLP-0709 `content/proof-theory/sequent-calculus/rules-LK.tex`, SHA-256
  `c4e853e27fbfcf7386dd22a73d10eac3c507c35016c4368bae72c5cd9edfa55d`;
  and OLP-0710 `content/proof-theory/sequent-calculus/rules-mG3i.tex`, SHA-256
  `a7b114259de1d1770b989ff4e9ad2d94f6cea2ebc8bd570ee25f35739b349a3c`:
  stale copied table labels and system names are corrected to the system each
  file actually presents.
- OLP-0708's single-succedent G3i right-disjunction source rule has an invalid
  premise. Turkish gives the indexed schema
  `\Gamma \Sequent !A_i` over `\Gamma \Sequent !A_1 \lor !A_2`, for
  `i=1,2`.
- OLP-0710's mG3i right-universal conclusion restores the omitted `\Delta`
  context.
- OLP-0713 `content/proof-theory/sequent-calculus/translations.tex`, source
  SHA-256
  `fe035ce79aae2c23f8756a69fc344736ff35e02f1ce9a40fe957ea55fab5b7d0`:
  the contradiction involving an arbitrary G3c axiom is corrected.
- OLP-0714
  `content/propositional-logic/syntax-and-semantics/completeness.tex`, source
  SHA-256
  `15c4d35ccd3a79ae4e165ca8c5195d8190a81e7fff32cf12fdd8279a35d2336c`:
  the malformed truth-lemma argument is repaired.
- OLP-0716
  `content/second-order-logic/syntax-and-semantics/language-of-sol.tex`, source
  SHA-256
  `b334d1a0decdc9ded917dc1b9b5e49dfafc14c67949233c912f7b19b432121d8`:
  the omitted arity scope is supplied.
- OLP-0718
  `content/sets-functions-relations/inductive-defs-proofs/introduction.tex`,
  source SHA-256
  `0a3327920db03385bcae0062435654fd82227d5e622e87f4194628de4fdbddda`:
  the standalone document-class path is corrected in the Turkish target.
- OLP-0721 `content/sets-functions-relations/sets/proofs-about-sets.tex`, source
  SHA-256
  `394714c03cea3d400ca79ed47f0c4b47c496cb714a3fd8e5c03debec1ab55161`:
  the editorial include/path is corrected.

Residual caveats from the same pass are not silently “fixed”:

- OLP-0711 `rules-proofs.tex`: the displayed height bound `[4]` is valid but
  non-sharp.
- OLP-0716 `language-of-sol.tex`: the source's expressivity claim is broader
  than the construction established there.
- OLP-0717 `isomorphic-functions.tex`: the stated isomorphism discussion is the
  special case of a language with one binary relation, not a general account of
  arbitrary signatures.

## Turkish-only architecture and repairs

These decisions do not allege defects in the English authority.

- The OLP token parser consumes an immediately attached `s` as its English
  plural switch and cannot realize Turkish case, possessive, or harmony. The
  production passes therefore use `{}` barriers, exact token calls, or Turkish
  sentence recasts instead of exporting literal suffix strings. The locale
  supplies `depth` as `derinlik`; `a/A` article switches are empty because
  Turkish has no indefinite article in that position.
- OLP-0163
  `content/first-order-logic/syntax-and-semantics/satisfaction.tex`, source
  SHA-256
  `e44b0bea8c5d130077516bc8d757f46d4b337517aab77049841581313820fd32`:
  the English `cases` row ends with the required `\\`; the Turkish target had
  transcribed only one backslash, exposing the next row's `&` as an extra
  alignment tab. The target restores the row break. This is a Turkish
  structural repair, not an upstream emendation. A follow-up static replay
  found one alignment tab per logical row in all 95 Turkish `cases` blocks and
  source-matching signatures for all 28 `array` blocks; the sole remaining
  `cases` signature difference is the already-declared intentional zero-product
  row in arithmetization `cuts.tex`.
- Final compile/static review also repaired these target-only TeX transcriptions
  to the pinned source forms:
  - OLP-0081 `content/first-order-logic/sequent-calculus/soundness.tex`, source
    SHA-256
    `d9f6180bee35f29553144b6eca5a1eb1916e0262dcdc8c30f50193a53d8001fa`:
    the two added `prvTrue`/`prvFalse` sentences now use the source-compatible
    math-mode switch
    `\iftag{FOL}{$\Struct M$}{$\pAssign{v}$}`.
  - OLP-0205 `content/model-theory/lindstrom/abstract-logics.tex`, source
    SHA-256
    `ab605690e24fffb499ee9523a80e4cb422d9e7ac7beb0b86cdd7a4eba6edba9b`;
    OLP-0206 `content/model-theory/lindstrom/ls-property.tex`, source SHA-256
    `3e7b3f84adf951cd912972a2d7ac5908d7d3c0130f881caf70eec03a5080efe3`;
    and OLP-0207 `content/model-theory/lindstrom/lindstrom-proof.tex`, source
    SHA-256
    `8e407658f1e11431ad859dd166b2de535e6bab8da9b1a28b9549fd97b2ec87fc`:
    invalid `\notmodels_L` is restored to source-equivalent
    `\not\models_L`.
  - OLP-0532 `content/set-theory/story/russells-paradox-again.tex`, OLP-0533
    `content/set-theory/story/predicativity.tex`, OLP-0535
    `content/set-theory/story/urelements.tex`, OLP-0536
    `content/set-theory/story/grundgesetze.tex`, and OLP-0538
    `content/set-theory/z/story.tex`: erroneous math-mode wrappers are removed from
    citations, matching the valid source use. Their exact full source paths and
    hashes remain bound by their OLP rows in `CLOSURE.csv`.
  These are Turkish target repairs; none is reported as an upstream defect.
- Formal proof/derivation, semantic/syntactic, and proof-system distinctions
  remain typed: `ispat` versus `türetim`, `mantıksal gerektirme` versus
  `türetilebilirlik`, and distinct `sağlamlık`, `tamlık`, `tutarlılık`, and
  `geçerlilik`. `sekant/sekant hesabı`, `doğal tümdengelim`, `tableau`,
  `ana formül`, `formül oluşumu`, and `tip` are kept consistent in the late
  proof-theory tranche.
- `TERMS.csv` is the 194-row OLP-0068 checkpoint terminology ledger (41,661
  bytes, SHA-256
  `FB88987E1E19EB33AFA5BADD538F8624DD4DF93C3952C5646C6E439FD7A07818`);
  it is evidence for the architecture, not a complete 722-file glossary.
  Detailed rationale remains in `TERMINOLOGY_EVIDENCE_*.md` and the earlier
  adverse ledgers.
- `TURKIC_INTERLANGUAGE_NOTEBOOK.md` is an append-only observation scaffold,
  not a Turkic pivot or reader. Its typed distinctions cover morphology,
  proof/metalogical vocabulary, compactness, model theory, representation,
  computability, and refutability. It supplies no Turkish-derived default for
  Azerbaijani, Kazakh, Kyrgyz, Uzbek, Uyghur, or any other standard.

## Unresolved coverage and claim limits

1. No standalone itemized source-adverse ledger after OLP-0068 existed before
   this reconstruction. The middle- and late-corpus sections preserve the
   production reports that survived in the task record and were checked against
   the current pairs. They are not an exhaustive defect catalog for every file
   in OLP-0069--0722. Absence from this ledger is not evidence that a frozen
   source file is defect-free.
2. The complete closure intentionally includes upstream draft, incomplete,
   alternate, router, and non-reader material. Translation completeness does
   not convert those sources into a uniform teaching edition or silently fill
   omitted proofs.
3. Separate upstream photo/portrait repositories are not pinned by this
   closure and require their own rights review if later used.
4. `CLOSURE.csv` is now regenerated with 722/722 exact target identities and
   `COMPLETE_0722_STRUCTURAL_QA.json` is `PASS`. The convenience aliases
   `TARGET_SHA256SUMS.txt`, `QA.csv`, `STATUS.md`, `CURSOR.md`, and `BUILD.md`
   still point to the OLP-0068 checkpoint until final freeze/build work
   supersedes them. This ledger does not invent a target aggregate, page count,
   build result, release identity, or public readback.
5. Review is independent model review, not institutional certification. No
   native-human review is required or represented as a publication gate.
