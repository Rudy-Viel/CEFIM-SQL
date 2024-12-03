DROP DATABASE IF EXISTS location_ski;
CREATE DATABASE location_ski;

USE location_ski;

CREATE TABLE clients (
    noCli INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50),
    adresse VARCHAR(255),
    cpo VARCHAR(5) NOT NULL,
    ville VARCHAR(50) NOT NULL
);

CREATE TABLE gammes (
    codeGam VARCHAR(5) PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL
);

CREATE TABLE categories (
    codeCate VARCHAR(5) PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL
);

CREATE TABLE tarifs (
    codeTarif VARCHAR(5) PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL,
    prixJour DECIMAL(10, 2) NOT NULL
);

CREATE TABLE fiches (
    noFic INT PRIMARY KEY AUTO_INCREMENT,
    noCli INT NOT NULL,
    dateCrea DATE NOT NULL,
    datePaiement DATE,
    etat VARCHAR(20) NOT NULL,
    CONSTRAINT fk_fiches_clients FOREIGN KEY (noCli) REFERENCES clients(noCli)
);

CREATE TABLE articles (
    refArt VARCHAR(8) PRIMARY KEY,
    designation VARCHAR(100) NOT NULL,
    codeGam VARCHAR(5),
    codeCate VARCHAR(5),
    CONSTRAINT fk_articles_gammes FOREIGN KEY (codeGam) REFERENCES gammes(codeGam),
    CONSTRAINT fk_articles_categories FOREIGN KEY (codeCate) REFERENCES categories(codeCate)
);

CREATE TABLE grilleTarifs (
    codeGam VARCHAR(5) NOT NULL,
    codeCate VARCHAR(5) NOT NULL,
    codeTarif VARCHAR(5),
    PRIMARY KEY (codeGam, codeCate),
    CONSTRAINT fk_grilleTarifs_gammes FOREIGN KEY (codeGam) REFERENCES gammes(codeGam),
    CONSTRAINT fk_grilleTarifs_categories FOREIGN KEY (codeCate) REFERENCES categories(codeCate),
    CONSTRAINT fk_grilleTarifs_tarifs FOREIGN KEY (codeTarif) REFERENCES tarifs(codeTarif)
);

CREATE TABLE lignesFic (
    noLig INT NOT NULL AUTO_INCREMENT,  
    noFic INT NOT NULL,  
    refArt VARCHAR(8) NOT NULL,  
    depart DATE NOT NULL,  
    retour DATE,  
    PRIMARY KEY (noLig), 
    CONSTRAINT fk_lignesFic_fiches FOREIGN KEY (noFic) REFERENCES fiches(noFic),  
    CONSTRAINT fk_lignesFic_articles FOREIGN KEY (refArt) REFERENCES articles(refArt) 
);

INSERT INTO clients (noCli, nom, prenom, adresse, cpo, ville) VALUES 
    (1, 'Albert', 'Anatole', 'Rue des accacias', '61000', 'Amiens'),
    (2, 'Bernard', 'Barnabé', 'Rue du bar', '1000', 'Bourg en Bresse'),
    (3, 'Dupond', 'Camille', 'Rue Crébillon', '44000', 'Nantes'),
    (4, 'Desmoulin', 'Daniel', 'Rue descendante', '21000', 'Dijon'),
    (5, 'Ferdinand', 'François', 'Rue de la convention', '44100', 'Nantes'),
    (6, 'Albert', 'Anatole', 'Rue des accacias', '61000', 'Amiens'),
    (9, 'Dupond', 'Jean', 'Rue des mimosas', '75018', 'Paris'),
    (14, 'Boutaud', 'Sabine', 'Rue des platanes', '75002', 'Paris');


