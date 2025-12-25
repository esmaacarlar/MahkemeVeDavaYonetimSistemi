-- Örnek verilerin eklenmesi

INSERT INTO Adliye.Mahkeme (MahkemeAdi, MahkemeTuru) VALUES
('Elazýð 1. Asliye Hukuk Mahkemesi','Asliye Hukuk'),
('Elazýð 2. Asliye Hukuk Mahkemesi','Asliye Hukuk'),
('Elazýð 3. Asliye Hukuk Mahkemesi','Asliye Hukuk'),
('Elazýð 1. Asliye Ceza Mahkemesi','Ceza'),
('Elazýð 2. Asliye Ceza Mahkemesi','Ceza'),
('Elazýð Aðýr Ceza Mahkemesi','Ceza'),
('Elazýð Aile Mahkemesi','Özel'),
('Elazýð Ýþ Mahkemesi','Özel'),
('Elazýð Tüketici Mahkemesi','Özel'),
('Elazýð Sulh Hukuk Mahkemesi','Sulh Hukuk'),
('Elazýð Sulh Ceza Hakimliði','Sulh Ceza'),
('Elazýð Ýcra Hukuk Mahkemesi','Ýcra'),
('Elazýð Ýcra Ceza Mahkemesi','Ýcra');

INSERT INTO Adliye.AdliyePersoneli (Ad,Soyad,Rol,KullaniciAdi,Sifre) VALUES
('Murat','Kaya','Hakim','mkaya','1234'),
('Fatma','Koç','Hakim','fkoc','1234'),
('Ahmet','Demir','Hakim','ademir','1234'),
('Emre','Aslan','Savci','easlan','1234'),
('Selim','Arý','Savci','sari','1234'),
('Zeynep','Polat','Zabit Katibi','zpolat','1234'),
('Burcu','Taþ','Zabit Katibi','btas','1234'),
('Onur','Can','Zabit Katibi','ocan','1234'),
('Hakan','Yýlmaz','Yonetici','hyilmaz','1234'),
('Ayþe','Þahin','Yonetici','asahin','1234');

INSERT INTO DavaYonetim.Taraf
(Ad,Soyad,TCKimlikNo,VergiNo,Adres,IletisimBilgileri) VALUES
('Ali','Kara','11111111111',NULL,'Elazýð Merkez','05310000001'),
('Veli','Yýldýz','11111111112',NULL,'Elazýð Merkez','05310000002'),
('Ayþe','Demir','11111111113',NULL,'Elazýð Palu','05310000003'),
('Mehmet','Çelik','11111111114',NULL,'Elazýð Kovancýlar','05310000004'),
('Zehra','Ak','11111111115',NULL,'Elazýð Baskil','05310000005'),
('Mustafa','Kýlýç','11111111116',NULL,'Elazýð Karakoçan','05310000006'),
('Merve','Polat','11111111117',NULL,'Elazýð Merkez','05310000007'),
('Serkan','Yavuz','11111111118',NULL,'Elazýð Merkez','05310000008'),
('Hatice','Þahin','11111111119',NULL,'Elazýð Merkez','05310000009'),
('Onur','Aydýn','11111111120',NULL,'Elazýð Merkez','05310000010');

INSERT INTO DavaYonetim.Avukat (BaroNo, TarafID) VALUES
('ELZ001',3),
('ELZ002',5),
('ELZ003',7),
('ELZ004',9);

INSERT INTO DavaYonetim.Dava
(EsasNo,DavaTuru,YargiYolu,Konu,AcilisTarihi,DavaAsamasi,Durum,MahkemeID) VALUES
('2025/1','Hukuk','Adli','Alacak Davasi','2025-01-05','Tahkikat','Devam',1),
('2025/2','Hukuk','Adli','Tazminat Davasi','2025-01-10','Tahkikat','Devam',2),
('2025/3','Ceza','Adli','Hakaret','2025-02-01','Sorusturma','Devam',4),
('2025/4','Ceza','Adli','Tehdit','2025-02-03','Sorusturma','Devam',5),
('2025/5','Ceza','Adli','Dolandiricilik','2025-02-10','Kovusturma','Devam',6),
('2025/6','Hukuk','Adli','Bosanmada Nafaka','2025-03-01','Tahkikat','Devam',7),
('2025/7','Hukuk','Adli','Ise Iade','2025-03-05','Tahkikat','Devam',8),
('2025/8','Hukuk','Adli','Ayipli Mal','2025-03-10','Tahkikat','Devam',9),
('2025/9','Hukuk','Adli','Vesayet','2025-03-15','On Inceleme','Devam',10),
('2025/10','Ceza','Adli','Kabahat','2025-03-20','Sorusturma','Devam',11),
('2025/11','Icra','Adli','Icra Takibi','2025-03-25','Takip','Devam',12),
('2025/12','Icra','Adli','Icra Ceza','2025-03-28','Sorusturma','Devam',13);

