CREATE TABLE Klient (
    id_klienta INT AUTO_INCREMENT PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    telefon VARCHAR(20)
);

INSERT INTO Klient (imie, nazwisko, email) VALUES 
('Adrianna', 'Piesik', 'adrianna.piesik@sklep.pl'),
('Bartek', 'Wojtanowicz', 'bartek.wojtanowicz@sklep.pl'),
('Stanislaw', 'Zynda', 'stanislaw.zynda@sklep.pl'),
('Olga', 'Leszkiewicz', 'olga.leszkiewicz@sklep.pl'),
('Agnieszka', 'Skalik', 'agnieszka.skalik@sklep.pl'),
('Fabian', 'Zwiazek', 'fabian.zwiazek@sklep.pl'),
('Anna Maria', 'Kuska', 'anna maria.kuska@sklep.pl'),
('Cyprian', 'Michalkiewicz', 'cyprian.michalkiewicz@sklep.pl'),
('Oskar', 'Dworniczak', 'oskar.dworniczak@sklep.pl'),
('Justyna', 'Drobek', 'justyna.drobek@sklep.pl'),
('Eryk', 'Teter', 'eryk.teter@sklep.pl'),
('Damian', 'Faferek', 'damian.faferek@sklep.pl'),
('Dawid', 'Niemczuk', 'dawid.niemczuk@sklep.pl'),
('Krystian', 'Jargilo', 'krystian.jargilo@sklep.pl'),
('Maciej', 'Mierzwiak', 'maciej.mierzwiak@sklep.pl'),
('Nataniel', 'Pachuta', 'nataniel.pachuta@sklep.pl'),
('Radoslaw', 'Fydrych', 'radoslaw.fydrych@sklep.pl'),
('Daniel', 'Przeklasa', 'daniel.przeklasa@sklep.pl'),
('Aleksander', 'Szumiec', 'aleksander.szumiec@sklep.pl'),
('Jakub', 'Kaczmar', 'jakub.kaczmar@sklep.pl'),
('Dominik', 'Czylok', 'dominik.czylok@sklep.pl'),
('Malwina', 'Bohdanowicz', 'malwina.bohdanowicz@sklep.pl'),
('Arkadiusz', 'Wenzel', 'arkadiusz.wenzel@sklep.pl'),
('Dorota', 'Jasnoch', 'dorota.jasnoch@sklep.pl'),
('Julita', 'Sobolak', 'julita.sobolak@sklep.pl'),
('Igor', 'Bos', 'igor.bos@sklep.pl'),
('Oskar', 'Wincenciak', 'oskar.wincenciak@sklep.pl'),
('Dawid', 'Galon', 'dawid.galon@sklep.pl'),
('Olga', 'Minkiewicz', 'olga.minkiewicz@sklep.pl'),
('Witold', 'Przekop', 'witold.przekop@sklep.pl');


CREATE TABLE stat (
    id_stat INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    stat_opis VARCHAR(100) NOT NULL
);

INSERT INTO stat(stat_opis) VALUES ("Dostepny"), ("Niedostepny"), ("Nieznany"), ("Zawieszony");

CREATE TABLE numer_tel (
    id_numer_tel INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    numer INT NOT NULL,
    id_stat INT NOT NULL,
    id_klienta INT,
    FOREIGN KEY (id_klienta) REFERENCES Klient(id_klienta),
    FOREIGN KEY (id_stat) REFERENCES stat(id_stat)
);

INSERT INTO numer_tel(numer, id_stat) VALUES (123456789, 1),(987654321, 1),(135798642, 2),(246897531, 3),
(975318642, 2),(987123654, 4),(321654987, 2),(654987321, 1),(852963741, 3),(753951456, 4),(159753486, 2),
(456852739, 1),(741963852, 3),(963258147, 4),(147852369, 2),(258963741, 1),(369147852, 3),(741258963, 4),
(852369147, 2),(963741258, 1),(147852963, 3),(258147369, 4),(369258147, 2),(741369258, 1),(852741369, 3),
(963852741, 4),(147963852, 2),(258741963, 1),(369852741, 3),(741963258, 4);


