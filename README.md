# Open Logic Project — Türkçe: *Open Logic Text* matematiksel mantık kitabının Türkçe çevirisi

[Open Logic Project](https://openlogicproject.org/) tarafından hazırlanan matematiksel mantık ders kitabı *Open Logic Text*'in Türkiye Türkçesine, Latin harfleriyle yapılmış eksiksiz çevirisi: sabitlenmiş kaynak sürümündeki 722 içerik biriminin tamamı, 1.198 sayfalık tek PDF ve düzenlenebilir LaTeX kaynakları.

[**Türkçe kitabı oku veya indir — PDF, 1.198 sayfa**](https://github.com/KokunoYumeto/OpenLogic-tr/releases/download/tr-olp-0722-reader-frontmatter-correction-20260905/00_OPENLOGIC_tr_COMPLETE_LINKED_READER_OLP-0722.pdf)

[Türkçe LaTeX kaynakları — ZIP](https://github.com/KokunoYumeto/OpenLogic-tr/releases/download/tr-olp-0722-reader-frontmatter-correction-20260905/01_OPENLOGIC_tr_EDITABLE_SOURCES_OLP-0722.zip) · [Bu PDF'nin derleme girdileri — ZIP](https://github.com/KokunoYumeto/OpenLogic-tr/releases/download/tr-olp-0722-reader-frontmatter-correction-20260905/04_OPENLOGIC_tr_READER_CORRECTION_OLP-0722.zip) · [Bütün indirmeler](https://github.com/KokunoYumeto/OpenLogic-tr/releases/tag/tr-olp-0722-reader-frontmatter-correction-20260905)

## Nasıl yapıldı

Türkçe metin yapay zekâ tarafından çevrilmiştir; çeviri kaydındaki model ve çalışma düzeyi **OpenAI Codex — GPT-5.6 Sol, Ultra** olarak belirtilir. Bu tanıtım sayfasının ve katalog metninin düzenlenmesi: **OpenAI Codex — GPT-6 Astra, Ultra**. [Terim ve çeviri tercihleri dizini](evidence/reviewer-index/TRANSLATION_DECISIONS_FULL.md) 194 kayıtlı terim kararını ve 6.944 metin konumunu kapsar; [öncelikli inceleme konuları](evidence/reviewer-index/PRIORITY_REVIEW.md) ayrıca erişilebilirdir.

## Durum

Çeviri 722 birimin tamamını kapsar. İnsan uzmanlar metni henüz incelemedi ve terim dizini bütün cümlelerin bağımsız bir dil incelemesi değildir; hatalar kalmış olabilir. Çeviriyle ilgili hata veya öneriler [bu deponun sorunlar sayfasına](https://github.com/KokunoYumeto/OpenLogic-tr/issues) iletilebilir.

## İçerik

Kitap küme, bağıntı ve fonksiyonlardan başlayarak önermeler ve birinci derece mantık, biçimsel kanıt sistemleri, model kuramı ve hesaplanabilirlik gibi konuları içerir. Tanımlar, teoremler, kanıtlar, örnekler, alıştırmalar ve kaynakça metnin parçasıdır.

Tek PDF, ana okuma sırasındaki 642 birimi ve alternatif ya da ek malzeme niteliğindeki 80 birimi içerir. Son gruptaki malzeme aynı kitabın ek bölümündedir. İçindekiler, yer imleri ve bölüm bağlantılarıyla kitap içinde gezilebilir. Kaynak metindeki taslak veya tamamlanmamış tartışmaların tümü bitirilmiş birer bölüm olarak sunulmaz.

Dil kodu `tr`, yazı sistemi Latin harfleridir. Bu baskı diğer Türk dillerinin çevirisi sayılmaz; yapay bir ortak dil olan [Inter-Turkic araştırma baskısından](https://github.com/KokunoYumeto/canon-first-turkic-interlanguage-openlogic) ayrıdır.

LaTeX kaynakları modülerdir. Yukarıdaki iki ZIP birlikte kullanılır: ilki Türkçe içerik dosyalarını, ikincisi bu PDF için gerekli okuyucu girdilerini ve derleme düzenini sağlar. Arşivleri aynı boş dizine açıp `build/BUILD_ALL722.ps1` komut dosyasını çalıştırın. Derleme, betikte belirtilen özgün Open Logic kaynak sürümünü de kullanır; Git, PowerShell 7, MiKTeX ve latexmk gerektirir.

Bu yayında ayrıca indirilebilen tek dosyalık birleştirilmiş LaTeX veya EPUB yoktur. PDF, akışkan bir EPUB değil, sabit sayfa düzenli bir kitaptır. Depo içeriği için [buradan başlayın](START_HERE.md).

## Kaynak ve emeği geçenler

Özgün eser Open Logic Project ve katkıda bulunanlarına aittir; özgün kaynakların yazar, katkı ve lisans bildirimleri geçerliliğini korur. Bu bağımsız çeviri, Open Logic Project tarafından onaylanmış resmî bir baskı olarak sunulmaz. [Diğer Open Logic dil baskıları](https://kokunoyumeto.github.io/OpenLogic-translations/#openlogic-tr).

## Lisans

Depodaki [CC BY 4.0 lisansı](LICENSE) ve ilgili bileşenlerin özgün bildirimleri korunur.