INSERT INTO fiches (noFic, noCli, dateCrea, datePaiement, etat) VALUES 
    (1001, 14,  DATE_SUB(NOW(),INTERVAL  15 DAY), DATE_SUB(NOW(),INTERVAL  13 DAY),'SO' ),
    (1002, 4,  DATE_SUB(NOW(),INTERVAL  13 DAY), NULL, 'EC'),
    (1003, 1,  DATE_SUB(NOW(),INTERVAL  12 DAY), DATE_SUB(NOW(),INTERVAL  10 DAY),'SO'),
    (1004, 6,  DATE_SUB(NOW(),INTERVAL  11 DAY), NULL, 'EC'),
    (1005, 3,  DATE_SUB(NOW(),INTERVAL  10 DAY), NULL, 'EC'),
    (1006, 9,  DATE_SUB(NOW(),INTERVAL  10 DAY),NULL ,'RE'),
    (1007, 1,  DATE_SUB(NOW(),INTERVAL  3 DAY), NULL, 'EC'),
    (1008, 2,  DATE_SUB(NOW(),INTERVAL  0 DAY), NULL, 'EC');

INSERT INTO tarifs (codeTarif, libelle, prixJour) VALUES
    ('T1', 'Base', 10),
    ('T2', 'Chocolat', 15),
    ('T3', 'Bronze', 20),
    ('T4', 'Argent', 30),
    ('T5', 'Or', 50),
    ('T6', 'Platine', 90);

INSERT INTO gammes (codeGam, libelle) VALUES
    ('PR', 'Matériel Professionnel'),
    ('HG', 'Haut de gamme'),
    ('MG', 'Moyenne gamme'),
    ('EG', 'Entrée de gamme');

INSERT INTO categories (codeCate, libelle) VALUES
    ('MONO', 'Monoski'),
    ('SURF', 'Surf'),
    ('PA', 'Patinette'),
    ('FOA', 'Ski de fond alternatif'),
    ('FOP', 'Ski de fond patineur'),
    ('SA', 'Ski alpin');


INSERT INTO grilleTarifs (codeGam, codeCate, codeTarif) VALUES
    ('EG', 'MONO', 'T1'),
    ('MG', 'MONO', 'T2'),
    ('EG', 'SURF', 'T1'),
    ('MG', 'SURF', 'T2'),
    ('HG', 'SURF', 'T3'),
    ('PR', 'SURF', 'T5'),
    ('EG', 'PA', 'T1'),
    ('MG', 'PA', 'T2'),
    ('EG', 'FOA', 'T1'),
    ('MG', 'FOA', 'T2'),
    ('HG', 'FOA', 'T4'),
    ('PR', 'FOA', 'T6'),
    ('EG', 'FOP', 'T2'),
    ('MG', 'FOP', 'T3'),
    ('HG', 'FOP', 'T4'),
    ('PR', 'FOP', 'T6'),
    ('EG', 'SA', 'T1'),
    ('MG', 'SA', 'T2'),
    ('HG', 'SA', 'T4'),
    ('PR', 'SA', 'T6');