CREATE TRIGGER przypisz_telefon
BEFORE INSERT ON Klient
FOR EACH ROW
BEGIN
    DECLARE dostepny_numer INT;
    SELECT numer INTO dostepny_numer FROM numer_tel WHERE id_stat = 1 LIMIT 1;
    IF dostepny_numer IS NOT NULL THEN
        SET NEW.telefon = dostepny_numer;
    END IF;
END;

CREATE TRIGGER aktualizuj_numer_tel
AFTER INSERT ON Klient
FOR EACH ROW
BEGIN
    IF NEW.telefon IS NOT NULL THEN
        UPDATE numer_tel SET id_stat = 2, id_klienta = NEW.id_klienta WHERE numer = NEW.telefon;
    END IF;
END;


create TABLE Zamowienie (
    id_zamowienia INT PRIMARY KEY,
    id_klienta INT,
    cena int,
    data_zamowienia DATE,
    FOREIGN KEY (id_klienta) REFERENCES Klient(id_klienta)
);


INSERT INTO Zamowienie (id_zamowienia, id_klienta, data_zamowienia) VALUES 
(1, 1, '2024-02-22'),(2, 2, '2024-02-19'),(3, 3, '2024-02-10'),(4, 4, '2024-02-26'),(5, 5, '2024-02-26'),
(6, 6, '2024-01-22'),(7, 7, '2024-02-15'),(8, 8, '2024-03-05'),(9, 9, '2024-01-30'),
(10, 10, '2024-02-07'),(11, 11, '2024-01-12'),(12, 12, '2024-02-03'),(13, 13, '2024-03-08'),
(14, 14, '2024-01-17'),(15, 15, '2024-03-01'),(16, 16, '2024-02-25'),(17, 17, '2024-01-20'),
(18, 18, '2024-01-15'),(19, 19, '2024-02-14'),(20, 20, '2024-02-11'),(21, 21, '2024-02-27'),(22, 22, '2024-02-08'),
(23, 23, '2024-02-16'),(24, 24, '2024-03-03'),(25, 25, '2024-02-18'),(26, 26, '2024-01-13'),
(27, 27, '2024-03-07'),(28, 28, '2024-01-11'),(29, 29, '2024-03-04'),(30, 30, '2024-01-14');

insert into Zamowienie (id_zamowienia, id_klienta, data_zamowienia) values (31, 2, '2023-02-19')

create table Platnosc (
	id_plat INT NOT NULL auto_increment primary key,
	id_klienta INT not NULL,
	id_zam INT not NULL,
	kwota INT not NULL,
	dostawca VARCHAR(100) not NULL,
	status VARCHAR(100) not NULL,
	data_wys DATE not NULL,
	deadline DATE,
	FOREIGN KEY (id_klienta) REFERENCES Klient(id_klienta),
	FOREIGN KEY (id_zam) REFERENCES Zamowienie(id_zamowienia)
);


CREATE TRIGGER after_payment_insert
before INSERT ON Platnosc FOR EACH ROW
BEGIN
    SET new.deadline = DATE_ADD(NEW.data_wys, INTERVAL 7 DAY);
end;

