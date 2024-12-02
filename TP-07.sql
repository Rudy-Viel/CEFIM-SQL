CREATE DATABASE netflix;

USE netflix;

CREATE TABLE film (
    id INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

CREATE TABLE acteur (
    id INT PRIMARY KEY,
    prenom VARCHAR(100) NOT NULL,
    nom VARCHAR(100) NOT NULL
);

CREATE TABLE film_has_acteur (
    film_id INT,
    acteur_id INT,
    PRIMARY KEY (film_id, acteur_id),
    FOREIGN KEY (film_id) REFERENCES film(id),
    FOREIGN KEY (acteur_id) REFERENCES acteur(id)
);

INSERT INTO film (id, nom) VALUES (1, 'Inception');

INSERT INTO acteur (id, prenom, nom) VALUES (1, 'Leonardo', 'DiCaprio');

INSERT INTO film_has_acteur (film_id, acteur_id) VALUES (1, 1);

SELECT f.nom AS film, a.prenom AS acteur_prenom, a.nom AS acteur_nom
FROM film f
JOIN film_has_acteur fha ON f.id = fha.film_id
JOIN acteur a ON fha.acteur_id = a.id
WHERE a.prenom = 'Leonardo' AND a.nom = 'DiCaprio';

SELECT a.prenom AS acteur_prenom, a.nom AS acteur_nom, COUNT(fha.film_id) AS nb_films
FROM acteur a
LEFT JOIN film_has_acteur fha ON a.id = fha.acteur_id
GROUP BY a.id
ORDER BY nb_films DESC;

INSERT INTO film (id, nom) VALUES (2, 'Titanic');

SELECT f.nom AS film
FROM film f
LEFT JOIN film_has_acteur fha ON f.id = fha.film_id
WHERE fha.acteur_id IS NULL;
