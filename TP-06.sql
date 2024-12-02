CREATE DATABASE netflix;

USE netflix;

CREATE TABLE film (
    id INT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    sortie DATE NOT NULL,
    categ_id INT
);

CREATE TABLE categ (
    id INT PRIMARY KEY,
    nom VARCHAR(30) NOT NULL
);

INSERT INTO categ (id, nom) VALUES
(1, 'Sciences Fiction'),
(2, 'Thriller');


INSERT INTO film (id, titre, sortie, categ_id) VALUES
(1, 'STAR WARS', '1977-05-25', 1),
(2, 'THE MATRIX', '1999-06-23', 1),
(3, 'PULP FICTION', '1994-10-26', 2);

