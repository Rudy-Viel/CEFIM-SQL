DROP DATABASE IF EXISTS e_commerce;
CREATE DATABASE e_commerce;

USE e_commerce;

CREATE TABLE client (
  id INT NOT NULL AUTO_INCREMENT,
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100),
  PRIMARY KEY (id)
);

CREATE TABLE commande (
  id INT NOT NULL AUTO_INCREMENT,
  date_achat DATETIME NOT NULL,
  client_id INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_client FOREIGN KEY (client_id) REFERENCES client(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE article (
  id INT NOT NULL AUTO_INCREMENT,
  nom VARCHAR(100) NOT NULL,
  prix DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE ligne (
  article_id INT NOT NULL,
  commande_id INT NOT NULL,
  nombre INT NOT NULL CHECK (nombre > 0),
  prix DECIMAL(10, 2) NOT NULL CHECK (prix >= 0),
  PRIMARY KEY (article_id, commande_id),
  CONSTRAINT fk_article FOREIGN KEY (article_id) REFERENCES article(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_commande FOREIGN KEY (commande_id) REFERENCES commande(id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO article (nom, prix) VALUES
('PlayStation 5', 400.00),
('X Box', 350.00),
('Machine à café', 400.00),
('PlayStation 3', 100.00);

INSERT INTO client (nom, prenom) VALUES
('Brad', 'Pitt'),
('George', 'Clooney'),
('Jean', 'Dujardin');

INSERT INTO commande (date_achat, client_id) VALUES
('2024-09-08 10:15:00', 1);

INSERT INTO ligne (article_id, commande_id, nombre, prix) VALUES
(4, 1, 2, 100.00),
(3, 1, 1, 400.00),
(2, 1, 1, 350.00);
