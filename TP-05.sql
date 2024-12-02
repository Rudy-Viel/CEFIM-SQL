CREATE DATABASE spa;

USE spa;

CREATE TABLE couleur (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(30) NOT NULL
);

CREATE TABLE chat (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(30) NOT NULL,
    age INT,
    couleur_id INT,
    FOREIGN KEY (couleur_id) REFERENCES couleur(id)
);

INSERT INTO couleur (id, nom) VALUES
(1, 'marron'),
(2, 'bleu'),
(3, 'vert');

INSERT INTO chat (id, nom, age, couleur_id) VALUES
(1, 'maine coon', 20, 1),
(2, 'siamois', 15, 2),
(3, 'bengal', 18, 1),
(4, 'scottish fold', 10, 1),
(5, 'domestique', 21, NULL);
