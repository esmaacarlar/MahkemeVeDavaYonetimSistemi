--Gerekli þemalarýn oluþturulmasý
CREATE SCHEMA Adliye;
GO

CREATE SCHEMA DavaYonetim;
GO

CREATE SCHEMA Denetim;
GO

--Tablolarýn oluþturulmasý
CREATE TABLE Adliye.Mahkeme (
    MahkemeID INT IDENTITY PRIMARY KEY,
    MahkemeAdi NVARCHAR(100) NOT NULL,
    MahkemeTuru NVARCHAR(50) NOT NULL
);

CREATE TABLE Adliye.AdliyePersoneli (
    PersonelID INT IDENTITY PRIMARY KEY,
    Ad NVARCHAR(50) NOT NULL,
    Soyad NVARCHAR(50) NOT NULL,
    Rol NVARCHAR(30) NOT NULL
        CHECK (Rol IN ('Hakim','Savci','Zabit Katibi','Yonetici')),
    KullaniciAdi NVARCHAR(50) UNIQUE NOT NULL,
    Sifre NVARCHAR(256) NOT NULL
);

CREATE TABLE DavaYonetim.Dava (
    DavaID INT IDENTITY PRIMARY KEY,
    EsasNo NVARCHAR(30) UNIQUE NOT NULL,
    DavaTuru NVARCHAR(50) NOT NULL,
    YargiYolu NVARCHAR(50) NOT NULL,
    Konu NVARCHAR(255),
    AcilisTarihi DATE NOT NULL,
    DavaAsamasi NVARCHAR(50),
    Durum NVARCHAR(30),
    MahkemeID INT NOT NULL,
    FOREIGN KEY (MahkemeID)
        REFERENCES Adliye.Mahkeme(MahkemeID)
);

CREATE TABLE DavaYonetim.Taraf (
    TarafID INT IDENTITY PRIMARY KEY,
    Ad NVARCHAR(50) NOT NULL,
    Soyad NVARCHAR(50) NOT NULL,
    TCKimlikNo CHAR(11) UNIQUE,
    VergiNo CHAR(10),
    Adres NVARCHAR(255),
    IletisimBilgileri NVARCHAR(100)
);

CREATE TABLE DavaYonetim.DavaTaraf (
    DavaID INT NOT NULL,
    TarafID INT NOT NULL,
    Rol NVARCHAR(20) NOT NULL
        CHECK (Rol IN ('Davaci','Davali','Vekil','Mudahil')),
    CONSTRAINT PK_DavaTaraf PRIMARY KEY (DavaID, TarafID, Rol),
    CONSTRAINT FK_DT_Dava FOREIGN KEY (DavaID)
        REFERENCES DavaYonetim.Dava(DavaID),
    CONSTRAINT FK_DT_Taraf FOREIGN KEY (TarafID)
        REFERENCES DavaYonetim.Taraf(TarafID)
);

CREATE TABLE DavaYonetim.Avukat (
    AvukatID INT IDENTITY PRIMARY KEY,
    BaroNo NVARCHAR(20) UNIQUE NOT NULL,
    TarafID INT UNIQUE NOT NULL,
    FOREIGN KEY (TarafID)
        REFERENCES DavaYonetim.Taraf(TarafID)
);

CREATE TABLE DavaYonetim.Durusma (
    DurusmaID INT IDENTITY PRIMARY KEY,
    DavaID INT NOT NULL,
    DurusmaTarihi DATE NOT NULL,
    Saat TIME NOT NULL,
    DurusmaTutanagi NVARCHAR(MAX),
    FOREIGN KEY (DavaID)
        REFERENCES DavaYonetim.Dava(DavaID)
);

ALTER TABLE DavaYonetim.Durusma
ALTER COLUMN Saat TIME(0) NOT NULL;


CREATE TABLE DavaYonetim.AraKarar (
    AraKararID INT IDENTITY PRIMARY KEY,
    DurusmaID INT NOT NULL,
    KararMetni NVARCHAR(MAX) NOT NULL,
    KararTipi NVARCHAR(50),
    YerineGetirildi BIT DEFAULT 0,
    FOREIGN KEY (DurusmaID)
        REFERENCES DavaYonetim.Durusma(DurusmaID)
);

CREATE TABLE DavaYonetim.Belge (
    BelgeID INT IDENTITY PRIMARY KEY,
    DavaID INT NOT NULL,
    BelgeAdi NVARCHAR(100),
    BelgeTuru NVARCHAR(50),
    DosyaYolu NVARCHAR(255),
    YuklemeTarihi DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (DavaID)
        REFERENCES DavaYonetim.Dava(DavaID)
);

ALTER TABLE DavaYonetim.Belge
ALTER COLUMN YuklemeTarihi DATETIME2(0) NOT NULL;

CREATE TABLE DavaYonetim.Karar (
    KararID INT IDENTITY PRIMARY KEY,
    DavaID INT NOT NULL,
    GerekceliKararMetni NVARCHAR(MAX),
    KararTarihi DATE NOT NULL,
    Kesinlesti BIT DEFAULT 0,
    KesinlesmeTarihi DATE,
    FOREIGN KEY (DavaID)
        REFERENCES DavaYonetim.Dava(DavaID)
);

