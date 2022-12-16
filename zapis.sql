select * from postac;
# komentarz
/*zadanie
select */
# Crl + d -duplikacja linii

# lab4 zadanie 1a
select * from postac where nazwa !='Bjorn' and rodzaj='wiking'  order by data_ur asc limit 2;
#delete from postac where id_postaci=7 AND id_postaci=13;

# lab4 zadanie 1b
alter table postac drop primary key;
#problem 1 - istniejace klucze obce do tej kolumny
#tabela przetwory,walizka,ewentuallnie izba
#usuwanie kluczy obcych
alter table przetwory drop foreign key `przetwory_ibfk_1`;
alter table przetwory drop foreign key `przetwory_ibfk_2`;
alter table walizka drop foreign key `walizka_ibfk_1`;
show create table postac;
# problem 2 pozbyc sie auto_increment
ALTER TABLE postac modify id_postaci int;

# lab4 zadanie 2a
# first -wstawimy kolumne jako piewrsza we tabeli
ALTER table postac ADD pesel char(11) first;
alter table postac add primary key(pesel);
update postac set pesel='12345678901' + id_postaci;
select * from postac;

# lab4 zadanie 2b
alter table postac MODIFY rodzaj enum('wiking','ptak','kobieta','syrena');

#lab4 zadanie 2c
INSERT INTO postac VALUES ('12345678092',100,'Getruda Nieszczera','syrena','2010-10-10',18,'brak',null);
SELECT * FROM postac;

#lab4 zadanie 3a
update postac set statek='barka' where nazwa like '%a%';
#równoważne wyrażenie regularne
select nazwa from postac where nazwa regexp '[a]';

#lab4 zadanie 3b
update statek set max_ladownosc = max_ladownosc*0.7 where data_wodowania >= '2000-01=01' AND data_wodowania <='3000-01-01';
select *from statek;

#lab4 zadanie 4a
SELECT * FROM postac;
#ALTER TABLE ...->dodanie wartosci 'waz' w kolumnie rodzaj w tabeli postac
DESC postac;
ALTER TABLE postac MODIFY rodzaj enum('wiking','ptak','syrena','kobieta','waz');
show create table postac;
INSERT INTO postac values ('12345678111',20,'Loko','waz','2000-01-01',10,null,null);

#lab4 zadanie 4b
show create table postac;
#opcja 1 -like (przeniesie klucz glowny) - tylko struktura
create table marynarz like postac;
#dodanie danych
insert into marynarz select * from postac;
#opcja 2-  create as select (struktura + dane (bez klucza)
create table marynarz select * from postac;


#lab 4 zadanie 4c
show tables;
show create table marynarz;
desc statek;
ALTER TABLE marynarz ADD FOREIGN KEY(statek) references statek(nazwa_statku);
show create table postac;

#lab 4 zadanie 5a
UPDATE marynarz SET statek=null;
SELECT * FROM marynarz;

#lab 4 zadanie 5b
DELETE FROM marynarz WHERE id_postaci=12;

#lab 4 zadanie 5c
DELETE FROM statek;

#lab 4 zadanie 5d
alter table marynarz DROP foreign key `postac_ibfk_1`



#lab5 zadanie 1.1
create table kreatura select * from wikingowie.kreatura;
create table zasob select * from wikingowie.zasob;
create table ekwipunek select * from wikingowie.ekwipunek;

#lab5 zadanie 1.2
SELECT * FROM zasob;

#lab5 zadanie 1.3
SELECT * FROM zasob where rodzaj='jedzenie';

#lab5 zadanie 1.4
SELECT idZasobu,ilosc FROM zasob where idZasobu in(1,3,5);

#lab5 zadanie 2.1
SELECT * FROM kreatura WHERE rodzaj!='wiedzma' AND udzwig>=50;

#lab5 zadanie 2.2
SELECT * FROM zasob where waga>=2 AND waga<=5;

#lab5 zadanie 2.3
SELECT * FROM kreatura;
SELECT * FROM kreatura WHERE nazwa LIKE '%or%' AND (udzwig>=30 AND udzwig<=70);

#lab5 zadanie 3.1
select dataPozyskania, 
year(dataPozyskania),
 month(dataPozyskania),
 day(dataPozyskania) from wikingowie.zasob ;
select * from wikingowie.zasob WHERE month(dataPozyskania) in (7,8);

#lab5 zadanie 3.2
SELECT * from wikingowie.zasob where rodzaj is not null ORDER BY waga ASC;

#lab5 zadanie 3.3
select * from wikingowie.kreatura order by dataur limit 5;