INSERT INTO Platnosc (id_klienta, id_zam, kwota, dostawca, status, data_wys) VALUES 
(1, 1, 697, 'Bank Millennium', 'anulowany', '2024-02-13'),(2, 2, 341, 'ING Bank Slaski', 'w trakcie', '2024-02-21'),
(3, 3, 198, 'ING Bank Slaski', 'w trakcie', '2024-03-01'),(4, 4, 895, 'Bank Pekao', 'w trakcie', '2024-02-15'),
(5, 5, 888, 'PKO Bank Polski', 'zakonczono', '2024-01-30'),(6, 6, 153, 'Santander Bank', 'anulowany', '2024-02-22'),
(7, 7, 270, 'ING Bank Slaski', 'anulowany', '2024-02-07'),(8, 8, 354, 'Bank Pekao', 'anulowany', '2024-01-30'),
(9, 9, 976, 'Bank Millennium', 'w trakcie', '2024-03-04'),(10, 10, 719, 'ING Bank Slaski', 'w trakcie', '2024-01-10'),
(11, 11, 696, 'ING Bank Slaski', 'w trakcie', '2024-02-11'),(12, 12, 175, 'Bank Pekao', 'anulowany', '2024-02-28'),
(13, 13, 851, 'Bank Pekao', 'anulowany', '2024-02-06'),(14, 14, 994, 'Bank Pekao', 'zakonczono', '2024-03-02'),
(15, 15, 427, 'Bank Pekao', 'anulowany', '2024-02-27'),(16, 16, 395, 'ING Bank Slaski', 'zakonczono', '2024-02-28'),
(17, 17, 386, 'Bank Pekao', 'w trakcie', '2024-02-16'),(18, 18, 431, 'Bank Pekao', 'anulowany', '2024-01-31'),
(19, 19, 914, 'Bank Pekao', 'w trakcie', '2024-01-29'),(20, 20, 429, 'Bank Millennium', 'w trakcie', '2024-02-18'),
(21, 21, 784, 'Bank Millennium', 'zakonczono', '2024-01-19'),(22, 22, 669, 'ING Bank Slaski', 'w trakcie', '2024-01-10'),
(23, 23, 601, 'Santander Bank', 'anulowany', '2024-02-13'),(24, 24, 388, 'PKO Bank Polski', 'anulowany', '2024-02-17'),
(25, 25, 293, 'Santander Bank', 'w trakcie', '2024-03-07'),(26, 26, 798, 'Bank Pekao', 'w trakcie', '2024-01-11'),
(27, 27, 684, 'PKO Bank Polski', 'zakonczono', '2024-02-04'),(28, 28, 460, 'PKO Bank Polski', 'w trakcie', '2024-02-01'),
(29, 29, 874, 'Bank Pekao', 'zakonczono', '2024-03-03'),(30, 30, 900, 'Bank Pekao', 'zakonczono', '2024-02-23');

CREATE TABLE KategoriaProduktu (
    id_kategorii INT PRIMARY KEY,
    nazwa_kategorii VARCHAR(100)
);

INSERT INTO KategoriaProduktu (id_kategorii, nazwa_kategorii) VALUES
(1, 'Odziez meska'),(2, 'Odziez damska'),
(3, 'Obuwie meskie'),(4, 'Obuwie damskie'),(5, 'Akcesoria');


CREATE TABLE Produkt (
    id_produktu INT PRIMARY KEY,
    nazwa_produktu VARCHAR(100),
    cena DECIMAL(10,2),
    id_kategorii INT,
    FOREIGN KEY (id_kategorii) REFERENCES KategoriaProduktu(id_kategorii)
);



INSERT INTO Produkt (id_produktu, nazwa_produktu, cena, id_kategorii) VALUES 
(1, 'Koszulka', 88.83,1),(2, 'Spodnie', 486.94,1),(3, 'Sweter', 311.48,2),(4, 'Kurtka', 206.06,1),
(5, 'Sukienka', 395.93,2),(6, 'Bluza', 222.26,2),(7, 'Szorty', 246.6,1),(8, 'Plaszcz', 285.64,2),
(9, 'Marynarka', 357.37,1),(10, 'Jeansy', 289.75,1),(11, 'T-shirt', 376.42,1),(12, 'Spodnica', 110.51,2),
(13, 'Bluzka', 114.39,2),(14, 'Kapelusz', 360.72,5),(15, 'Rekawiczki', 415.82,5),(16, 'Skarpetki', 123.14,5),(17, 'Krawat', 363.11,5),
(18, 'Szalik', 113.9,5),(19, 'Pasek', 155.26,5),(20, 'Buty sportowe', 113.85,3),(21, 'Sandaly', 402.81,3),
(22, 'Kozaki', 392.99,4),(23, 'Szpilki', 379.67,4),(24, 'Trampki', 185.14,3),(25, 'Mokasyny', 339.03,4),
(26, 'Koszula', 213.59,1),(27, 'Jeansy', 137.54,2),(28, 'Bielizna', 372.44,2),(29, 'Pizama', 420.32,2),(30, 'Szorty kapielowe', 399.21,1);



