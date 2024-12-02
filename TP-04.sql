INSERT INTO inv_personne (id, prenom, nom, age, inscription, etat, statut, cv, salaire) VALUES
(1, 'Brad', 'PITT', 60, '1970-01-01', 1, 'non membre', 'lorem ipsum', 2000000.00),
(2, 'George', 'CLONEY', 62, '1999-01-01', 1, 'membre', 'juste beau', 4000000.00),
(3, 'Jean', 'DUJARDIN', 51, '1994-01-01', 0, 'membre', 'brice de nice', 1000000.00);

SELECT MAX(salaire) AS plus_gros_salaire FROM inv_personne;

SELECT MIN(salaire) AS plus_petit_salaire FROM inv_peronne;

SELECT nom, salaire FROM inv_peronne ORDER BY salaire ASC LIMIT 1;

SELECT nom, salaire FROM inv_peronne ORDER BY salaire DESC LIMIT 1;

SELECT AVG(salaire) AS salaire_moyen FROM inv_peronne;

SELECT COUNT(*) AS nombre_inv_peronnes FROM inv_peronne;

SELECT nom, salaire FROM personne WHERE salaire > 1000000 AND salaire < 4000000;

SELECT UPPER(prenom) AS prenom_majuscule, LOWER(nom) AS nom_minuscule FROM inv_peronne;

SELECT * FROM inv_peronne WHERE prenom LIKE '%bra%';

SELECT * FROM inv_peronne WHERE statut = 'membre' ORDER BY age ASC;

SELECT COUNT(*) AS nombre_membres FROM inv_peronne WHERE statut = 'membre';

SELECT statut, COUNT(*) AS nombre FROM inv_peronne GROUP BY statut;