# Inherited title-page logo dictionaries

Reader SHA-256: `4af08c16e61aa058500cc1e96acb5d700c988718a729d4d6cbbe4aea9664df94`.

pypdf emits three duplicate `/Group` dictionary warnings. Direct byte inspection
locates all three in the title-page PDF logo XObjects for `assets/logos/by.pdf`,
`assets/logos/cc.pdf`, and `assets/logos/openlogic-logo-bw.pdf`. The upstream
inclusion attributes and embedded logo transparency dictionaries both supply
that key. This is not a mathematical-text, source-inclusion, or link error.

The PDF parses and renders successfully. The title-page logos and attribution
were visually inspected, with no observed visual defect. This inherited
transparency-dictionary limitation is documented, not represented as absent.
The frozen upstream styles and bibliography were checked unchanged against
source commit `9620cc73f9c8e0ad003c514a5d3748f29611c4c0`.
