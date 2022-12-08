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
SELECT k.nazwa, z.nazwa, dataUr  FROM wikingowie.zasob z INNER JOIN wikingowie.kreatura k INNER JOIN wikingowie.ekwipunek ON wikingowie.ekwipunek.idKreatury=k.idKreatury ON wikingowie.ekwipunek.idZasobu=z.idZasobu WHERE dataUr LIKE '167%';

#lab6 zadanie 4.2
SELECT dataUr, k.nazwa, z.rodzaj FROM wikingowie.kreatura k INNER JOIN wikingowie.ekwipunek e INNER JOIN wikingowie.zasob z ON z.idZasobu=e.idZasobu ON k.idKreatury=e.idKreatury WHERE z.rodzaj='jedzenie' ORDER BY dataUr ASC LIMIT 5;

