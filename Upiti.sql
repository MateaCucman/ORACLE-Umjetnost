--  1
-- 1. Navedi ime i prezime svih umjetnika čija je država podrijetla Njemačka.
SELECT ime, prezime
FROM Umjetnik_Autor
WHERE drzava_podrijetla = 'Njemačka';

-- 2. Navedi naziv i mjesto nastanka umjetničkih djela.
SELECT naziv, mjesto_nastanka
FROM Umjetnicko_djelo;

-- 3. Navedi sve književne vrste koje se trenutno nalaze u bazi.
SELECT knjizevna_vrsta
FROM Knjizevno_djelo;

-- 4. Navedi sva umjetnička djela koja su nastala nakon 1800.
SELECT naziv
FROM Umjetnicko_djelo
WHERE godina_nastanka > 1800;

-- 5. Navedi sva razdoblja i kada počinju.
SELECT naziv, pocetak
FROM Razdoblje;


--  2
-- 1. Navedi sva likovna djela rađena na platnu te njihove motive.
SELECT naziv, motiv
FROM Umjetnicko_djelo join Likovno_djelo USING(ID_djela)
WHERE tehnika LIKE '%na platnu';

-- 2. Navedi sva djela koja pripadaju nekoj galeriji i kojoj galeriji pripadaju.
SELECT d.naziv djelo, g.naziv galerija
FROM Umjetnicko_djelo d JOIN Likovno_djelo l Using(ID_djela)
                        JOIN Muzej_Galerija g using(ID_muzeja);

-- 3. Navedi sva glazbena djela, tko ih izvodi i tko im je autor.
SELECT u.naziv djelo, (i.naziv||' '||i.vrsta) izvodac, (a.ime || ' ' || a.prezime) autor
FROM Umjetnicko_djelo u JOIN Glazbeno_djelo USING(ID_djela)
                        JOIN Djelo_izvodi ON ID_djela = Djelo_ID_djela
                        JOIN Izvodac i ON ID_izvodaca = Izvodac_ID_izvodaca
                        JOIN Umjetnicko_djelo_Umjetnik ON ID_djela = Umjetnicko_djelo_ID_djela
                        JOIN Umjetnik_Autor a ON Umjetnik_ID_umjetnika = ID_umjetnika;

-- 4. Navedi sve umjetnike i kojim razdobljima pripadaju, poredaj ih kronološki.
SELECT u.ime ||' '||u.prezime umjetnik, r.naziv
FROM Umjetnik_Autor u JOIN Umjetnicko_djelo_Umjetnik ON ID_umjetnika = Umjetnik_ID_umjetnika
                      JOIN Umjetnicko_djelo ON Umjetnicko_djelo_ID_djela = ID_djela
                      JOIN Razdoblje r USING(ID_razdoblja)
    ORDER BY r.pocetak;

-- 5. Navedi sva instrumentalna glazbena djela i mjesto njihova nastanka.
SELECT d.naziv djelo, d.mjesto_nastanka
FROM Umjetnicko_djelo d JOIN Glazbeno_djelo g USING(ID_djela)
WHERE g.vrsta = 'instrumentalno';


--  3
-- 1. Navedi sve muzeje i koliko djela je u njima.
SELECT m.naziv, COUNT(ID_djela) broj_djela
FROM Muzej_Galerija m JOIN Likovno_djelo d USING(ID_muzeja)
GROUP BY m.naziv;

-- 2. Koliko ima djela nastalih u razdoblju klasicizma i moderne umjetnosti?
SELECT r.naziv, COUNT(ID_djela) broj_djela
FROM Razdoblje r JOIN Umjetnicko_djelo USING(ID_razdoblja)
WHERE r.naziv = 'Klasicizam/Romantizam' OR r.naziv = 'Moderna umjetnost'
GROUP BY r.naziv;

-- 3. Koji je prosječan broj godina svih umjetnika, zaokruženo na 2 decimale?
SELECT ROUND(AVG(godina_smrti-godina_rodenja),2) prosjecan_broj_godina
FROM Umjetnik_Autor;

-- 4. Koliko je umjetnika rodeno izmedu 1500 i 1700.?
SELECT COUNT(ID_umjetnika) umjetnici
FROM Umjetnik_Autor
WHERE godina_rodenja > 1500 AND godina_rodenja < 1700;

-- 5. Navedi djela i njihove motive u listi uredenih parova oblika (djelo,motiv).
SELECT LISTAGG('(' || naziv || ',' || motiv || ')',', ') motivi
FROM Likovno_djelo JOIN Umjetnicko_djelo USING(ID_djela);


--  4
-- 1. Koji umjetnici su 'najstariji' i 'najstariji', tj. koji se rodio najranije, odnosno najkasnije? 
--    Navedi godine rođenja i smrti, ako ima.
SELECT ime ||' '|| prezime, godina_rodenja, godina_smrti
FROM Umjetnik_Autor
WHERE godina_rodenja = (SELECT MIN(godina_rodenja) FROM Umjetnik_Autor) OR
      godina_rodenja = (SELECT MAX(godina_rodenja) FROM Umjetnik_Autor);

-- 2. Ispiši sve podatke za glumca koji je imao najmanje godina.
SELECT ID_umjetnika, ime, prezime, godina_rodenja, godina_smrti, drzava_podrijetla
FROM Umjetnik_Autor
WHERE (godina_smrti-godina_rodenja)=(SELECT MIN(godina_smrti-godina_rodenja) FROM Umjetnik_Autor); 

