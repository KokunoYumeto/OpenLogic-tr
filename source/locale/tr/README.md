# Open Logic Project - Turkish localization

This is the complete Turkish (`tr`) localization of the frozen Open Logic
Project content closure.

## Frozen scope

- Authority commit:
  `9620cc73f9c8e0ad003c514a5d3748f29611c4c0`
- Authority tree:
  `f67757bb9305b173634082ab4cefd5601a707a34`
- Coverage: OLP-0001 through OLP-0722, exactly 722/722 content files
- Missing scope inside the frozen closure: none
- Stable Turkish concept DOI: `10.5281/zenodo.21921844`
- Exact release DOI: `10.5281/zenodo.21927145`

The complete reader imports `content/open-logic-about.tex` and
`content/content.tex`, whose ordered import graph reaches the full configured
reader. The remaining frozen non-reader modules are retained as editable
Turkish source and are enumerated by the same closure.

## Build

Overlay this directory on `locale/tr/` in the exact upstream checkout, then
run from that directory:

```powershell
latexmk -pdf -interaction=nonstopmode -halt-on-error -file-line-error open-logic-complete.tex
```

The repository-level `build/BUILD.ps1` performs the checkout, overlay, and
build. The release driver contains no English content fallback.

## Audit surface

- `TRANSLATION_MANIFEST.csv`: source/target identity and QA state for 722 files
- `TARGET_SHA256SUMS.txt`: exact Turkish target hashes
- `TERMINOLOGY.csv`: reusable Turkish terminology decisions
- `SOURCE_ADVERSE_0722.md`: disclosed frozen-source emendations and limits
- `open-logic-config.sty` and `open-logic-locale.sty`: Turkish locale mappings

Independent model/agent review, exact source replay, deterministic structural
checks, successful compilation, extracted-text checks, and all-page visual
inspection close this release. Human or native-language review is not required
or claimed. This independent adaptation is not endorsed by the Open Logic
Project.
