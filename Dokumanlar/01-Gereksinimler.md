Bu bölümde, geliştirilecek olan "Dava ve Mahkeme Yönetim Sistemi" veri tabanının kapsamı, varlıkları, ilişkileri ve detaylı gereksinimleri açıklanmıştır. 



1.1. Proje Amacı ve Kapsamı

Projenin amacı, dava süreçlerinin başından sonuna kadar (tevzi, duruşma, karar, temyiz) dijital olarak yönetilmesini sağlayan, tarafların, belgelerin, duruşmaların ve adli personelin etkin bir şekilde takip edildiği, güvenli, performanslı ve güvenilir bir ilişkisel veri tabanı sistemi tasarlamaktır. Sistem, farklı kullanıcı rollerine (Hakim, Katip, Yönetici) göre yetkilendirilmiş erişim sunacaktır.



1.2. Temel Varlıklar (Entities) ve Nitelikleri (Attributes)

•Dava: (DavaID \[PK], EsasNo, DavaTürü, YargıYolu, Konu, AçılışTarihi, DavaAşaması, Durum, MahkemeID \[FK])

•Taraf: (TarafID \[PK], Ad, Soyad, TC\_KimlikNo / VergiNo, Adres, İletişimBilgileri)

•Dava\_Taraf (n:m): (DavaID \[FK], TarafID \[FK], Rol (Davacı, Davalı, Vekil, Müdahil))

•Avukat (Vekil): (AvukatID \[PK], BaroNo, TarafID \[FK] - Taraf tablosuyla ilişkilendirilebilir veya ayrı tutulabilir)

•Mahkeme: (MahkemeID \[PK], MahkemeAdı, MahkemeTürü (Asliye Hukuk, Ceza vb.))

•AdliyePersoneli (Kullanıcı): (PersonelID \[PK], Ad, Soyad, Rol (Hakim, Savcı, Zabıt Katibi), KullaniciAdi, Sifre)

•Duruşma: (DurusmaID \[PK], DavaID \[FK], DuruşmaTarihi, Saat, DuruşmaTutanagi)

•AraKarar: (AraKararID \[PK], DurusmaID \[FK], KararMetni, KararTipi (Keşif, Bilirkişi), YerineGetirilmeDurumu)

•Belge: (BelgeID \[PK], DavaID \[FK], BelgeAdı, BelgeTürü (Dilekçe, Tutanak, Karar), DosyaYolu, YüklemeTarihi)

•Karar: (KararID \[PK], DavaID \[FK], GerekceliKararMetni, KararTarihi, KesinlesmeDurumu, KesinlesmeTarihi)

•MaliBilgiler: (MaliID \[PK], KararID \[FK], VekaletUcreti, YargilamaGideri)

•AuditLog (Denetim Kaydı): (LogID \[PK], KullaniciID \[FK], IslemTipi, IslemTarihi, Aciklama)



1.3. Varlıklar Arası İlişkiler ve Sayısal Kısıtlamalar

•Dava ve Taraf (n:m): Bir (n) davada birden fazla (m) taraf (davacı, davalı vb.) olabilir. Bir (n) taraf (örn: bir avukat veya bir şirket) birden fazla (m) davada farklı rollerde yer alabilir.

•Mahkeme ve Dava (1:n): Bir (1) mahkemede birden fazla (n) dava görülebilir. Bir (n) dava sadece bir (1) mahkemeye aittir.

•Dava ve Duruşma (1:n): Bir (1) davanın birden fazla (n) duruşması olabilir. Her duruşma sadece bir (1) davaya aittir.

•Duruşma ve Ara Karar (1:n): Bir (1) duruşmada birden fazla (n) ara karar verilebilir.

•Dava ve Belge (1:n): Bir (1) davaya ait birden fazla (n) belge sisteme yüklenebilir.

•Dava ve Karar (1:1 / 1:n): Bir davada genellikle bir (1) nihai gerekçeli karar olur. (Ancak süreçte birden fazla karar çıkarsa tasarım 1:n olabilir).

•Kullanıcı (Adliye Personeli) ve Dava (n:m): Bir (n) hakim birden fazla (m) davaya bakabilir. Bir (n) davada farklı rollerde (Katip, Hakim) birden fazla (m) personel işlem yapabilir.



