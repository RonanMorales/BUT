DROP TABLE Contenir;
DROP TABLE Referencer;
DROP TABLE Vendre;
DROP TABLE Commande;
DROP TABLE Illustrer;
DROP TABLE Adresse;
DROP TABLE Produit;
DROP TABLE ImagesProduits;
DROP TABLE Ville;
DROP TABLE TypeAdresse;
DROP TABLE Client;
DROP TABLE Fournisseur;
DROP TABLE TypeTVA;
DROP TABLE Marque;
DROP TABLE CategorieProduit;
DROP TABLE Calendriier;

CREATE TABLE Calendriier (
    uneDate DATE,
    CONSTRAINT pk_calendrier_uneDate PRIMARY KEY (uneDate)
);
CREATE TABLE CategorieProduit (
    idCategorieProduits INT,
    libelleCategorieProduit VARCHAR(100),
    estSousCategorie INT,
    CONSTRAINT pk_categorieProduit_idC PRIMARY KEY (idCategorieProduits),
    CONSTRAINT ck_categorieProduit_libelle CHECK (libelleCategorieProduit is NOT NULL),
    CONSTRAINT fk_categorie_sousCategorie FOREIGN KEY (estSousCategorie) REFERENCES CategorieProduit(idCategorieProduits)
);
CREATE TABLE Marque (
    idMarque INT,
    libelleMarque VARCHAR(75),
    CONSTRAINT pk_marque_idMarque PRIMARY KEY (idMarque),
    CONSTRAINT ck_marque_libelleMarque CHECK (libelleMarque is NOT NULL)
);

CREATE TABLE TypeTVA (
    tauxTVA DECIMAL(4,2),
    CONSTRAINT pk_typeTVA_tauxTVA PRIMARY KEY (tauxTVA)
);

CREATE TABLE Fournisseur (
    idFournisseur INT,
    nomFournisseur VARCHAR(50),
    telephoneFournisseur VARCHAR(20),
    CONSTRAINT pk_fournisseur_idFournisseur PRIMARY KEY (idFournisseur),
    CONSTRAINT ck_fournisseur_nomFournisseur CHECK (nomFournisseur is NOT NULL)
);

CREATE TABLE Client (
    idClient INT,
    nomClient VARCHAR(50),
    prenomClient VARCHAR(50),
    telephone VARCHAR(50),
    CONSTRAINT pk_client_idClient PRIMARY KEY (idClient),
    CONSTRAINT ck_client_nomClient CHECK (nomClient is NOT NULL),
    CONSTRAINT ck_client_prenomclient CHECK (prenomClient is NOT NULL)
);

CREATE TABLE TypeAdresse (
    typeAdresse VARCHAR(50),
    CONSTRAINT pk_typeAdresse_typeAdresse PRIMARY KEY (typeAdresse)
);


CREATE TABLE Ville (
    idVille INT,
    codePostal INT,
    nomCommune VARCHAR(75),
    CONSTRAINT pk_ville_idVille PRIMARY KEY (idVille),
    CONSTRAINT ck_ville_codePostal CHECK (codePostal is NOT NULL),
    CONSTRAINT ck_ville_nomCommune CHECK (nomCommune is NOT NULL)
);

CREATE TABLE ImagesProduits (
    idImage INT,
    urlImageProduit VARCHAR(255),
    CONSTRAINT pk_imagesProduit_idImage PRIMARY KEY (idImage),
    CONSTRAINT ck_imagesProduits_urlImage CHECK (urlImageProduit is NOT NULL)
);

CREATE TABLE Produit (
    idProduit INT,
    referenceProduit VARCHAR(50),
    prixHT DECIMAL(5,2),
    libelleProduit VARCHAR(255),
    idCategorieProduits INT,
    tauxTVA DECIMAL(4,2),
    idMarque INT,
    CONSTRAINT pk_produit_idProduit PRIMARY KEY (idProduit),
    CONSTRAINT fk_produit_idCategorieProduits FOREIGN KEY (idCategorieProduits) REFERENCES CategorieProduit(idCategorieProduits),
    CONSTRAINT fk_produit_tauxTVA FOREIGN KEY (tauxTVA) REFERENCES TypeTVA(tauxTVA),
    CONSTRAINT fk_produit_idMarque FOREIGN KEY (idMarque) REFERENCES Marque(idMarque),
    CONSTRAINT ck_produit_referenceProduit CHECK(referenceProduit is NOT NULL),
    CONSTRAINT ck_produit_prixHT CHECK(prixHT is NOT NULL),
    CONSTRAINT ck_produit_libelleProduit CHECK(libelleProduit is NOT NULL)
);