#lab5 zadanie 4.1
SELECT DISTINCT rodzaj from wikingowie.zasob;
select distinct nazwa, dataPozyskania from wikingowie.zasob;
select distinct(rodzaj) from zasob;

#lab5 zadanie 4.2
SELECT CONCAT(nazwa,' - ',rodzaj) FROM wikingowie.kreatura WHERE rodzaj LIKE 'wi%';

#lab5 zadanie 4.3
SELECT nazwa, ilosc*waga, dataPozyskania FROM wikingowie.zasob
 where year(dataPozyskania) between 2000 AND 2007;

#lab5 zadanie 5.1
SELECT nazwa, ilosc*waga*0.7 as waga_netto,
 ilosc*waga*0.3 as odpadki from wikingowie.zasob where rodzaj='jedzenie';

#lab5 zadanie 5.2
SELECT * FROM wikingowie.zasob WHERE rodzaj is null;

#lab5 zadanie 5.3
SELECT DISTINCT nazwa, rodzaj FROM wikingowie.zasob 
where nazwa LIKE 'Ba%' OR nazwa LIKE '%os' ORDER BY nazwa ASC;

#lab6 zadanie 1.1
SELECT AVG(waga) FROM wikingowie.kreatura WHERE rodzaj='wiking';

#lab6 zadanie 1.2
SELECT rodzaj, AVG(waga), COUNT(*) FROM wikingowie.kreatura 
GROUP BY rodzaj;

#lab6 zadanie 1.3
SELECT AVG(2022-year(dataUr)) as wiek, rodzaj 
FROM wikingowie.kreatura GROUP BY rodzaj;

#lab6 zadanie 2.1
SELECT nazwa, rodzaj, SUM(waga*ilosc) 
FROM wikingowie.zasob GROUP BY nazwa, rodzaj 
with rollup order by rodzaj;

# jako ciekawostka
select year(dataPozyskania) as rok , month(dataPozyskania) as miesiac
, count(*) from wikingowie.zasob group by rok, miesiac with rollup;

#lab6 zadanie 2.2
#having filtr dla kolumn agregowanych po agregacji
select rodzaj, count(nazwa) from wikingowie.kreatura GROUP BY rodzaj
HaVING count(nazwa)>1;

SELECT nazwa, AVG(waga) 
FROM wikingowie.zasob WHERE ilosc>=4 GROUP BY nazwa 
HAVING AVG(waga)>10;

SELECT * FROM wikingowie.zasob order by waga;
#lub ilosc jako agregacja dla nazwy
SELECT nazwa, AVG(waga) 
FROM wikingowie.zasob GROUP BY nazwa 
HAVING AVG(waga)>10 AND sum(ilosc)>=4 ;

SELECT nazwa, AVG(waga),sum(ilosc) 
FROM wikingowie.zasob GROUP BY nazwa;

#lab6 zadanie 2.3
SELECT rodzaj, COUNT(nazwa)FROM wikingowie.zasob
WHERE ilosc>1 GROUP BY rodzaj;

SELECT rodzaj, COUNT(nazwa)FROM wikingowie.zasob 
GROUP BY rodzaj HAVING SUM(ilosc)>1;

#lab6 zadanie 3.1
SELECT *
FROM wikingowie.kreatura, wikingowie.ekwipunek
WHERE wikingowie.kreatura.idKreatury=wikingowie.ekwipunek.idKreatury;
#równoważne
SELECT k.nazwa, e.ilosc
FROM wikingowie.kreatura k inner join wikingowie.ekwipunek e
ON wikingowie.k.idKreatury=wikingowie.e.idKreatury;

#lab6 zadanie 3.2
SELECT k.nazwa, e.ilosc, z.nazwa
FROM wikingowie.kreatura k inner join wikingowie.ekwipunek e 
inner join wikingowie.zasob  z ON 
wikingowie.z.idZasobu=wikingowie.e.idZasobu ON
wikingowie.k.idKreatury=wikingowie.e.idKreatury;

#lab6 zadanie 3.3
SELECT * FROM wikingowie.kreatura k  left join wikingowie.ekwipunek e ON 
wikingowie.k.idKreatury=wikingowie.e.idKreatury 
WHERE wikingowie.e.idEkwipunku is null;

#podzadanie
select idKreatury from wikingowie.kreatura where idKreatury not in (
select distinct idKreatury from wikingowie.ekwipunek
 where idKreatury);

