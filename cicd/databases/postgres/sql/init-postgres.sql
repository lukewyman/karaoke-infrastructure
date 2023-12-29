DROP DATABASE IF EXISTS singers;

CREATE DATABASE singers;

CREATE TABLE singers (
  id UUID PRIMARY KEY,
  email varchar(100),
  first_name varchar(100),
  last_name varchar(100),
  stage_name varchar(100)
);