CREATE TABLE Adresse (
    idAdresse INT,
    numero INT,
    voie VARCHAR(255),
    idVille INT,
    typeAdresse VARCHAR(50),
    idClient INT,
    CONSTRAINT pk_adresse_idAdresse PRIMARY KEY (idAdresse),
    CONSTRAINT fk_adresse_idVille FOREIGN KEY (idVille) REFERENCES Ville(idVille),
    CONSTRAINT fk_adresse_typeAdresse FOREIGN KEY (typeAdresse) REFERENCES TypeAdresse(typeAdresse),
    Constraint fk_adresse_idClient FOREIGN KEY (idClient) REFERENCES Client(idClient),
    CONSTRAINT ck_adresse_numero CHECK (numero is NOT NULL),
    CONSTRAINT ck_adresse_voie CHECK (voie is NOT NULL)
);

CREATE TABLE Illustrer (
    positionImage INT, 
    idProduit INT,
    idImage INT,
    CONSTRAINT ck_illustrer_positionImage CHECK (positionImage is NOT NULL),
    CONSTRAINT fk_illustrer_idProduit FOREIGN KEY (idProduit) REFERENCES Produit(idProduit),
    CONSTRAINT fk_illustrer_idImage FOREIGN KEY (idImage) REFERENCES ImagesProduits(idImage)
);

CREATE TABLE Commande (
    idCommande INT,
    idClient INT,
    idAdresse INT,
    uneDate DATE,
    idProduit INT,
    CONSTRAINT pk_commande_idCommande PRIMARY KEY (idCommande),
    CONSTRAINT fk_commande_idClient FOREIGN KEY (idClient) REFERENCES Client(idClient),
    CONSTRAINT fk_commande_idAdress FOREIGN KEY (idAdresse) REFERENCES Adresse(idAdresse),
    CONSTRAINT fk_commande_uneDate FOREIGN KEY (uneDate) REFERENCES Calendriier(uneDate),
    CONSTRAINT fk_commande_idProduit FOREIGN KEY (idProduit) REFERENCES Produit(idProduit)
);

CREATE TABLE Vendre (
    prixHT DECIMAL(5,2),
    idFournisseur INT,
    uneDate DATE,
    idProduit INT,
    CONSTRAINT ck_vendre_prixHT CHECK (prixHT is NOT NULL),
    CONSTRAINT fk_vendre_idFournisseur FOREIGN KEY (idFournisseur) REFERENCES Fournisseur(idFournisseur),
    CONSTRAINT fk_vendre_uneDate FOREIGN KEY (uneDate) REFERENCES Calendriier(uneDate),
    CONSTRAINT fk_vendre_idProduit FOREIGN KEY (idProduit) REFERENCES Produit(idProduit),
    CONSTRAINT pk_vendre_idF_uneDate_idP PRIMARY KEY (idFournisseur,uneDate,idProduit)
);

CREATE TABLE Referencer (
    reference VARCHAR(60),
    idFournisseur INT,
    idProduit INT,
    CONSTRAINT ck_referencer_reference CHECK (reference is NOT NULL),
    CONSTRAINT fk_referencer_idFournisseur FOREIGN KEY (idFournisseur) REFERENCES Fournisseur(idFournisseur),
    CONSTRAINT fk_referencer_idProduit FOREIGN KEY (idProduit) REFERENCES Produit(idProduit),
    CONSTRAINT pk_referencer_idV_idP PRIMARY KEY (idFournisseur,idProduit) 
);

CREATE TABLE Contenir (
    quantite SMALLINT,
    idProduit INT,
    idCommande INT,
    CONSTRAINT ck_contenir_quantite CHECK (quantite is NOT NULL),
    CONSTRAINT fk_rcontenir_idProduit FOREIGN KEY (idProduit) REFERENCES Produit(idProduit),
    CONSTRAINT fk_rcontenir_idCommande FOREIGN KEY (idCommande) REFERENCES Commande(idCommande)
);

INSERT INTO Calendriier (uneDate) VALUES (TO_DATE('06/01/2025', 'DD/MM/YYYY'));
INSERT INTO Calendriier (uneDate) VALUES (TO_DATE('23/12/2024', 'DD/MM/YYYY'));
INSERT INTO Calendriier (uneDate) VALUES (TO_DATE('16/12/2024', 'DD/MM/YYYY'));
INSERT INTO Calendriier (uneDate) VALUES (TO_DATE('25/12/2024', 'DD/MM/YYYY'));
INSERT INTO Calendriier (uneDate) VALUES (TO_DATE('08/01/2025', 'DD/MM/YYYY'));
INSERT INTO Calendriier (uneDate) VALUES (TO_DATE('14/12/2024', 'DD/MM/YYYY'));
INSERT INTO Calendriier (uneDate) VALUES (TO_DATE('05/01/2025', 'DD/MM/YYYY'));



INSERT INTO CategorieProduit VALUES ('1','PC',NULL);
INSERT INTO CategorieProduit VALUES ('2','Composants','1');
INSERT INTO CategorieProduit VALUES ('3','processeurs','2');
INSERT INTO CategorieProduit VALUES ('4','Alimentations','2');
INSERT INTO CategorieProduit VALUES ('5','RAM','2');

INSERT INTO Marque VALUES ('1','AMD');
INSERT INTO Marque VALUES ('2','FORGEON');

