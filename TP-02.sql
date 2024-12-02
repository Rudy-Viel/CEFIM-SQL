DROP DATABASE IF EXISTS invitation;

CREATE DATABASE IF NOT EXISTS invitation CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE invitation;

CREATE TABLE IF NOT EXISTS personne (
    id INT PRIMARY KEY,
    prenom VARCHAR(255) NOT NULL,
    nom VARCHAR(255) NOT NULL,
    age TINYINT NOT NULL,
    inscription DATE NOT NULL,
    etat BOOLEAN NOT NULL,
    statut ENUM('membre', 'non membre') NOT NULL,
    cv TEXT NOT NULL,
    salaire DECIMAL(10, 2) NOT NULL
);

ALTER TABLE personne 
RENAME TO inv_peronne;

DROP TABLE IF EXISTS personne

