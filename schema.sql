/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    name varchar(100)
    
CREATE TABLE animals( 
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(50),
	date_of_birth DATE,
	escape_attempts INT,
	neutered BOOLEAN,
	weight_kg DECIMAL
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(50);

-- THIRD MILESTONE

CREATE TABLE owners( 
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	full_name VARCHAR(50),
	age INT
);

CREATE TABLE species( 
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(50)
);

ALTER TABLE animals
ADD PRIMARY KEY (id);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD species_id INT, 
ADD owner_id INT; 

ALTER TABLE animals
ADD FOREIGN KEY (species_id) REFERENCES species (id)
ON DELETE CASCADE;

ALTER TABLE animals
ADD FOREIGN KEY (owner_id) REFERENCES owners (id)
ON DELETE CASCADE;

-- FOUR MILESTONE


CREATE TABLE vets (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(50),
	age INT,
	date_of_graduation DATE
);

CREATE TABLE specializations (
	vets_id INT,
	species_id INT,
	FOREIGN KEY (vets_id) REFERENCES vets (id) ON DELETE CASCADE,
	FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE CASCADE
);

CREATE TABLE visits (
	vets_id INT,
	animals_id INT,
	date_of_visit DATE,
	FOREIGN KEY (vets_id) REFERENCES vets (id) ON DELETE CASCADE,
	FOREIGN KEY (animals_id) REFERENCES animals (id) ON DELETE CASCADE
);