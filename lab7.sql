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
