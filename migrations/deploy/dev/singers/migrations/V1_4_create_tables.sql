\c singers singers_app;

CREATE TABLE singers (
  id UUID NOT NULL, 
  email VARCHAR, 
  first_name VARCHAR, 
  last_name VARCHAR, 
  stage_name VARCHAR, 
  PRIMARY KEY (id)
);