CREATE TABLE StatZam (
    id_statzam INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    statzam_opis VARCHAR(100) NOT NULL,
    id_produktu INT,
    FOREIGN KEY (id_produktu) REFERENCES Produkt(id_produktu)
);

INSERT INTO StatZam (id_statzam, statzam_opis, id_produktu) VALUES
(1, 'przyjete', 1),(2, 'przyjete', 4),(3, 'odebrane przez klienta', 3),(4, 'przyjete', 1),
(5, 'zamowienie wyslano', 3),(6, 'przyjete', 4),(7, 'przygotowanie', 4),(8, 'anulowane', 3),
(9, 'przyjete', 2),(10, 'przyjete', 3),(11, 'zamowienie wyslano', 4),(12, 'anulowane', 2),
(13, 'zamowienie wyslano', 2),(14, 'odebrane przez klienta', 3),(15, 'przyjete', 2),(16, 'przygotowanie', 2),
(17, 'zamowienie wyslano', 3),(18, 'zamowienie wyslano', 2),
(19, 'przyjete', 1),(20, 'przygotowanie', 4),(21, 'przyjete', 2),
(22, 'zamowienie wyslano', 1),(23, 'anulowane', 1),(24, 'anulowane', 1),(25, 'odebrane przez klienta', 4),
(26, 'przyjete', 1),(27, 'przygotowanie', 2),(28, 'anulowane', 2),(29, 'odebrane przez klienta', 2),
(30, 'zamowienie wyslano', 2);



CREATE PROCEDURE GetCenaFromStatZam(IN statzam_id INT)
BEGIN
    SELECT 
        s.id_statzam,
        s.statzam_opis,
        p.id_produktu,
        p.nazwa_produktu,
        p.cena
    FROM 
        StatZam s
    JOIN 
        Produkt p ON s.id_produktu = p.id_produktu
    WHERE 
        s.id_statzam = statzam_id;
end;


CREATE TABLE StanZamowienia (
    id_stan INT PRIMARY KEY,
    id_zamowienia INT,
    id_produktu INT,
    ilosc INT,
    foreign key (id_stan) references StatZam(id_statzam),
    FOREIGN KEY (id_zamowienia) REFERENCES Zamowienie(id_zamowienia),
    FOREIGN KEY (id_produktu) REFERENCES Produkt(id_produktu)
);


INSERT INTO StanZamowienia (id_stan, id_zamowienia, id_produktu, ilosc) VALUES
(1, 5, 1, 5),(2, 6, 4, 5),(3, 6, 4, 1),(4, 1, 4, 2),
(5, 9, 4, 3),(6, 2, 4, 2),(7, 2, 3, 1),(8, 5, 4, 2),
(9, 1, 4, 5),(10, 3, 2, 1),(11, 2, 2, 1),(12, 2, 3, 5),
(13, 8, 4, 3),(14, 7, 3, 4),(15, 8, 2, 2),
(16, 8, 4, 2),(17, 6, 4, 4),(18, 6, 2, 3),(19, 9, 1, 3),
(20, 2, 4, 5),(21, 2, 2, 5),(22, 5, 1, 4),(23, 9, 3, 3),
(24, 7, 1, 1),(25, 4, 1, 4),(26, 3, 1, 2),(27, 7, 2, 2),
(28, 3, 2, 4),(29, 8, 1, 3),(30, 1, 2, 4);


create TABLE Magazyn (
    id_magazynu INT PRIMARY KEY,
    ulica_magazynu VARCHAR(100)
);