INSERT INTO articles (refArt, designation, codeGam, codeCate) VALUES 
    ('F01', 'Fischer Cruiser', 'EG', 'FOA'),
    ('F02', 'Fischer Cruiser', 'EG', 'FOA'),
    ('F03', 'Fischer Cruiser', 'EG', 'FOA'),
    ('F04', 'Fischer Cruiser', 'EG', 'FOA'),
    ('F05', 'Fischer Cruiser', 'EG', 'FOA'),
    ('F10', 'Fischer Sporty Crown', 'MG', 'FOA'),
    ('F20', 'Fischer RCS Classic GOLD', 'PR', 'FOA'),
    ('F21', 'Fischer RCS Classic GOLD', 'PR', 'FOA'),
    ('F22', 'Fischer RCS Classic GOLD', 'PR', 'FOA'),
    ('F23', 'Fischer RCS Classic GOLD', 'PR', 'FOA'),
    ('F50', 'Fischer SOSSkating VASA', 'HG', 'FOP'),
    ('F60', 'Fischer RCS CARBOLITE Skating', 'PR', 'FOP'),
    ('F61', 'Fischer RCS CARBOLITE Skating', 'PR', 'FOP'),
    ('F62', 'Fischer RCS CARBOLITE Skating', 'PR', 'FOP'),
    ('F63', 'Fischer RCS CARBOLITE Skating', 'PR', 'FOP'),
    ('F64', 'Fischer RCS CARBOLITE Skating', 'PR', 'FOP'),
    ('P01', 'Décathlon Allegre junior 150', 'EG', 'PA'),
    ('P10', 'Fischer mini ski patinette', 'MG', 'PA'),
    ('P11', 'Fischer mini ski patinette', 'MG', 'PA'),
    ('S01', 'Décathlon Apparition', 'EG', 'SURF'),
    ('S02', 'Décathlon Apparition', 'EG', 'SURF'),
    ('S03', 'Décathlon Apparition', 'EG', 'SURF'),
    ('A01', 'Salomon 24X+Z12', 'EG', 'SA'),
    ('A02', 'Salomon 24X+Z12', 'EG', 'SA'),
    ('A03', 'Salomon 24X+Z12', 'EG', 'SA'),
    ('A04', 'Salomon 24X+Z12', 'EG', 'SA'),
    ('A05', 'Salomon 24X+Z12', 'EG', 'SA'),
    ('A10', 'Salomon Pro Link Equipe 4S', 'PR', 'SA'),
    ('A11', 'Salomon Pro Link Equipe 4S', 'PR', 'SA'),
    ('A21', 'Salomon 3V RACE JR+L10', 'PR', 'SA');

INSERT INTO lignesFic (noFic, refArt, depart, retour) VALUES 
    (1001, 'F05', DATE_SUB(NOW(),INTERVAL  15 DAY), DATE_SUB(NOW(),INTERVAL  13 DAY)),
    (1001, 'F50', DATE_SUB(NOW(),INTERVAL  15 DAY), DATE_SUB(NOW(),INTERVAL  14 DAY)),
    (1001, 'F60', DATE_SUB(NOW(),INTERVAL  13 DAY), DATE_SUB(NOW(),INTERVAL  13 DAY)),
    (1002, 'A03', DATE_SUB(NOW(),INTERVAL  13 DAY), DATE_SUB(NOW(),INTERVAL  9 DAY)),
    (1002, 'A04', DATE_SUB(NOW(),INTERVAL  12 DAY), DATE_SUB(NOW(),INTERVAL  7 DAY)),
    (1002, 'S03', DATE_SUB(NOW(),INTERVAL  8 DAY), NULL),
    (1003, 'F50', DATE_SUB(NOW(),INTERVAL  12 DAY), DATE_SUB(NOW(),INTERVAL  10 DAY)),
    (1003, 'F05', DATE_SUB(NOW(),INTERVAL  12 DAY), DATE_SUB(NOW(),INTERVAL  10 DAY)),
    (1004, 'P01', DATE_SUB(NOW(),INTERVAL  6 DAY), NULL),
    (1005, 'F05', DATE_SUB(NOW(),INTERVAL  9 DAY), DATE_SUB(NOW(),INTERVAL  5 DAY)),
    (1005, 'F10', DATE_SUB(NOW(),INTERVAL  4 DAY), NULL),
    (1006, 'S01', DATE_SUB(NOW(),INTERVAL  10 DAY), DATE_SUB(NOW(),INTERVAL  9 DAY)),
    (1006, 'S02', DATE_SUB(NOW(),INTERVAL  10 DAY), DATE_SUB(NOW(),INTERVAL  9 DAY)),
    (1006, 'S03', DATE_SUB(NOW(),INTERVAL  10 DAY), DATE_SUB(NOW(),INTERVAL  9 DAY)),
    (1007, 'F50', DATE_SUB(NOW(),INTERVAL  3 DAY), DATE_SUB(NOW(),INTERVAL  2 DAY)),
    (1007, 'F60', DATE_SUB(NOW(),INTERVAL  1 DAY), NULL),
    (1007, 'F05', DATE_SUB(NOW(),INTERVAL  3 DAY), NULL),
    (1007, 'S02', DATE_SUB(NOW(),INTERVAL  0 DAY), NULL),
    (1008, 'S01', DATE_SUB(NOW(),INTERVAL  0 DAY), NULL);

