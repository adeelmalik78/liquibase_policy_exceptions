--liquibase formatted sql

--changeset amy.smith:insert_films_01 labels:v0.1.0
INSERT INTO films (id, name, genre) VALUES(1, 'Scary Movie', 'horror');
INSERT INTO films (id, name, genre) VALUES(2, 'Funny Movie', 'comedy');
--rollback delete from films_01 where id in (1,2) ;