# Reader front-matter correction / Okuyucu ön sayfa düzeltmesi

## Türkçe

Bu paket, 722 modüllük Türkçe okuyucunun başlık sayfasından okuyucuya yönelik
olmayan bir teknik satırın kaldırılmasını belgeler. Kaldırılan satır, sabitlenmiş
İngilizce kaynak revizyonunun tam Git commit kimliğiydi. Aynı kimlik teknik
yetki, kapanış ve karar kanıtlarında korunur. Türkçe çeviri gövdeleri,
matematiksel içerik, sayfa düzeni ve okuyucu kapsamı değiştirilmemiştir.

- Önceki PDF: 6.200.006 bayt; SHA-256
  `4af08c16e61aa058500cc1e96acb5d700c988718a729d4d6cbbe4aea9664df94`.
- Düzeltilmiş PDF: 6.200.714 bayt; SHA-256
  `b21aea2ea90b7129ba8a11e6548a4b8b116e1fa9ef3228d59414c5be58099675`.
- Kapsam: 1.198 sayfa, 722 modül, 904 yer imi, 3.172 iç bağlantı, sıfır
  bozuk iç bağlantı.
- Kesin kaynak farkı: `BEFORE_open-logic-all722.tex` ile
  `AFTER_open-logic-all722.tex` arasında yalnızca bir satır silinmiştir.

`READER_FRONTMATTER_QA.json` ana makine-okunur makbuzdur. İki bağımsız
deterministik derleme kaydı, PDF denetimi, etkilenen ilk sayfanın görsel
önce/sonra kanıtı, çıkarılmış metin karşılaştırması, sayfa kanıtı ve karar
dizini bağlama makbuzları bu klasörde bulunur. Önceki okuyucu tamamlama QA
dosyaları `PRIOR_READER_COMPLETE_*` adlarıyla tarihsel bağlam için korunur.
`INHERITED_ARCHIVE_MANIFEST_AND_PRIVACY_REPAIR.json`, kaynak ve kanıt
arşivlerinin üst düzey üye dizinlerinin nasıl onarıldığını ve tek bir derleme
günlüğündeki iki satır bölünmeli özel yol oluşumunun nasıl kaldırıldığını
belgeler; 722 çeviri gövdesi değişmemiştir.

## English

This bundle documents removal of one non-reader-facing technical line from the
title page of the complete 722-module Turkish reader. The removed line displayed
the full Git commit of the pinned English source. That exact revision remains in
the technical authority, closure, and decision evidence. No Turkish translation
body, mathematical content, pagination, or reader coverage changed.

- Previous PDF: 6,200,006 bytes; SHA-256
  `4af08c16e61aa058500cc1e96acb5d700c988718a729d4d6cbbe4aea9664df94`.
- Corrected PDF: 6,200,714 bytes; SHA-256
  `b21aea2ea90b7129ba8a11e6548a4b8b116e1fa9ef3228d59414c5be58099675`.
- Coverage: 1,198 pages, 722 modules, 904 bookmarks, 3,172 internal links,
  and zero broken internal links.
- Exact source delta: one deleted line between
  `BEFORE_open-logic-all722.tex` and `AFTER_open-logic-all722.tex`.

`READER_FRONTMATTER_QA.json` is the primary machine-readable receipt. This
directory also contains two deterministic build receipts, PDF QA, original-size
before/after visual evidence for the affected first page, extracted-text
comparison inputs, page-evidence QA, and the reviewer-index CSV inspection
receipt. The preceding reader-completeness QA is retained under
`PRIOR_READER_COMPLETE_*` names as historical context.

`INHERITED_ARCHIVE_MANIFEST_AND_PRIVACY_REPAIR.json` records the deterministic
repair of the source/evidence archives' top-level member manifests and removal
of two whitespace-split private-path occurrences from one build log. All 722
translated target bodies are unchanged.

The corrected reader remains a Turkish edition, not an Inter-Turkic edition.
Human review may inform a later revision but is not a validation or publication
gate.
