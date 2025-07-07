--liquibase formatted sql

--changeset amy.smith:table_missing_index labels:v0.1.0
create table table_missing_index (
  id int, 
  name varchar(30),
  description varchar(30) 
);
--rollback DROP TABLE table_missing_index;