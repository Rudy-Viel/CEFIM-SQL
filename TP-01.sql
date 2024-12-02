DROP DATABASE IF EXISTS zoo;

CREATE DATABASE IF NOT EXISTS zoo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE zoo;

DROP TABLE IF EXISTS chat;

CREATE TABLE IF NOT EXISTS chat (
    id INT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    yeux VARCHAR(50) NOT NULL,
    age INT NOT NULL
);

INSERT INTO chat (id, nom, yeux, age) VALUES 
(1, 'Maine coon', 'marron', 20),
(2, 'Siamois', 'bleu', 15),
(3, 'Bengal', 'marron', 18),
(4, 'Scottish Fold', 'marron', 10);
