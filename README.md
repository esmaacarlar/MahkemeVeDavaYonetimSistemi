# 📚 Dava Yönetim Sistemi – Veritabanı Projesi

Bu proje, SQL Server üzerinde çalışan bir **Dava Yönetim Sistemi** veritabanını kapsamaktadır.  
Amaç, adliye bünyesinde yer alan **mahkemeler, davalar, taraflar, adliye personeli, duruşmalar, belgeler ve kararlar** arasındaki ilişkileri düzenli ve tutarlı bir şekilde modellemektir.

Proje; **şema kullanımı**, **ilişkisel veritabanı tasarımı**, **örnek veri ekleme** ve **raporlama sorguları** içerecek şekilde hazırlanmıştır.

---

## 🏛️ Proje Kapsamı

Veritabanı aşağıdaki ana bileşenleri içermektedir:

- Adliye ve Mahkeme bilgileri
- Dava kayıtları ve dava türleri
- Davaya ait taraflar (davacı / davalı)
- Adliye personeli (hakim, savcı, zabıt katibi, yönetici)
- Duruşmalar ve ara kararlar
- Dava belgeleri
- Gerekçeli kararlar ve mali bilgiler
- Kullanıcı işlemlerini takip eden audit log yapısı

Tüm yapılar **gerçek hayattaki bir adliye sistemine uygun** olacak şekilde tasarlanmıştır.

---

## 🗂️ Veritabanı Yapısı

Projede aşağıdaki şemalar kullanılmıştır:

- **Adliye**  
  Mahkeme ve adliye personeline ait tabloları içerir.

- **DavaYonetim**  
  Dava, taraf, duruşma, belge, karar ve mali bilgiler gibi dava sürecine ait tabloları içerir.

- **Denetim**  
  Sistem üzerinde yapılan işlemleri takip etmek amacıyla audit log kayıtlarını içerir.

---

## 📁 Dosya Yapısı

Proje kapsamında SQL kodları üç ayrı dosya halinde düzenlenmiştir:

sql/
├── 01_MahkemeVeDavaYonetimOlusturma.sql → Şemalar ve tabloların oluşturulması
├── 02_MahkemeDavaOrnekVeriler.sql → Tüm tablolar için örnek verilerin eklenmesi
└── 03_DavaYonetimSorgular.sql → Raporlama ve listeleme amaçlı SELECT sorguları


Bu ayrım sayesinde:
- Kodlar daha okunabilir hale gelmiştir  
- Bakım ve test süreçleri kolaylaşmıştır  
- Versiyon kontrolü daha düzenli yapılabilmektedir  

---

## 🧪 Örnek Veriler

Veritabanına;
- Elazığ iline ait **birden fazla mahkeme**
- Her mahkemeye ait **çeşitli dava türleri**
- Davalara ait **birden fazla taraf**
- Hakim, savcı ve zabıt katibi atamaları
- Duruşma kayıtları, ara kararlar ve belgeler
eklenmiştir.

Bu sayede tüm tablolar **dolu**, sorgular ise **anlamlı sonuçlar** üretmektedir.

---

## 🔍 Sorgular

`03_DavaYonetimSorgular.sql` dosyasında:

- Davalara göre tarafların listelenmesi
- Mahkemeye göre dava sayıları
- Davaya ait duruşma ve belge bilgileri
- Raporlama amaçlı JOIN ve GROUP BY sorguları
yer almaktadır.

Bu sorgular, veritabanının doğru ve tutarlı çalıştığını göstermek amacıyla hazırlanmıştır.

---

## ⚙️ Kullanılan Teknolojiler

- Microsoft SQL Server
- T-SQL
- Git & GitHub

---

## 👥 Takım Üyeleri

- **Esma Açarlar** [@esmaacarlar]  
- **Firdevs Kara** [@FirdevsKara]  
- **Rana Özgül** [@ranaozgul]

---

## 📌 Not

Bu proje, eğitim amaçlı hazırlanmış olup bir **dönem projesi** kapsamında geliştirilmiştir.  
Gerçek adliye sistemlerinin temel işleyişi referans alınmıştır.
