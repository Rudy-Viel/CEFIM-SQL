DROP DATABASE IF EXISTS location_ski;
CREATE DATABASE location_ski;

USE location_ski;

CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nom VARCHAR(255) NOT NULL
);

CREATE TABLE projets (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nom VARCHAR(255) NOT NULL,
    client_id INT NOT NULL,
    CONSTRAINT fk_projets_client FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE devis (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    version INT NOT NULL,
    reference VARCHAR(10) NOT NULL,
    prix FLOAT NOT NULL,
    projet_id INT NOT NULL,
    CONSTRAINT fk_devis_projet FOREIGN KEY (projet_id) REFERENCES projets(id)
);

CREATE TABLE factures (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    reference VARCHAR(10) NOT NULL,
    info VARCHAR(255) NOT NULL,
    total FLOAT NOT NULL,
    date_crea DATE NOT NULL,
    date_paiement DATE,
    devis_id INT NOT NULL,
    CONSTRAINT fk_factures_devis FOREIGN KEY (devis_id) REFERENCES devis(id)
);

INSERT INTO clients (nom) VALUES 
('Mairie de Rennes'),
('Neo Soft'),
('Sopra'),
('Accenture'),
('Amazon');

INSERT INTO projets (nom, client_id) VALUES 
('Creation de site internet', 1), 
('Logiciel CRM', 2),
('Logiciel de devis', 3),
('Site internet ecommerce', 4),
('logiciel ERP', 2),
('logiciel Gestion de Stock', 5);

INSERT INTO devis (version, reference, prix, projet_id) VALUES 
(1, 'DEV2100A', 3000, 1),
(2, 'DEV2100B', 5000, 1),
(1, 'DEV2100C', 5000, 2),
(1, 'DEV2100D', 3000, 3),
(1, 'DEV2100E', 5000, 4),
(1, 'DEV2100F', 2000, 5), 
(1, 'DEV2100G', 1000, 6);

INSERT INTO factures (reference, info, total, date_crea, date_paiement, devis_id) VALUES 
('FA001', 'Site internet partie 1', 1500, '2023-09-01', '2023-10-01', 1), 
('FA002', 'Site internet partie 2', 1500, '2023-09-20', NULL, 1),
('FA003', 'Logiciel CRM', 5000, '2024-02-01', NULL, 3),
('FA004', 'Logiciel devis', 3000, '2024-03-03', '2024-04-03', 4),
('FA005', 'Site internet ecommerce', 5000, '2023-03-01', NULL, 5),   
('FA006', 'logiciel ERP', 2000, '2023-03-01', NULL, 6);

SELECT 
    factures.id AS facture_id,
    factures.reference AS reference_facture,
    clients.nom AS nom_client,
    factures.total AS montant_facture,
    factures.date_crea AS date_creation,
    factures.date_paiement AS date_paiement
FROM 
    factures
JOIN 
    devis ON factures.devis_id = devis.id
JOIN 
    projets ON devis.projet_id = projets.id
JOIN 
    clients ON projets.client_id = clients.id;

SELECT 
    clients.nom AS nom_client,
    COUNT(factures.id) AS nombre_factures
FROM 
    factures
JOIN 
    devis ON factures.devis_id = devis.id
JOIN 
    projets ON devis.projet_id = projets.id
JOIN 
    clients ON projets.client_id = clients.id
GROUP BY 
    clients.nom;

SELECT 
    clients.nom AS nom_client,
    SUM(factures.total) AS chiffre_affaires
FROM 
    factures
JOIN 
    devis ON factures.devis_id = devis.id
JOIN 
    projets ON devis.projet_id = projets.id
JOIN 
    clients ON projets.client_id = clients.id
GROUP BY 
    clients.nom;

SELECT 
    SUM(factures.total) AS chiffre_affaires_total
FROM 
    factures;

SELECT 
    SUM(factures.total) AS total_en_attente
FROM 
    factures
WHERE 
    factures.date_paiement IS NULL;

SELECT 
    factures.reference AS reference_facture,
    clients.nom AS nom_client,
    factures.total AS montant_facture,
    factures.date_crea AS date_creation,
    DATE_ADD(factures.date_crea, INTERVAL 30 DAY) AS date_echeance,
    CURDATE() AS date_actuelle,
    DATEDIFF(CURDATE(), DATE_ADD(factures.date_crea, INTERVAL 30 DAY)) AS jours_de_retard
FROM 
    factures
JOIN 
    devis ON factures.devis_id = devis.id
JOIN 
    projets ON devis.projet_id = projets.id
JOIN 
    clients ON projets.client_id = clients.id
WHERE 
    factures.date_paiement IS NULL
    AND CURDATE() > DATE_ADD(factures.date_crea, INTERVAL 30 DAY);

SELECT 
    factures.reference AS reference_facture,
    clients.nom AS nom_client,
    factures.total AS montant_initial,
    DATEDIFF(CURDATE(), DATE_ADD(factures.date_crea, INTERVAL 30 DAY)) AS jours_de_retard,
    DATEDIFF(CURDATE(), DATE_ADD(factures.date_crea, INTERVAL 30 DAY)) * 2 AS penalite,
    factures.total + (DATEDIFF(CURDATE(), DATE_ADD(factures.date_crea, INTERVAL 30 DAY)) * 2) AS montant_avec_penalite
FROM 
    factures
JOIN 
    devis ON factures.devis_id = devis.id
JOIN 
    projets ON devis.projet_id = projets.id
JOIN 
    clients ON projets.client_id = clients.id
WHERE 
    factures.date_paiement IS NULL
    AND CURDATE() > DATE_ADD(factures.date_crea, INTERVAL 30 DAY);
