--liquibase formatted sql

--changeset amy.smith:table_missing_rollback labels:v0.1.0
create table table_missing_rollback (
  id int, 
  name varchar(30),
  description varchar(30) 
);

CREATE UNIQUE INDEX table_missing_rollback_idx ON table_missing_rollback (name);