INSERT INTO TypeTVA VALUES ('0.2');
INSERT INTO TypeTVA VALUES ('0.055');

INSERT INTO Fournisseur VALUES ('1','PcComponentes','01010101');
INSERT INTO FOURNISSEUR VALUES ('2','Amazon','03020101');
INSERT INTO FOURNISSEUR VALUES ('3','1fodiscount','01010305');

INSERT INTO Client VALUES ('2458','Hassein','Marc','01040565');

INSERT INTO TypeAdresse VALUES('Livraison');
INSERT INTO TypeAdresse VALUES('Facturation');

INSERT INTO Ville VALUES ('1','81100','Castres');
INSERT INTO Ville VALUES ('2','81100','Burlats');

INSERT INTO IMAGESPRODUITS VALUES ('1','https://thumb.pccomponentes.com/w-530-530/articles/1086/10860456/1996-amd-ryzen-7-9800x3d-47-52ghz.jpg');
INSERT INTO IMAGESPRODUITS VALUES ('2','https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcT3sPk7atStQAQbBDjNNvfZmbosCazXjxSWpYzPVmGv5HXdJ8S6J-je0qP-grSIWSNw-Qy9QVfXzliG2LP1V-y5u0njq7C5rAuklXDSwffvsnGryu34thtCiA');
INSERT INTO IMAGESPRODUITS VALUES ('3','https://thumb.pccomponentes.com/w-530-530/articles/1073/10731650/170-forgeon-bolt-psu-850w-gold-full-modular-blanca.jpg');
INSERT INTO IMAGESPRODUITS VALUES ('4','https://img.pccomponentes.com/articles/1073/10731650/2531-forgeon-bolt-psu-850w-gold-full-modular-blanca-comprar.jpg');
INSERT INTO IMAGESPRODUITS VALUES ('5','https://img.pccomponentes.com/articles/1073/10731650/3565-forgeon-bolt-psu-850w-gold-full-modular-blanca-mejor-precio.jpg');
INSERT INTO IMAGESPRODUITS VALUES ('6','https://i.ytimg.com/vi/qhTaLfUmvME/maxresdefault.jpg');

INSERT INTO Produit VALUES ('1','248','700','AMD Ryzen 7 9800X3D 4,7/5,2 GHz','3','0.2','1');
INSERT INTO Produit VALUES ('2','268','720','AMD Ryzen 9 9950X 4.3/5.7GHz','3','0.2','1');
INSERT INTO Produit VALUES ('3','148','165','Bolt PSU 850W Gold','4','0.055','2');
INSERT INTO Produit VALUES ('4','587','35','Forgeon Cyclone PLUS DDR4 3200 MHz 16 Go 2x8 Go CL16','5','0.055','2');

INSERT INTO Adresse VALUES ('1','13','Chemin du pinson','1','Livraison','2458');
INSERT INTO Adresse VALUES ('2','25','Route de Castres','1','Livraison','2458');
INSERT INTO Adresse VALUES ('3','184','Route de Toulouse','2','Livraison','2458');
INSERT INTO Adresse VALUES ('4','13','Chemin du pinson','1','Facturation','2458');

INSERT INTO ILLUSTRER VALUES ('1','1','1');
INSERT INTO ILLUSTRER VALUES ('2','1','2');
INSERT INTO ILLUSTRER VALUES ('1','3','3');
INSERT INTO ILLUSTRER VALUES ('2','3','4');
INSERT INTO ILLUSTRER VALUES ('3','3','5');
INSERT INTO ILLUSTRER VALUES ('1','4','6');

INSERT INTO Vendre VALUES ('694.20','1','06/01/2025','1');
INSERT INTO Vendre VALUES ('700','1','23/12/2024','1');
INSERT INTO Vendre VALUES ('698.85','1','16/12/2024','1');
INSERT INTO Vendre VALUES ('735.24','2','25/12/2024','1');
INSERT INTO Vendre VALUES ('785.54','3','06/01/2025','1');
INSERT INTO Vendre VALUES ('713.25','1','08/01/2025','2');
INSERT INTO Vendre VALUES ('713','2','23/12/2024','2');
INSERT INTO Vendre VALUES ('700','2','14/12/2024','2');
INSERT INTO Vendre VALUES ('159','3','06/01/2025','3');
INSERT INTO Vendre VALUES ('29.75','2','05/01/2025','4');
INSERT INTO Vendre VALUES ('30.72','3','05/01/2025','4');

INSERT INTO REFERENCER VALUES ('9800xRD','1','1');
INSERT INTO REFERENCER VALUES ('17814025','2','1');
INSERT INTO REFERENCER VALUES ('378946','3','1');
INSERT INTO REFERENCER VALUES ('9950x','1','2');
INSERT INTO REFERENCER VALUES ('17814046','2','2');
INSERT INTO REFERENCER VALUES ('354983','3','3');
INSERT INTO REFERENCER VALUES ('17465281','2','4');
INSERT INTO REFERENCER VALUES ('375698','3','4');

COMMIT;