DROP TABLE Umjetnicko_djelo_Umjetnik;
DROP TABLE Umjetnik_Autor;
DROP TABLE Djelo_Izvodi;
DROP TABLE Izvodac;
DROP TABLE Glazbeno_djelo;
DROP TABLE Knjizevno_djelo;
DROP TABLE Likovno_djelo;
DROP TABLE Umjetnicko_djelo;
DROP TABLE Muzej_Galerija;
DROP TABLE Razdoblje;


CREATE TABLE Razdoblje (
    ID_razdoblja INTEGER CONSTRAINT razdoblje_pk PRIMARY KEY,
    Naziv VARCHAR2(50) NOT NULL,
    Pocetak NUMBER(2) NOT NULL,
    Kraj NUMBER(2) NOT NULL
);

CREATE TABLE Muzej_Galerija (
    ID_muzeja INTEGER CONSTRAINT muzej_pk PRIMARY KEY,
    Naziv VARCHAR2(50) NOT NULL,
    Drzava VARCHAR2(50),
    Grad VARCHAR2(50) NOT NULL
);

CREATE TABLE Umjetnicko_djelo (
    ID_djela INTEGER CONSTRAINT djelo_pk PRIMARY KEY,
    Naziv VARCHAR2(50) NOT NULL,
    Godina_nastanka NUMBER(4) NOT NULL,
    Mjesto_nastanka VARCHAR2(50),
    ID_razdoblja INTEGER CONSTRAINT djelo_razdoblje_fk REFERENCES Razdoblje(ID_razdoblja)
);

CREATE TABLE Likovno_djelo (
    ID_djela INTEGER CONSTRAINT likovno_djelo_pf PRIMARY KEY REFERENCES Umjetnicko_djelo(ID_djela),
    Motiv VARCHAR2(50) NOT NULL,
    Tehnika VARCHAR2(50) NOT NULL,
    ID_muzeja INTEGER CONSTRAINT djelo_muzej_fk REFERENCES Muzej_Galerija(ID_muzeja)
);

CREATE TABLE Knjizevno_djelo (
    ID_djela INTEGER CONSTRAINT knjizevno_djelo_pf PRIMARY KEY REFERENCES Umjetnicko_djelo(ID_djela),
    Knjizevna_vrsta VARCHAR2(50) NOT NULL,
    Knjizevni_rod VARCHAR2(50) NOT NULL
);

CREATE TABLE Glazbeno_djelo (
    ID_djela INTEGER CONSTRAINT glazbeno_djelo_pf PRIMARY KEY REFERENCES Umjetnicko_djelo(ID_djela),
    Vrsta VARCHAR2(50) NOT NULL
);

CREATE TABLE Izvodac (
    ID_izvodaca INTEGER CONSTRAINT izvodac_pk PRIMARY KEY,
    Naziv VARCHAR2(50) NOT NULL,
    Vrsta VARCHAR2(50) NOT NULL
);

CREATE TABLE Djelo_Izvodi (
    Djelo_ID_djela INTEGER CONSTRAINT djelo_izvodi_fk REFERENCES Glazbeno_djelo(ID_djela),
    Izvodac_ID_izvodaca INTEGER CONSTRAINT izvodac_djelo_fk REFERENCES Izvodac(ID_izvodaca),
    CONSTRAINT djelo_izvodi_pk PRIMARY KEY (Djelo_ID_djela, Izvodac_ID_izvodaca)
);

CREATE TABLE Umjetnik_Autor (
    ID_umjetnika INTEGER CONSTRAINT umjetnik_pk PRIMARY KEY,
    Ime VARCHAR2(50) NOT NULL,
    Prezime VARCHAR2(50),
    Godina_rodenja NUMBER(4) NOT NULL,
    Godina_smrti NUMBER(4),
    Drzava_podrijetla VARCHAR2(50)
);

CREATE TABLE Umjetnicko_djelo_Umjetnik (
    Umjetnicko_djelo_ID_djela CONSTRAINT umjetnicko_djelo_umjetnik_fk REFERENCES Umjetnicko_djelo(ID_djela),
    Umjetnik_ID_umjetnika CONSTRAINT umjetnik_djelo_fk REFERENCES Umjetnik_Autor(ID_umjetnika),
    CONSTRAINT umjetnicko_djelo_umjetnik_pk PRIMARY KEY (Umjetnicko_djelo_ID_djela, Umjetnik_ID_umjetnika)
);


ALTER TABLE Likovno_djelo
ADD CONSTRAINT motiv_ck
CHECK (Motiv IN ('Portret','Autoportret','Mrtva priroda','Pejzaž','Karikatura','Akt'));

ALTER TABLE Knjizevno_djelo 
ADD CONSTRAINT knjizevni_rod_ck
CHECK (Knjizevni_rod IN ('lirika','epika','drama'));

ALTER TABLE Glazbeno_djelo
ADD CONSTRAINT vrsta_ck
CHECK (Vrsta IN ('vokalno','instrumentalno','vokalno-instrumentalno'));


ALTER TABLE Umjetnik_Autor MODIFY Drzava_podrijetla DEFAULT 'nepoznata informacija';

ALTER TABLE Umjetnik_Autor MODIFY Prezime DEFAULT 'nepoznata informacija';

ALTER TABLE Umjetnicko_djelo MODIFY Mjesto_nastanka DEFAULT 'nepoznata informacija';


COMMENT ON TABLE Razdoblje IS 'Pocetak i kraj razdoblja izrazeni su u stoljecima.';

COMMENT ON TABLE Izvodac IS 'Izvodac se odnosi na zborove i orkestre koji izvode djelo';

COMMENT ON COLUMN Umjetnicko_djelo.mjesto_nastanka IS 'Mjesto se odnosi na grad ili, ako postoji, konkretnija lokacija';


CREATE INDEX i_umj_djelo_naziv ON Umjetnicko_djelo(naziv);
-- Nazivi djela se često koriste, u većini slučajeva su to različiti nazivi. 
-- Kako se umjetnička djela dijele još na 3 skupine ima ih znatno više nego podataka u drugim tablicama.

CREATE BITMAP INDEX ib_knj_djelo_rod ON Knjizevno_djelo(knjizevni_rod);
-- Književna roda ima samo 3, a djela su mnogobrojna, zbog čega će biti puno stupaca, a samo 3 različite vrijednosti.

CREATE BITMAP INDEX ib_gl_djelo_vrsta ON Glazbeno_djelo(vrsta);
-- Vrste također imaju samo 3 pa ima smisla staviti bitmap indek na ovaj stupac.


