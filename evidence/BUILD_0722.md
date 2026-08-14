# Build receipt - complete Turkish Open Logic edition

Date: 2026-08-14  
Result: **PASS**

## Build identity

- Frozen source commit:
  `9620cc73f9c8e0ad003c514a5d3748f29611c4c0`
- Driver: `repo/locale/tr/open-logic-complete.tex`, 1,299 bytes,
  SHA-256 `0EA04EA75FF15BE5B610447739CE836DB466CF026CDD2C92F8028A3FF0711B5F`
- Locale configuration: `open-logic-config.sty`, 10,043 bytes,
  SHA-256 `05ECC009AAB5C5585E3E9D9676B39D1570ABBD6643710A2C291B5693E55219E1`
- Locale layer: `open-logic-locale.sty`, 4,758 bytes,
  SHA-256 `B81A7A7AA62A2180E3C27BAF367B46A4B19A4AE3E0DC6E4EBF0D7EC96F3C51C7`
- Command:
  `latexmk -pdf -interaction=nonstopmode -halt-on-error -file-line-error open-logic-complete.tex`
- Engine recorded by the PDF: MiKTeX pdfTeX 1.40.29
- Exit status: 0

## Final reader

- Path:
  `output/pdf/Open_Logic_Project_Turkish_COMPLETE_OLP-0722_20260814.pdf`
- Pages: 1,037
- Bytes: 5,470,171
- SHA-256:
  `2D9939692A971EDF468D3B41F38C57283C046BE9D110783CF50D10CDB3152900`
- PDF parse: 1,037 pages; not encrypted

## Diagnostics

- Undefined control sequences: 0
- LaTeX errors: 0
- Fatal/emergency stops: 0
- Missing characters: 0
- Unresolved references: 0
- Unresolved citations: 0
- Overfull box diagnostics: 250

The overfull diagnostics are disclosed rather than silently omitted. The final
all-page render QA is `PASS`: every page is accounted for and no clipping,
overlap, corruption, crop, orientation, or legibility defect was found. See
`RENDER_QA_0722.md` for the exact final-render disposition.

## Build evidence

- Log: `repo/locale/tr/open-logic-complete.log`, 2,290,271 bytes,
  SHA-256 `3C93282140F5593B2C9C2C64CEDE86E128F5B91EC201B5DE050EAAADE000FCA4`
- Dependency trace: `repo/locale/tr/open-logic-complete.fls`, 387,389 bytes,
  SHA-256 `D9095CEA4E2CAEC0F1AD5481E6B6BB2A8B86603E48195A16017659DF6F8F2574`
- Extracted-text identity and scans: `TEXT_QA_0722.md`
- Visual disposition: `RENDER_QA_0722.md`

This receipt closes the local build only. It does not claim Git publication,
Zenodo submission, or public readback.