CREATE TABLE DavaYonetim.MaliBilgiler (
    MaliID INT IDENTITY PRIMARY KEY,
    KararID INT UNIQUE NOT NULL,
    VekaletUcreti DECIMAL(12,2),
    YargilamaGideri DECIMAL(12,2),
    FOREIGN KEY (KararID)
        REFERENCES DavaYonetim.Karar(KararID)
);

CREATE TABLE DavaYonetim.DavaPersonel (
    DavaID INT NOT NULL,
    PersonelID INT NOT NULL,
    Gorev NVARCHAR(30),
    CONSTRAINT PK_DavaPersonel PRIMARY KEY (DavaID, PersonelID),
    FOREIGN KEY (DavaID)
        REFERENCES DavaYonetim.Dava(DavaID),
    FOREIGN KEY (PersonelID)
        REFERENCES Adliye.AdliyePersoneli(PersonelID)
);


CREATE TABLE Denetim.AuditLog (
    LogID INT IDENTITY PRIMARY KEY,
    KullaniciID INT,
    IslemTipi NVARCHAR(50),
    IslemTarihi DATETIME DEFAULT GETDATE(),
    Aciklama NVARCHAR(255),
    FOREIGN KEY (KullaniciID)
        REFERENCES Adliye.AdliyePersoneli(PersonelID)
);


--Yeni dava açma 
CREATE PROCEDURE DavaYonetim.sp_YeniDavaAc
    @EsasNo NVARCHAR(30),
    @DavaTuru NVARCHAR(50),
    @YargiYolu NVARCHAR(50),
    @Konu NVARCHAR(255),
    @MahkemeID INT,
    @TarafID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO DavaYonetim.Dava
        (EsasNo, DavaTuru, YargiYolu, Konu, AcilisTarihi, DavaAsamasi, Durum, MahkemeID)
        VALUES
        (@EsasNo, @DavaTuru, @YargiYolu, @Konu, GETDATE(), 'Tevzi', 'Devam', @MahkemeID);

        DECLARE @YeniDavaID INT = SCOPE_IDENTITY();

        INSERT INTO DavaYonetim.DavaTaraf
        (DavaID, TarafID, Rol)
        VALUES
        (@YeniDavaID, @TarafID, 'Davaci');

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO


--Yeni duruþma ekleme
CREATE PROCEDURE DavaYonetim.sp_DurusmaEkle
    @DavaID INT,
    @DurusmaTarihi DATE,
    @Saat TIME
AS
BEGIN
    INSERT INTO DavaYonetim.Durusma
    (DavaID, DurusmaTarihi, Saat)
    VALUES
    (@DavaID, @DurusmaTarihi, @Saat);
END;
GO


--Ara karar ekleme
CREATE PROCEDURE DavaYonetim.sp_AraKararEkle
    @DurusmaID INT,
    @KararMetni NVARCHAR(MAX),
    @KararTipi NVARCHAR(50)
AS
BEGIN
    INSERT INTO DavaYonetim.AraKarar
    (DurusmaID, KararMetni, KararTipi, YerineGetirildi)
    VALUES
    (@DurusmaID, @KararMetni, @KararTipi, 0);
END;
GO


--Karar ve Mali bilgi ekleme
CREATE PROCEDURE DavaYonetim.sp_KararVeMaliEkle
    @DavaID INT,
    @GerekceliMetin NVARCHAR(MAX),
    @KararTarihi DATE,
    @VekaletUcreti DECIMAL(12,2),
    @YargilamaGideri DECIMAL(12,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO DavaYonetim.Karar
        (DavaID, GerekceliKararMetni, KararTarihi, Kesinlesti)
        VALUES
        (@DavaID, @GerekceliMetin, @KararTarihi, 0);

        DECLARE @KararID INT = SCOPE_IDENTITY();

        INSERT INTO DavaYonetim.MaliBilgiler
        (KararID, VekaletUcreti, YargilamaGideri)
        VALUES
        (@KararID, @VekaletUcreti, @YargilamaGideri);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO


--Karar eklenince AuditLog'un güncellenmesi
CREATE TRIGGER DavaYonetim.trg_Karar_Insert_Audit
ON DavaYonetim.Karar
AFTER INSERT
AS
BEGIN
    INSERT INTO Denetim.AuditLog
    (KullaniciID, IslemTipi, Aciklama)
    SELECT
        1,
        'KARAR EKLEME',
        'Yeni karar sisteme eklendi'
    FROM inserted;
END;
GO

--Karar kesinleþince davayý otomatik kapatma
CREATE TRIGGER DavaYonetim.trg_Karar_Kesinlesme
ON DavaYonetim.Karar
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Kesinlesti)
    BEGIN
        UPDATE DavaYonetim.Dava
        SET
            Durum = 'Sonuclandi',
            DavaAsamasi = 'Karar'
        WHERE DavaID IN (
            SELECT DavaID
            FROM inserted
            WHERE Kesinlesti = 1
        );
    END
END;
GO


--Ara karar yerine getirildiðinde AuditLog'u güncelleme 
CREATE TRIGGER DavaYonetim.trg_AraKarar_Update_Audit
ON DavaYonetim.AraKarar
AFTER UPDATE
AS
BEGIN
    IF UPDATE(YerineGetirildi)
    BEGIN
        INSERT INTO Denetim.AuditLog
        (KullaniciID, IslemTipi, Aciklama)
        VALUES
        (1, 'ARA KARAR', 'Ara karar yerine getirildi');
    END
END;
GO