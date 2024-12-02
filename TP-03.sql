USE zoo;

INSERT INTO chat (id, nom, yeux, age) VALUES 
(1, 'Maine coon', 'marron', 20),
(2, 'Siamois', 'bleu', 15),
(3, 'Bengal', 'marron', 18),
(4, 'Scottish Fold', 'marron', 10);

SELECT * FROM table_chats WHERE id = 2;

SELECT * FROM table_chats ORDER BY nom ASC, age ASC;

SELECT * FROM table_chats WHERE age BETWEEN 11 AND 19;

SELECT * FROM table_chats WHERE nom LIKE '%sia%';

SELECT * FROM table_chats WHERE nom LIKE '%a%';

SELECT AVG(age) AS moyenne_age FROM table_chats;

SELECT COUNT(*) AS nombre_chats FROM table_chats;

SELECT COUNT(*) AS chats_marron FROM table_chats WHERE yeux = 'marron';

SELECT yeux, COUNT(*) AS nombre_par_couleur FROM table_chats GROUP BY yeux;
