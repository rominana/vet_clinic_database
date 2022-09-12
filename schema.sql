/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    name varchar(100)
CREATE TABLE animals( 
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(50),
	date_of_birth DATETIME,
	escape_attempts INT,
	neutered BOOLEAN,
	weight_kg DECIMAL
);