INSERT INTO Magazyn (id_magazynu, ulica_magazynu) VALUES
(1, 'Marszalkowska'),(2, 'Pilsudskiego'),(3, 'Krakowskie Przedmiescie'),(4, 'Aleje Jerozolimskie'),
(5, 'Nowy Swiat'),(6, 'Poznanska'),(7, 'Wawelska'),(8, 'Sloneczna'),
(9, 'Grunwaldzka'),(10, 'Sienkiewicza'),(11, 'Mickiewicza'),(12, 'Slowackiego'),
(13, 'Kopernika'),(14, 'Reymonta'),(15, 'Zeromskiego'),(16, 'Asnyka'),
(17, 'Paderewskiego'),(18, 'Moniuszki'),(19, 'Dworcowa'),
(20, 'Kosciuszki'),(21, '3 Maja'),(22, '11 Listopada'),(23, 'Pomorska'),
(24, 'Lodzka'),(25, 'Gdanska'),(26, 'Warszawska'),
(27, 'Krakowska'),(28, 'Katowicka'),(29, 'Wroclawska'),(30, 'Szczecinska');



CREATE TABLE StanMagazynowy (
    id_stanu_magazynowego INT PRIMARY KEY,
    id_magazynu INT,
    id_produktu INT,
    ilosc INT,
    FOREIGN KEY (id_magazynu) REFERENCES Magazyn(id_magazynu),
    FOREIGN KEY (id_produktu) REFERENCES Produkt(id_produktu)
);

INSERT INTO StanMagazynowy (id_stanu_magazynowego, id_magazynu, id_produktu, ilosc) VALUES
(1, 5, 1, 9),(2, 28, 1, 40),(3, 17, 1, 10),(4, 27, 4, 35),
(5, 3, 2, 58),(6, 26, 1, 99),(7, 13, 4, 4),(8, 16, 3, 20),
(9, 8, 4, 97),(10, 16, 1, 83),(11, 16, 1, 60),(12, 14, 1, 100),
(13, 16, 2, 20),(14, 7, 1, 35),(15, 7, 4, 91),(16, 19, 2, 67),
(17, 20, 2, 73),(18, 24, 1, 72),(19, 14, 2, 72),(20, 30, 2, 58),
(21, 9, 4, 46),(22, 18, 1, 74),(23, 19, 2, 73),(24, 8, 2, 3),
(25, 25, 3, 28),(26, 22, 1, 76),(27, 9, 2, 82),(28, 12, 1, 82),(29, 21, 4, 82),(30, 2, 1, 69);




-- Funkcje

CREATE FUNCTION DodajCeneZNizka(pCena DECIMAL(10,2)) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE nowaCena DECIMAL(10,2);
    SET nowaCena = pCena * 0.9; -- 10% zniżki
    RETURN nowaCena;
END;


CREATE FUNCTION DostepnaIloscWMagazynie(p_id_produktu INT) RETURNS INT
BEGIN
    DECLARE suma INT;

    SELECT SUM(ilosc) INTO suma
    FROM StanMagazynowy
    WHERE id_produktu = p_id_produktu;

    RETURN suma;
END;


-- Widoki
CREATE VIEW ZamowienieInfo AS
SELECT
    z.id_zamowienia,
    z.data_zamowienia,
    k.imie AS imie_klienta,
    k.nazwisko AS nazwisko_klienta
FROM
    Zamowienie z
JOIN Klient k ON z.id_klienta = k.id_klienta;

select * from ZamowienieInfo;

-- Indeksowanie

CREATE INDEX idx_cena_produktu ON Produkt(cena);

CREATE INDEX idx_ilosc_stanu_magazynowego ON StanMagazynowy(ilosc);


ALTER TABLE Zamowienie
ADD CONSTRAINT fk_zamowienie_klient
FOREIGN KEY (id_klienta) REFERENCES Klient(id_klienta);

ALTER TABLE stanzamowienia
ADD CONSTRAINT fk_stan_zamowienia
FOREIGN KEY (id_zamowienia) REFERENCES Zamowienie(id_zamowienia);

ALTER TABLE StanZamowienia
ADD CONSTRAINT fk_stan_zamowienia_produkt
FOREIGN KEY (id_produktu) REFERENCES Produkt(id_produktu);

ALTER TABLE StanMagazynowy
ADD CONSTRAINT fk_stan_magazynowy_magazyn
FOREIGN KEY (id_magazynu) REFERENCES Magazyn(id_magazynu);