INSERT INTO DavaYonetim.DavaTaraf (DavaID,TarafID,Rol) VALUES
(1,1,'Davaci'),(1,2,'Davali'),
(2,3,'Davaci'),(2,4,'Davali'),
(3,5,'Davali'),
(4,6,'Davali'),
(5,7,'Davali'),
(6,8,'Davaci'),(6,9,'Davali'),
(7,10,'Davaci'),
(8,1,'Davaci'),(8,2,'Davali'),
(9,3,'Davaci'),
(10,4,'Davali'),
(11,5,'Davaci'),
(12,6,'Davali');

INSERT INTO DavaYonetim.DavaPersonel (DavaID,PersonelID,Gorev) VALUES
(1,1,'Hakim'),(1,6,'Zabit Katibi'),
(2,2,'Hakim'),(2,7,'Zabit Katibi'),
(3,1,'Hakim'),(3,4,'Savci'),
(4,2,'Hakim'),(4,5,'Savci'),
(5,3,'Hakim'),(5,4,'Savci'),
(6,1,'Hakim'),(6,6,'Zabit Katibi'),
(7,2,'Hakim'),(7,7,'Zabit Katibi'),
(8,3,'Hakim'),(8,8,'Zabit Katibi'),
(9,1,'Hakim'),
(10,2,'Hakim'),
(11,3,'Hakim'),
(12,1,'Hakim');

INSERT INTO DavaYonetim.Durusma
(DavaID,DurusmaTarihi,Saat,DurusmaTutanagi) VALUES
(1,'2025-04-01','10:00','Ilk durusma yapildi'),
(1,'2025-05-01','10:30','Tanýklar dinlendi'),
(3,'2025-04-10','11:00','Sanýk savunmasý alýndý'),
(5,'2025-04-20','09:30','Deliller incelendi'),
(6,'2025-05-05','10:15','Ara karar verildi'),
(7,'2025-05-15','11:45','Beyanlar alýndý'),
(8,'2025-05-20','09:00','Uzlaþma saðlanamadý');

INSERT INTO DavaYonetim.AraKarar
(DurusmaID,KararMetni,KararTipi,YerineGetirildi) VALUES
(1,'Bilirkisi atanmasýna','Bilirkisi',0),
(2,'Tanýklarýn dinlenmesine','Tanik',1),
(3,'Adli kontrol uygulanmasýna','Tedbir',1),
(5,'Kesif yapýlmasýna','Kesif',0);

INSERT INTO DavaYonetim.Belge
(DavaID,BelgeAdi,BelgeTuru,DosyaYolu) VALUES
(1,'Dava Dilekcesi','Dilekce','/elazig/d1.pdf'),
(1,'Bilirkisi Raporu','Rapor','/elazig/d1_rapor.pdf'),
(3,'Savunma Dilekcesi','Dilekce','/elazig/d3.pdf'),
(6,'Nufus Kaydi','Belge','/elazig/nufus.pdf'),
(8,'Fatura','Belge','/elazig/fatura.pdf'),
(11,'Icra Talebi','Dilekce','/elazig/icra.pdf');

INSERT INTO DavaYonetim.Karar
(DavaID,GerekceliKararMetni,KararTarihi,Kesinlesti,KesinlesmeTarihi) VALUES
(1,'Davacinin talebi kabul edildi','2025-06-01',1,'2025-06-20'),
(6,'Nafaka talebi kismen kabul edildi','2025-06-10',1,'2025-07-01');

INSERT INTO DavaYonetim.MaliBilgiler
(KararID,VekaletUcreti,YargilamaGideri) VALUES
(1,15000,3200),
(2,12000,2800);

INSERT INTO Denetim.AuditLog
(KullaniciID,IslemTipi,Aciklama) VALUES
(9,'GIRIS','Yonetici sisteme giris yapti'),
(1,'DAVA','Yeni dava acildi'),
(6,'DURUSMA','Durusma eklendi'),
(3,'KARAR','Karar kaydedildi');