1.4. Fonksiyonel Gereksinimler (Alan Bazında)

•Dava Yönetimi:

&nbsp;oYeni dava kaydı oluşturulması (Dava Tipi, Tarih, Konu, Mahkeme/Esas No, Yargı Yolu).

&nbsp;oDava bilgilerinin (durum, aşama, duruşma tarihleri) güncellenmesi ve takibi.

&nbsp;oDava dosyasına ait tüm belgelerin (dilekçeler, tutanaklar, kararlar) sisteme yüklenmesi/ilişkilendirilmesi.

&nbsp;oDavanın aşamalarına (Tevzi, Ön İnceleme, Tahkikat, Karar, İstinaf, Temyiz) göre otomatik geçiş ve durum takibi.

•Taraf Yönetimi:

&nbsp;oDavacı, Davalı, Vekil (Avukat), Müdahil gibi tüm tarafların T.C. Kimlik No/Vergi No, Adres ve İletişim bilgileri ile kaydedilmesi.

&nbsp;oBir tarafın birden fazla davada farklı rollerde yer alabilmesi.

•Mahkeme/Birim Yönetimi:

&nbsp;oSistemin hangi mahkemelerde (Asliye Hukuk, Ceza, İdare vb.) kullanılacağının tanımlanması.

&nbsp;oHakim, Savcı, Zabıt Katibi gibi Adliye Personelinin ve yetki alanlarının tanımlanması.

•Duruşma ve İşlem Takibi:

&nbsp;oYeni duruşma tarihi ve saati belirlenmesi.

&nbsp;oDuruşma tutanaklarının sisteme girilmesi ve saklanması.

&nbsp;oAra Kararların (Keşif, Bilirkişi Ataması, Delil Toplama) kaydı ve bu kararların yerine getirilme durumunun takibi.

•Belge ve Dosya Yönetimi:

&nbsp;oDava ile ilgili her türlü evrakın (PDF, DOCX vb.) elektronik olarak ilişkilendirilmesi ve arşivlenmesi.

&nbsp;oBelgelerin türüne göre (Dava Dilekçesi, Cevap Dilekçesi, Gerekçeli Karar vb.) kategorize edilmesi.

&nbsp;oYetkili kullanıcıların belgelere erişiminin kontrolü.

•Karar Yönetimi:

&nbsp;oGerekçeli kararın sisteme girilmesi.

&nbsp;oKararın kesinleşme tarihi ve durumunun takibi (İstinaf/Temyiz süreçleri dahil).

&nbsp;oVekalet Ücreti, Yargılama Giderleri gibi mali bilgilerin kaydedilmesi.

•Raporlama ve Sorgulama:

&nbsp;oDava durumuna, türüne, taraf adına, hakime, yıla göre detaylı ve anlık raporlar alınabilmesi.

&nbsp;oKritik tarihler (Zaman aşımı, Temyiz süresi bitimi) için uyarı raporları.

&nbsp;oKullanıcı bazında (Hakim, Kalem) iş yükü ve performans raporları.

•Kullanıcı ve Yetkilendirme:

&nbsp;oFarklı roller (Sistem Yöneticisi, Hakim, Zabıt Katibi) için kullanıcı hesabı oluşturulması.

&nbsp;oRole dayalı yetkilendirme (ACL - Access Control List) ile hangi kullanıcının hangi verilere erişip/değiştirebileceğinin belirlenmesi.



1.5. Fonksiyonel Olmayan Gereksinimler

•Performans:

&nbsp;oYoğun sorgu ve veri girişi altında bile kabul edilebilir hızda çalışması (Örn: Dava sorgulama süresi maksimum 3 saniye).

•Güvenlik:

&nbsp;oVeritabanına yetkisiz erişimi engellemek için güçlü şifreleme ve yetkilendirme mekanizmaları (SQL Server Security).

&nbsp;oHassas verilerin (T.C. Kimlik No) maskelenmesi veya şifrelenmesi.

&nbsp;oYapılan tüm işlemlerin (Kayıt silme, güncelleme) denetim kaydının (Audit Log) tutulması.

•Güvenilirlik ve Süreklilik:

&nbsp;oVeritabanının düzenli yedeklenmesi (Backup and Restore).