SELECT * FROM clients WHERE nom LIKE 'D%';

SELECT prenom, nom FROM clients;

SELECT f.noFic, f.etat, c.nom, c.prenom FROM fiches f JOIN clients c ON f.noCli = c.noCli WHERE c.cpo LIKE '44%';

SELECT f.noFic, c.nom, c.prenom, l.refArt, a.designation, l.depart, l.retour, t.prixJour, 
       DATEDIFF(IFNULL(l.retour, NOW()), l.depart) * t.prixJour AS montant
FROM lignesFic l
JOIN fiches f ON l.noFic = f.noFic
JOIN clients c ON f.noCli = c.noCli
JOIN articles a ON l.refArt = a.refArt
JOIN grilleTarifs gt ON a.codeGam = gt.codeGam AND a.codeCate = gt.codeCate
JOIN tarifs t ON gt.codeTarif = t.codeTarif
WHERE f.noFic = 1002;

SELECT g.libelle AS Gamme, AVG(t.prixJour) AS 'tarif journalier moyen'
FROM grilleTarifs gt
JOIN tarifs t ON gt.codeTarif = t.codeTarif
JOIN gammes g ON gt.codeGam = g.codeGam
GROUP BY g.libelle;


SELECT f.noFic, c.nom, c.prenom, l.refArt, a.designation, l.depart, l.retour, t.prixJour,
       DATEDIFF(IFNULL(l.retour, NOW()), l.depart) * t.prixJour AS Montant,
       DATEDIFF(IFNULL(l.retour, NOW()), l.depart) * t.prixJour * COUNT(*) AS Total
FROM lignesFic l
JOIN fiches f ON l.noFic = f.noFic
JOIN clients c ON f.noCli = c.noCli
JOIN articles a ON l.refArt = a.refArt
JOIN grilleTarifs gt ON a.codeGam = gt.codeGam AND a.codeCate = gt.codeCate
JOIN tarifs t ON gt.codeTarif = t.codeTarif
WHERE f.noFic = 1002
GROUP BY f.noFic, c.nom, c.prenom, l.refArt, a.designation, l.depart, l.retour, t.prixJour
LIMIT 0, 25; --

SELECT c.libelle AS libelle, gt.codeCate, t.libelle AS 'libelle tarif', t.prixJour
FROM grilleTarifs gt
JOIN tarifs t ON gt.codeTarif = t.codeTarif
JOIN categories c ON gt.codeCate = c.codeCate; --

SELECT a.refArt, a.designation, COUNT(l.refArt) AS nbLocation
FROM lignesFic l
JOIN articles a ON l.refArt = a.refArt
JOIN categories c ON a.codeCate = c.codeCate
WHERE c.libelle = 'Surf'
GROUP BY a.refArt; --

SELECT c.libelle AS catégorie, COUNT(DISTINCT f.noFic) AS nombre_de_location
FROM fiches f
JOIN lignesFic l ON f.noFic = l.noFic
JOIN articles a ON l.refArt = a.refArt
JOIN categories c ON a.codeCate = c.codeCate
WHERE c.libelle IN ('Ski alpin', 'Surf', 'Patinette')
GROUP BY c.libelle; --

SELECT AVG(montant_fiche) AS montant_moyen_fiche
FROM (
    SELECT f.noFic, SUM(DATEDIFF(IFNULL(l.retour, NOW()), l.depart) * t.prixJour) AS montant_fiche
    FROM lignesFic l
    JOIN fiches f ON l.noFic = f.noFic
    JOIN articles a ON l.refArt = a.refArt
    JOIN grilleTarifs gt ON a.codeGam = gt.codeGam AND a.codeCate = gt.codeCate
    JOIN tarifs t ON gt.codeTarif = t.codeTarif
    GROUP BY f.noFic
) AS subquery; --


