# Start here / Buradan başlayın

## Türkçe

Bu depo, Open Logic Project'in sabitlenmiş İngilizce kaynağına dayanan **tam 722 modüllük Türkçe sürümdür**. Okunabilir ana ürün [00_OPENLOGIC_tr_COMPLETE_LINKED_READER_OLP-0722.pdf](reader/00_OPENLOGIC_tr_COMPLETE_LINKED_READER_OLP-0722.pdf) dosyasıdır.

[Okuyucu ön sayfa düzeltmesinin kanıt paketi](evidence/reader-frontmatter-correction-20260905/README.md), başlık sayfasından kaldırılan tek teknik satırı ve değiştirilmemiş çeviri gövdelerini belgeler.

Bu yeni uzman inceleme dizini, OLP-0068 üretim noktasına kadar kaydedilmiş **194/194 tarihsel terim kararını** güncel 722 hedef dosyanın tamamında arar. Sonlu eşleştirici 626 modülde en az bir tarihsel terim yüzeyi bulmuş, 96 modülde bulmamıştır; dolayısıyla 722 sayısı karar satırı olan modül sayısını değil, denetlenen çeviri kapanışını gösterir. 6,944 dizin satırının 2,404 tanesinde kesin PDF sayfası kanıtlanmıştır; 4,352 tanesinde kesin sayfa açıkça `pending`, 188 tanesi ise yerel ayar veya tarihsel kayıt konumu olduğu için `not_applicable` durumundadır. OLP-0069--0722 içindeki oluşumlar önceki terim kararlarının güncel kullanımlarıdır; bu dizin, o banttaki bütün özgün dil kararlarının tarihsel günlüğünün var olduğunu iddia etmez. Kurtarılan tarihsel kayıt reddedilen seçenekleri kaydetmediği için 194 kararın bütün `alternatives` dizileri açıkça boştur; daha sonraki kanıt tamamlama çalışması düzeltme sürümünü geciktirmeden bu alanları geliştirebilir.

- [Öncelikli inceleme](evidence/reviewer-index/PRIORITY_REVIEW.md)
- [Tam okunabilir karar dizini](evidence/reviewer-index/TRANSLATION_DECISIONS_FULL.md)
- [Oluşum CSV'si](evidence/reviewer-index/DECISION_OCCURRENCES.csv)
- [Makine JSON'u](evidence/reviewer-index/DECISIONS.json) · [şema](evidence/reviewer-index/translation-decision.schema.json) · [QA](evidence/reviewer-index/TRANSLATION_DECISION_QA.json)

İnsan incelemesi gelecekteki düzeltmeleri geliştirebilir; mevcut sürümün doğrulama veya yayın koşulu değildir.

## English

This repository is the **complete 722-module Turkish edition** derived from the pinned English Open Logic Project source. The readable primary product is [00_OPENLOGIC_tr_COMPLETE_LINKED_READER_OLP-0722.pdf](reader/00_OPENLOGIC_tr_COMPLETE_LINKED_READER_OLP-0722.pdf).

[Reader front-matter correction evidence](evidence/reader-frontmatter-correction-20260905/README.md) documents the one technical title-page line removed and the unchanged translation bodies.

The expert-review index represents **all 194 historical term decisions** recorded through the OLP-0068 production checkpoint and searches all 722 current target files. The finite matcher finds at least one historical-term surface in 626 modules and none in 96; 722 therefore denotes the checked translation closure, not a claim that every module has a decision row. Of 6,944 index rows, 2,404 have an exact proved PDF page, 4,352 keep the exact page explicitly `pending`, and 188 are locale-definition or historical-ledger loci for which a reader page is `not_applicable`. Occurrences in OLP-0069--0722 are current uses of the earlier decision universe; this does not claim an exhaustive historical log of every new linguistic decision made in that later band. The recovered historical ledger did not record rejected alternatives, so all 194 `alternatives` arrays are explicitly empty; a later evidence backfill may improve those fields without delaying this corrective release.

- [Priority review](evidence/reviewer-index/PRIORITY_REVIEW.md)
- [Full readable decision index](evidence/reviewer-index/TRANSLATION_DECISIONS_FULL.md)
- [Occurrence CSV](evidence/reviewer-index/DECISION_OCCURRENCES.csv)
- [Machine JSON](evidence/reviewer-index/DECISIONS.json) · [schema](evidence/reviewer-index/translation-decision.schema.json) · [QA](evidence/reviewer-index/TRANSLATION_DECISION_QA.json)

Expert review can improve a future reversible revision; it is not a validation or publication gate for this edition.