ALTER TABLE StanMagazynowy
ADD CONSTRAINT fk_stan_magazynowy_produkt
FOREIGN KEY (id_produktu) REFERENCES Produkt(id_produktu);


CREATE TABLE OcenaProduktu (
    id_oceny INT PRIMARY KEY,
    id_produktu INT,
    ocena INT,
    FOREIGN KEY (id_produktu) REFERENCES Produkt(id_produktu)
);

INSERT INTO OcenaProduktu (id_oceny, id_produktu, ocena) VALUES
(1, 1, 4),(2, 2, 5),(3, 3, 3),(4, 4, 2),
(5, 5, 4),(6, 6, 5),(7, 7, 3),(8, 8, 4),
(9, 9, 5),(10, 10, 2),(11, 11, 4),(12, 12, 3),
(13, 13, 5),(14, 14, 2),(15, 15, 4),(16, 16, 3),
(17, 17, 5),(18, 18, 4),(19, 19, 2),(20, 20, 3),
(21, 21, 5),(22, 22, 4),(23, 23, 2),(24, 24, 3),
(25, 25, 5),(26, 26, 4),(27, 27, 2),(28, 28, 3),
(29, 29, 5),(30, 30, 4);


CREATE or replace VIEW ProduktZKategoria AS
SELECT
    p.id_produktu,
    p.nazwa_produktu,
    k.nazwa_kategorii
FROM
    Produkt p
left JOIN KategoriaProduktu k ON p.id_kategorii = k.id_kategorii;


CREATE VIEW ProduktZOcena AS
SELECT
    p.id_produktu,
    p.nazwa_produktu,
    o.ocena
FROM
    Produkt p
LEFT JOIN OcenaProduktu o ON p.id_produktu = o.id_produktu;


CREATE PROCEDURE WyszukajKlientaPoNazwisku(IN p_nazwisko VARCHAR(50))
BEGIN
    SELECT * FROM Klient WHERE nazwisko LIKE p_nazwisko;
end;

CREATE PROCEDURE OcenaZaokraglona(IN ocena DECIMAL(3,2), OUT wynik VARCHAR(15))
BEGIN
    IF ocena = FLOOR(ocena) THEN
        SET wynik = CONCAT('Dokładnie ', ocena);
    ELSEIF ocena < FLOOR(ocena) + 0.5 THEN
        SET wynik = CONCAT('Powyżej ', FLOOR(ocena));
    ELSE
        SET wynik = CONCAT('Poniżej ', FLOOR(ocena) + 1);
    END IF;
end;

#Trigger z przypisaniem numeru telefonu
select * from Klient;
select * from numer_tel;
select * from stat;
INSERT INTO Klient (imie, nazwisko, email) VALUES 
('Bazy1', 'Danych1', 'bazy1.danych1@sklep.pl');

#Trigger z utworzeniem daty dealine
select * from Platnosc;

INSERT INTO Platnosc (id_klienta, id_zam, kwota, dostawca, status, data_wys) VALUES 
(3, 3, 198, 'Nowy bank', 'w trakcie', '2025-07-07');

SELECT * FROM ProduktZKategoria 

SELECT * FROM ProduktZOcena 

SELECT * FROM ZamowienieInfo


#CREATE PROCEDURE WyszukajKlientaPoNazwisku
call WyszukajKlientaPoNazwisku('Piesik');

#CREATE PROCEDURE GetCenaFromStatZam
CALL GetCenaFromStatZam(1);

#Funkcja DostepnaIloscWMagazynie
SELECT nazwa_produktu, DostepnaIloscWMagazynie(id_produktu) AS DostepnaIlosc FROM Produkt;

#Funkcja DodajCeneZNizka
#Wyświetlenie cen przed zniżką
SELECT id_produktu, nazwa_produktu, cena FROM Produkt;
#Aktualizacja cen z użyciem funkcji
UPDATE Produkt SET cena = DodajCeneZNizka(cena);
#Wyświetlenie cen po zniżce
SELECT id_produktu, nazwa_produktu, cena FROM Produkt;



