--liquibase formatted sql

--changeset amy.smith:films_01 labels:v0.1.0
create table films_01 (
  id int, 
  name varchar(30),
  genre varchar(30) 
);
--rollback DROP TABLE films_01;


--changeset amy.smith:films_01_idx labels:v0.1.0
CREATE UNIQUE INDEX films_01_name_idx ON films_01 (name);
--rollback drop index films_01_name_idx;

--changeset amalik:drop_films_01 labels:v0.1.0
drop table films_01;
--rollback DROP TABLE films_01;

--changeset amalik:films labels:v0.1.0
create table films (
  id int, 
  name varchar(30),
  genre varchar(30) 
);
--rollback DROP TABLE films;
