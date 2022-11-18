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