#lab6 zadanie 4.1
SELECT k.nazwa, z.nazwa, dataUr  
FROM wikingowie.zasob z INNER JOIN wikingowie.kreatura k 
INNER JOIN wikingowie.ekwipunek ON 
wikingowie.ekwipunek.idKreatury=k.idKreatury ON 
wikingowie.ekwipunek.idZasobu=z.idZasobu WHERE dataUr LIKE '167%';

#lab6 zadanie 4.2
SELECT k.nazwa, z.rodzaj, dataUr FROM wikingowie.kreatura k 
inner join wikingowie.ekwipunek e  ON e.idKreatury=k.idKreatury
inner join wikingowie.zasob  z on e.idZasobu=z.idZasobu
where z.rodzaj='jedzenie'
order by dataUr DESC LIMIT 5;

#lab6 zadanie 4.3
SELECT concat(k1.nazwa,'-',k2.nazwa) FROM wikingowie.kreatura k1 
join wikingowie.kreatura k2
on k1.idKreatury=k2.idKreatury - 5;

#lab6 zadanie 5.1
SELECT k.rodzaj, sum(e.ilosc*z.waga)/count(distinct(k.nazwa))
FROM wikingowie.ekwipunek e inner join wikingowie.kreatura k
on e.idKreatury=k.idKreatury inner join wikingowie.zasob z
on e.idZasobu=z.idZasobu where k.rodzaj not in ('waz','malpa')
group by k.rodzaj;

#lab6 zadanie 5.2
SELECT k.rodzaj, count(*), max(k.dataUr), min(k.dataUr)
FROM wikingowie.kreatura k group by k.rodzaj;

#lub uzyc UNION
select k.rodzaj, k.nazwa, min(k.dataUr), max(k.dataUr) 
from wikingowie.kreatura k 
union
select k.rodzaj, k.nazwa, min(k.dataUr), max(k.dataUr) 
from wikingowie.kreatura k group by k.rodzaj;

select a.nazwa,a.rodzaj,a.dataUr from wikingowie.kreatura a, 
(SELECT min(dataUr) min, max(dataUr) max from wikingowie.kreatura b
group by rodzaj b WHERE b.min=a.dataUr ON b.max=a.dataUr;


#lab7 zadanie 1.2
show create table wikingowie.uczestnicy;
#podzapytanie lub left join
select k.nazwa, k.idKreatury, u.id_uczestnika 
from wikingowie.kreatura k
left join  wikingowie.uczestnicy u ON k.idKreatury=u.id_uczestnika
where u.id_uczestnika is null;

#lab7 zadanie 1.3
SELECT w.nazwa, sum(e.ilosc) FROM wikingowie.wyprawa w
inner join wikingowie.uczestnicy u ON w.id_wyprawy=u.id_wyprawy
inner join wikingowie.ekwipunek e ON u.id_uczestnika=e.idKreatury
group by w.id_wyprawy;

#lab7 zadanie 2.1
select w.nazwa, count(u.id_uczestnika), 
group_concat(k.nazwa separator ' | ')
from wikingowie.wyprawa w 
join wikingowie.uczestnicy u ON u.id_wyprawy=w.id_wyprawy
join wikingowie.kreatura k ON k.idKreatury=u.id_uczestnika
group by w.id_wyprawy;

#lab7 zadanie 2.2
select w.nazwa, w.data_rozpoczecia, k.nazwa as kierownik, ew.kolejnosc, s.nazwa
from wikingowie.etapy_wyprawy ew 
join wikingowie.sektor s ON ew.sektor=s.id_sektora
join wikingowie.wyprawa w ON w.id_wyprawy=ew.idWyprawy
join wikingowie.kreatura k ON k.idKreatury=w.kierownik
order by w.data_rozpoczecia desc, ew.kolejnosc asc;


#lab7 zadanie 3.1
select count(id_sektora) from wikingowie.sektor;
select count(distinct sektor) from wikingowie.etapy_wyprawy;

select nazwa, ifnull(waga,'bez wagi') from wikingowie.kreatura;
select nazwa, if(waga is null,'bez wagi',waga) 
from wikingowie.kreatura;

select s.nazwa, ifnull(count(ew.sektor),'0') as ilosc_odwiedzin
FROM wikingowie.sektor s
left join wikingowie.etapy_wyprawy ew ON ew.sektor=s.id_sektora 
GROUP BY s.id_sektora;

#lab7 zadanie 3.2
SELECT k.nazwa, 
if(count(u.id_wyprawy)=0,
'nie brał udziału w wyprawie','Brał udział w wyprawie') 
FROM wikingowie.kreatura k
LEFT JOIN wikingowie.uczestnicy u  ON k.idkreatury=u.id_uczestnika
group by k.nazwa;