USE lootzone_db;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE PROPOSTA_VENDITA;
TRUNCATE TABLE DETTAGLIO_ORDINE;
TRUNCATE TABLE ORDINE;
TRUNCATE TABLE COPIA_USATA;
TRUNCATE TABLE PRODOTTO;
TRUNCATE TABLE CLIENTE;
TRUNCATE TABLE AMMINISTRATORE;
TRUNCATE TABLE UTENTE;
SET FOREIGN_KEY_CHECKS = 1;
INSERT INTO UTENTE (ID_Utente, Email, Password) 
VALUES (1, 'admin@lootzone.it', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9');
INSERT INTO AMMINISTRATORE (ID_Utente, Codice_Admin, Ruolo_Gestione) 
VALUES (1, 'ADM-SUPREMO', 'admin_generale');
INSERT INTO UTENTE (ID_Utente, Email, Password) 
VALUES (2, 'assistenza@lootzone.it', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9');
INSERT INTO AMMINISTRATORE (ID_Utente, Codice_Admin, Ruolo_Gestione) 
VALUES (2, 'ADM-UTENTI', 'admin_utenti');
INSERT INTO UTENTE (ID_Utente, Email, Password) 
VALUES (3, 'magazzino@lootzone.it', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9');
INSERT INTO AMMINISTRATORE (ID_Utente, Codice_Admin, Ruolo_Gestione) 
VALUES (3, 'ADM-MAG', 'impiegato');
INSERT INTO UTENTE (ID_Utente, Email, Password) 
VALUES (4, 'gamer99@email.it', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9');
INSERT INTO CLIENTE (ID_Utente, Nickname, Preferenze_Genere, Indirizzo_Spedizione) 
VALUES (4, 'gamer_99', 'FPS, Action', 'Via Roma 10, Milano');
INSERT INTO UTENTE (ID_Utente, Email, Password) 
VALUES (5, 'zelda@email.it', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9');
INSERT INTO CLIENTE (ID_Utente, Nickname, Preferenze_Genere, Indirizzo_Spedizione) 
VALUES (5, 'zelda_fan', 'Adventure', 'Piazza Napoli 5, Napoli');
INSERT INTO UTENTE (ID_Utente, Email, Password) 
VALUES (6, 'sparta@email.it', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9');
INSERT INTO CLIENTE (ID_Utente, Nickname, Preferenze_Genere, Indirizzo_Spedizione) 
VALUES (6, 'kratos_boi', 'Action', 'Via Sparta 300, Roma');
INSERT INTO PRODOTTO (ID_Prodotto, Titolo, Piattaforma, Genere, Prezzo_Base, Tipo_Formato, Descrizione, Immagine)
VALUES 
(1, 'PlayStation 5 Slim', 'Hardware', 'Console', 499.99, 'Fisico', 'Console Sony di ultima generazione con lettore disco.', 'ps5_slim.jpg'),
(2, 'Xbox Series X', 'Hardware', 'Console', 499.99, 'Fisico', 'La console Microsoft più potente di sempre.', 'xbox_series_x.jpg'),
(3, 'Nintendo Switch OLED', 'Hardware', 'Console', 349.99, 'Fisico', 'Schermo OLED dai colori intensi per giocare ovunque.', 'switch_oled.jpg'),
(5, 'Spider-Man 2', 'PS5', 'Action-Adventure', 69.99, 'Fisico', 'Nuova avventura per Peter Parker e Miles Morales.', 'spiderman2.jpg'),
(6, 'Elden Ring', 'PS5', 'Souls-like', 59.99, 'Fisico', 'Vincitore del GOTY. Un capolavoro souls-like.', 'elden_ring.jpg'),
(7, 'The Legend of Zelda: Tears of the Kingdom', 'Nintendo Switch', 'Action-Adventure', 69.99, 'Fisico', 'Esplora i cieli e le terre di Hyrule.', 'zelda_totk.jpg'),
(8, 'Mario Kart 8 Deluxe', 'Nintendo Switch', 'Racing', 49.99, 'Fisico', 'Corse pazze con i personaggi Nintendo.', 'mk8d.jpg'),
(9, 'Halo Infinite', 'Xbox Series X', 'FPS', 39.99, 'Fisico', 'Il ritorno di Master Chief.', 'halo_infinite.jpg'),
(10, 'God of War Ragnarok', 'PS5', 'Action-Adventure', 69.99, 'Fisico', 'Affronta il fato di Kratos e Atreus.', 'gow_ragnarok.jpg'),
(11, 'Cyberpunk 2077', 'PS5', 'RPG', 29.99, 'Fisico', 'Night City ti aspetta. Edizione aggiornata.', 'cyberpunk.jpg'),
(17, 'Funko Pop! Master Chief', 'Gadget', 'Action Figure', 15.99, 'Fisico', 'Statuetta da collezione di Halo.', 'funko_chief.jpg'),
(18, 'Lampada LED Triforza', 'Gadget', 'Arredamento', 25.00, 'Fisico', 'Illumina la tua stanza con il potere della Triforza.', 'lampada_zelda.jpg'),
(32, 'Fortnite - Pacchetto Leggende', 'Multiplatform', 'Battle Royale', 19.99, 'Digitale', 'Bundle esclusivo con skin, V-Bucks e dorsi decorativi.', 'fortnite_legends.jpg'),
(36, 'EA Sports FC 26', 'Multiplatform', 'Sport', 69.99, 'Fisico', 'Il gioco di calcio definitivo. Scendi in campo!', 'FC26_prod.jpg');
INSERT INTO ORDINE (ID_Ordine, Data_Acquisto, Totale, Stato_Spedizione, ID_Cliente, ID_Amministratore)
VALUES
(1, '2025-01-10 14:30:00', 569.98, 'Consegnato', 4, 1),
(2, '2025-02-15 09:15:00', 444.98, 'Consegnato', 5, 2),
(3, '2025-03-20 18:45:00', 79.98, 'Consegnato', 6, 1);
INSERT INTO DETTAGLIO_ORDINE (ID_Ordine, ID_Prodotto, Quantita)
VALUES 
(1, 1, 1),
(1, 5, 1),
(2, 3, 1),
(2, 7, 1),
(2, 18, 1),
(3, 10, 1);