-- 3. Koliko je u bazi likovnih djela te koliko od njih je pravljeno uljanim bojama?
SELECT 
  (SELECT COUNT(*) FROM likovno_djelo) ukupno_djela,
  (SELECT COUNT(*) FROM likovno_djelo WHERE tehnika LIKE 'Ulje%') djela_ulje
FROM dual;

-- 4. Ispiši sve zajedničke podatke za najstarije likovno, glazbeno i književno djelo u bazi.
SELECT ID_djela, naziv, godina_nastanka, mjesto_nastanka
FROM Umjetnicko_djelo RIGHT JOIN Knjizevno_djelo USING(ID_djela)
WHERE godina_nastanka = (SELECT MIN(godina_nastanka) FROM Umjetnicko_djelo 
      RIGHT JOIN Knjizevno_djelo USING(ID_djela))
UNION
SELECT ID_djela, naziv, godina_nastanka, mjesto_nastanka
FROM Umjetnicko_djelo RIGHT JOIN Likovno_djelo USING(ID_djela)
WHERE godina_nastanka = (SELECT MIN(godina_nastanka) FROM Umjetnicko_djelo 
      RIGHT JOIN Likovno_djelo USING(ID_djela))
UNION
SELECT ID_djela, naziv, godina_nastanka, mjesto_nastanka
FROM Umjetnicko_djelo RIGHT JOIN Glazbeno_djelo USING(ID_djela)
WHERE godina_nastanka = (SELECT MIN(godina_nastanka) FROM Umjetnicko_djelo 
      RIGHT JOIN Glazbeno_djelo USING(ID_djela));

-- 5. Za djela iz razdoblja moderne umjetnosti navedi njihov naziv i autora.
SELECT d.naziv, a.ime || ' ' || a.prezime autor
FROM Umjetnicko_djelo d JOIN Umjetnicko_djelo_Umjetnik ON ID_djela = Umjetnicko_djelo_ID_djela 
                        JOIN Umjetnik_Autor a ON Umjetnik_ID_umjetnika = ID_umjetnika
WHERE ID_djela IN (
      SELECT ID_djela 
      FROM Umjetnicko_djelo JOIN Razdoblje r USING(ID_razdoblja) 
      WHERE r.naziv = 'Moderna umjetnost'
);



-- 1. 
CREATE PROCEDURE PrebaciDjeloUMuzej(
      pID_djela IN NUMBER, pID_muzeja IN NUMBER, 
      vNazivDjela OUT VARCHAR2, vGradMuzeja OUT VARCHAR2) AS
BEGIN
    -- Dohvaćanje naziva djela
    SELECT naziv INTO vNazivDjela FROM Umjetnicko_djelo WHERE ID_djela = pID_djela;
    
    -- Dohvaćanje grada muzeja
    SELECT grad INTO vGradMuzeja FROM Muzej_Galerija WHERE ID_muzeja = pID_muzeja;
    
    -- Ažuriranje podataka o muzeju u likovnom djelu
    UPDATE Likovno_djelo SET ID_muzeja = pID_muzeja WHERE ID_djela = pID_djela;
END;
/
-- poziv procedure
DECLARE vNazivDjela VARCHAR2(100);
        vGradMuzeja VARCHAR2(100);
BEGIN
PrebaciDjeloUMuzej(0,1,vNazivDjela, vGradMuzeja);
END;
/

-- 2. 
CREATE PROCEDURE Naziv_djela(pID IN number, pNoviNaziv IN VARCHAR2) 
AS brojac NUMBER;
BEGIN
      SELECT COUNT(*) INTO brojac 
      FROM Umjetnicko_djelo Where ID_djela = pID;
      IF brojac=1 THEN
            UPDATE Umjetnicko_djelo
            SET naziv = pNoviNaziv
            WHERE ID_djela = pID;
      END IF;
END;
/
-- poziv procedure
call Naziv_djela(0,'MonaLisa');

-- Sva djela koja pripadaju nekoj galeriji i kojoj galeriji pripadaju.
SELECT d.naziv djelo, g.naziv galerija
FROM Umjetnicko_djelo d JOIN Likovno_djelo l Using(ID_djela)
                        JOIN Muzej_Galerija g using(ID_muzeja);

update LIKOVNO_DJELO set ID_MUZEJA = 0 where ID_DJELA = 0;
call Naziv_djela(0,'Mona Lisa');
COMMIT;



-- 1.
CREATE TRIGGER provjera_godine_nastanka 
BEFORE INSERT OR UPDATE OF godina_nastanka ON Umjetnicko_djelo
FOR EACH ROW
DECLARE
    pocetak_razdoblja NUMBER(5);
BEGIN
    SELECT ((pocetak-1)*100) INTO pocetak_razdoblja
    FROM Razdoblje r 
    WHERE r.ID_razdoblja = :NEW.ID_razdoblja;

    IF (:NEW.godina_nastanka < pocetak_razdoblja) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Godina nastanka ne može biti prije početka razdoblja.');
    END IF;
END;
/

INSERT INTO Umjetnicko_djelo
VALUES (10,'Mona Lisa',1506,'Firenca',2);

-- 2.
CREATE OR REPLACE TRIGGER godina_rodenja_i_smrti
BEFORE INSERT OR UPDATE OF godina_smrti ON UMJETNIK_AUTOR
FOR EACH ROW
BEGIN
      IF :NEW.godina_smrti < :NEW.godina_rodenja THEN
            RAISE_APPLICATION_ERROR(-20001, 'Godina smrti ne može biti prije godine rodenja.');
      END IF;
END;
/

SELECT * FROM Umjetnik_Autor WHERE ID_umjetnika = 0;
UPDATE Umjetnik_Autor SET godina_smrti = 1450 WHERE ID_umjetnika = 0;

