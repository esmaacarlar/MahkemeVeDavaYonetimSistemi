--Sorgular

SELECT 
    MahkemeID,
    MahkemeAdi,
    MahkemeTuru
FROM Adliye.Mahkeme;

SELECT 
    PersonelID,
    Ad,
    Soyad,
    Rol,
    KullaniciAdi
FROM Adliye.AdliyePersoneli;

SELECT 
    d.DavaID,
    d.EsasNo,
    d.DavaTuru,
    d.Konu,
    d.AcilisTarihi,
    d.Durum,
    m.MahkemeAdi
FROM DavaYonetim.Dava d
JOIN Adliye.Mahkeme m
    ON d.MahkemeID = m.MahkemeID;

SELECT
    d.DavaID,
    d.EsasNo,
    STRING_AGG(
        CONCAT(t.Ad, ' ', t.Soyad, ' (', dt.Rol, ')'),
        ', '
    ) AS Taraflar
FROM DavaYonetim.Dava d
JOIN DavaYonetim.DavaTaraf dt ON d.DavaID = dt.DavaID
JOIN DavaYonetim.Taraf t ON dt.TarafID = t.TarafID
GROUP BY
    d.DavaID,
    d.EsasNo
ORDER BY
    d.DavaID;

SELECT 
    a.BaroNo,
    t.Ad,
    t.Soyad,
    t.Adres
FROM DavaYonetim.Avukat a
JOIN DavaYonetim.Taraf t
    ON a.TarafID = t.TarafID;

SELECT 
    d.EsasNo,
    p.Ad,
    p.Soyad,
    dp.Gorev
FROM DavaYonetim.DavaPersonel dp
JOIN DavaYonetim.Dava d ON dp.DavaID = d.DavaID
JOIN Adliye.AdliyePersoneli p ON dp.PersonelID = p.PersonelID
ORDER BY d.EsasNo;

SELECT 
    d.EsasNo,
    du.DurusmaTarihi,
    du.Saat,
    du.DurusmaTutanagi
FROM DavaYonetim.Durusma du
JOIN DavaYonetim.Dava d ON du.DavaID = d.DavaID
ORDER BY du.DurusmaTarihi;

SELECT 
    d.EsasNo,
    ak.KararTipi,
    ak.KararMetni,
    ak.YerineGetirildi
FROM DavaYonetim.AraKarar ak
JOIN DavaYonetim.Durusma du ON ak.DurusmaID = du.DurusmaID
JOIN DavaYonetim.Dava d ON du.DavaID = d.DavaID;

SELECT 
    d.EsasNo,
    b.BelgeAdi,
    b.BelgeTuru,
    b.YuklemeTarihi
FROM DavaYonetim.Belge b
JOIN DavaYonetim.Dava d ON b.DavaID = d.DavaID;

SELECT 
    d.EsasNo,
    k.KararTarihi,
    k.Kesinlesti,
    d.Durum
FROM DavaYonetim.Karar k
JOIN DavaYonetim.Dava d ON k.DavaID = d.DavaID
WHERE k.Kesinlesti = 1;

SELECT 
    d.EsasNo,
    m.VekaletUcreti,
    m.YargilamaGideri
FROM DavaYonetim.MaliBilgiler m
JOIN DavaYonetim.Karar k ON m.KararID = k.KararID
JOIN DavaYonetim.Dava d ON k.DavaID = d.DavaID;

SELECT 
    LogID,
    IslemTipi,
    IslemTarihi,
    Aciklama
FROM Denetim.AuditLog
ORDER BY IslemTarihi DESC;