
-- Foy3 adlı veritabanı oluşturuldu soru1
CREATE DATABASE foy3 ON PRIMARY
( 
NAME= vtys_data, 
FILENAME = 'C:\foy3\vtysdata.mdf', 
SIZE = 8MB, 
MAXSIZE = unlimited, 
FILEGROWTH = 10%
) 
LOG ON 
( 
NAME= vtys_log, 
FILENAME = 'C:\foy3\vtysdata.ldf', 
SIZE = 8MB, 
MAXSIZE = unlimited, 
FILEGROWTH = 10%


-- Aşağıdaki kodlar kullanılarak tablolar oluşturuldu soru1

use foy3;

 create table birimler
(
birim_id int primary key not null,
birim_ad char(25) not null,
)

create table calisanlar
(
calisan_id int primary key not null,
ad char(25) null,
soyad char(25) null,
maas int null,
katilmaTarihi datetime null,
calisan_birim_id int foreign key references birimler(birim_id),
)

create table ikramiye
(
ikramiye_calisan_id int foreign key references calisanlar(calisan_id),
ikramiye_ucret int null,
ikramiye_tarih datetime null
)

create table unvan
(
unvan_calisan_id int foreign key references calisanlar(calisan_id),
unvan_calisan char(25) null,
unvan_tarih datetime null
)

-- Aşağıdaki kodlar kullanılarak veri girişleri yapıldı. soru 2 

use foy3;
INSERT INTO birimler (birim_id, birim_ad)
VALUES 
(1, 'Yazilim'),
(2, 'Donanım'),
(3, 'Guvenlik');

INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilmaTarihi, calisan_birim_id)
VALUES 
(1, 'İsmail', 'İşeri','100000','2014-02-20 00:00:00.000', 1),
(2, 'Hami','Satılmış','80000', '2014-06-11 00:00:00.000', 1),
(3, 'Durmuş', 'Şahin', '300000', '2014-02-20 00:00:00.000', 2),
(4, 'Kağan', 'Yazar', '500000', '2014-02-20 00:00:00.000', 3),
(5, 'Meryem', 'Soysaldı', '500000', '2014-06-11 00:00:00.000', 3),
(6, 'Duygu', 'Akşehir', '200000', '2014-06-11 00:00:00.000', 2),
(7, 'Kübra', 'Seyhan', '75000', '2014-01-20 00:00:00.000', 1),
(8, 'Gülcan', 'Yıldız', '90000', '2014-04-11 00:00:00.000', 3); 

INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih)
VALUES 
(1, 5000 , '2016-02-20 00:00:00.000'),
(2, 3000 , '2016-06-11 00:00:00.000'),
(3, 4000 , '2016-02-20 00:00:00.000'),
(1, 4500 , '2016-02-20 00:00:00.000'),
(2, 3500 , '2016-06-11 00:00:00.000');

INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih)
VALUES 
(1, 'Yönetici', '2016-02-20 00:00:00.000'),
(2, 'Personel', '2016-06-11 00:00:00.000'),
(8, 'Personel', '2016-06-11 00:00:00.000'),
(5, 'Müdür', '2016-06-11 00:00:00.000'),
(4, 'Yönetici Yardımcısı', '2016-06-11 00:00:00.000'),
(7, 'Personel', '2016-06-11 00:00:00.000'),
(6, 'Takım Lideri', '2016-06-11 00:00:00.000'),
(3,' Takım Lideri', '2016-06-11 00:00:00.000');


-- select ile oluşturulan tablolar döndürülür
use foy3;

select * from birimler;
select * from calisanlar;
select * from ikramiye;
select * from unvan;

-- soru 3
select ad, soyad, maas from calisanlar where calisan_birim_id in ('1','2')

-- soru 4
select ad, soyad, maas from calisanlar where maas >= (select max(maas) from calisanlar)


-- soru 5
SELECT b.birim_ad, COUNT(c.calisan_id) AS calisan_sayisi
FROM birimler b
LEFT JOIN calisanlar c ON b.birim_id = c.calisan_birim_id
GROUP BY b.birim_ad;


-- soru 6
select unvan_calisan, count(unvan_calisan) as 'calisan_sayisi' from unvan group by unvan_calisan having count(unvan_calisan)  > 1;

-- soru 7
select ad, soyad, maas from calisanlar where maas between 50000 and 100000 


-- soru 8
select ad, soyad, calisan_birim_id, unvan_calisan, ikramiye_ucret
from calisanlar 
inner join ikramiye
on calisan_id = ikramiye_calisan_id
inner join unvan 
on calisan_id = unvan_calisan_id


-- soru 9
select ad, soyad, unvan_calisan from calisanlar 
inner join unvan
on calisan_id = unvan_calisan_id 
where unvan_calisan in ('Yönetici', 'Müdür')


-- soru 10
select birim_ad, ad, soyad, maas 
from birimler inner join calisanlar on birim_id = calisan_birim_id 
where maas in (select max(maas) from calisanlar group by calisan_birim_id);





