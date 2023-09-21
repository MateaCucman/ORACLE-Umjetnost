describe razdoblje;
select * from razdoblje;

INSERT INTO Razdoblje 
VALUES (0,'Srednji vijek', 5,15);

INSERT INTO Razdoblje
VALUES (1,'Renesansa',15,17);

INSERT INTO Razdoblje
VALUES (2,'Barok',17,18);

INSERT INTO Razdoblje
VALUES (3,'Klasicizam/Romantizam',18,19);

INSERT INTO Razdoblje
VALUES (4,'Moderna umjetnost',19,20);

describe muzej_galerija;
select * from muzej_galerija;

INSERT INTO Muzej_Galerija
VALUES (0,'Louvre','Francuska','Pariz');

INSERT INTO Muzej_Galerija
VALUES (1,'MOMA','New York City','New York');

INSERT INTO Muzej_Galerija
VALUES (2,'d`Orsay','Francuska','Pariz');

INSERT INTO Muzej_Galerija
VALUES (3,'Uffizi','Italija','Firenca');


describe Umjetnicko_djelo;
select * from umjetnicko_djelo;

INSERT INTO Umjetnicko_djelo
VALUES (0,'Mona Lisa',1506,'Firenca',1);

INSERT INTO Umjetnicko_djelo
VALUES (1,'Zvjezdana noć',1889,'umobolnica u Saint Remyju',4);

INSERT INTO Umjetnicko_djelo
VALUES (2,'Van Gogh autoportret',1889,'umobolnica u Saint Remyju',4);

INSERT INTO Umjetnicko_djelo (ID_djela,Naziv,Godina_nastanka,ID_razdoblja)
VALUES (3,'Rođenje Venere',1486,0);

INSERT INTO Umjetnicko_djelo
VALUES (4,'Povratak Filipa Latinovicza',1932,'Zagreb',4);

INSERT INTO Umjetnicko_djelo
VALUES (5,'Slap:Izabrane pjesme',1970,'Zagreb',4);

INSERT INTO Umjetnicko_djelo
VALUES (6,'Hamlet',1602,'London',1);

INSERT INTO Umjetnicko_djelo
VALUES (7,'Labuđe jezero',1877,'Moskva',3);

INSERT INTO Umjetnicko_djelo(ID_djela,Naziv,Godina_nastanka,ID_razdoblja)
VALUES (8,'Misa Solemnis',1823,3);

INSERT INTO Umjetnicko_djelo(ID_djela,Naziv,Godina_nastanka,ID_razdoblja)
VALUES (9,'Gospodar prstenova',1717,2);


describe likovno_djelo;
select * from likovno_djelo;

INSERT INTO Likovno_djelo 
VALUES (0,'Portret','Ulje na drvetu',0);

INSERT INTO Likovno_djelo 
VALUES (1,'Pejzaž','Ulje na platnu',1);

INSERT INTO Likovno_djelo 
VALUES (2,'Autoportret','Ulje na platnu',2);

INSERT INTO Likovno_djelo 
VALUES (3,'Akt','Tempera na platnu',3);


describe knjizevno_djelo;
select * from knjizevno_djelo;

INSERT INTO Knjizevno_djelo
VALUES (4,'roman','epika');

INSERT INTO Knjizevno_djelo
VALUES (5,'pjesme','lirika');

INSERT INTO Knjizevno_djelo
VALUES (6,'tragedija','drama');


describe glazbeno_djelo;
select * from glazbeno_djelo;

INSERT INTO Glazbeno_djelo
VALUES (7,'instrumentalno');

INSERT INTO Glazbeno_djelo
VALUES (8,'vokalno-instrumentalno');

INSERT INTO Glazbeno_djelo
VALUES (9,'instrumentalno');


describe izvodac;
select * from izvodac;

INSERT INTO Izvodac
VALUES (0,'simfonijski','orkestar');

INSERT INTO Izvodac
VALUES (1,'gudacki','orkestar');

INSERT INTO Izvodac
VALUES (2,'simfonijski','zbor');

INSERT INTO Izvodac
VALUES (3,'komorni','zbor');


describe djelo_izvodi;
select * from djelo_izvodi;

INSERT INTO Djelo_izvodi
VALUES (7,0);

INSERT INTO Djelo_izvodi
VALUES (8,0);

INSERT INTO Djelo_izvodi
VALUES (8,2);

INSERT INTO Djelo_izvodi
VALUES (9,0);


describe umjetnik_autor;
select * from umjetnik_autor;

INSERT INTO Umjetnik_Autor
VALUES (0,'Leonardo','da Vinci',1452,1519,'Italija');

INSERT INTO Umjetnik_Autor
VALUES (1,'Vincent','van Gogh',1853,1890,'Nizozemska');

INSERT INTO Umjetnik_Autor
VALUES (2,'Sandro','Botticelli',1445,1510,'Italija');

INSERT INTO Umjetnik_Autor
VALUES (3,'Miroslav','Krleža',1893,1981,'Hrvatska');

INSERT INTO Umjetnik_Autor
VALUES (4,'Dobriša','Cesarić',1902,1980,'Hrvatska');

INSERT INTO Umjetnik_Autor
VALUES (5,'William','Shakespeare',1564,1616,'Ujedinjeno Kraljevstvo');

INSERT INTO Umjetnik_Autor
VALUES (6,'Johann Sebastian','Bach',1685,1750,'Njemačka');

INSERT INTO Umjetnik_Autor
VALUES (7,'Ludwig','van Beethoven',1770,1827,'Njemačka');

INSERT INTO Umjetnik_Autor
VALUES (8,'Georg','Friedrich Handel',1685,1759,'Njemačka');


describe umjetnicko_djelo_umjetnik;
select * from umjetnicko_djelo_umjetnik;

INSERT INTO Umjetnicko_djelo_Umjetnik
VALUES (0,0);

INSERT INTO Umjetnicko_djelo_Umjetnik
VALUES (1,1);

INSERT INTO Umjetnicko_djelo_Umjetnik
VALUES (2,1);

INSERT INTO Umjetnicko_djelo_Umjetnik
VALUES (3,2);

INSERT INTO Umjetnicko_djelo_Umjetnik
VALUES (4,3);

INSERT INTO Umjetnicko_djelo_Umjetnik
VALUES (5,4);

INSERT INTO Umjetnicko_djelo_Umjetnik
VALUES (6,5);

INSERT INTO Umjetnicko_djelo_Umjetnik
VALUES (7,6);

INSERT INTO Umjetnicko_djelo_Umjetnik
VALUES (8,7);

INSERT INTO Umjetnicko_djelo_Umjetnik
VALUES (9,8);