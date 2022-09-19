/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';
-- Find all animals whose name ends in "mon".
SELECT * from animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name from animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * from animals WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT * from animals WHERE name NOT LIKE 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- second milestone
-- ADD TRANSACTIONS QUERIES
BEGIN; -- start transaction

UPDATE animals
SET species = 'unspecified'; -- make change

SELECT species from animals; -- verify that change was made
ROLLBACK;

SELECT species from animals;


-- How many animals are there?
SELECT COUNT(*) from animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) from animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) from animals;

-- Who escapes the most, neutered or not neutered animals?
--modified by suggestion 
SELECT neutered, AVG(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT MIN(weight_kg), MAX(weight_kg), species from animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT AVG(escape_attempts), species from animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;



-- THIRD MILESTONE


-- What animals belong to Melody Pond?
SELECT A.name AS animal_name, O.full_name AS owner_name
FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT A.name AS animal_name, S.name AS type
FROM animals A
JOIN species S ON A.species_id = S.id
WHERE S.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT O.full_name AS owner_name, A.name AS animal_name
FROM owners O
LEFT JOIN animals A ON A.owner_id = O.id
WHERE A.name IS NULL OR A.name IS NOT NULL;

-- How many animals are there per species?
SELECT COUNT(S.name) AS total_animals, S.name AS specie_name
FROM animals A
JOIN species S ON A.species_id = S.id
GROUP BY S.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT A.name AS animal_name, O.full_name AS owner_name
FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE A.species_id = 2 AND O.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT A.name AS animal_name, O.full_name AS owner_name
FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE A.escape_attempts = 0 AND O.full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT COUNT(A.name) AS total_animals, O.full_name AS owner_name
FROM animals A
RIGHT JOIN owners O ON A.owner_id = O.id
GROUP BY O.full_name
HAVING COUNT(A.name) IS NULL OR COUNT(A.name) IS NOT NULL
ORDER BY COUNT(O.full_name) DESC;



-- FOUR MILESTONE


-- Who was the last animal seen by William Tatcher?
SELECT A.id, A.name AS animal_name, V.id, V.name AS vet_name, D.date_of_visit
FROM animals A
JOIN visits D ON A.id = D.animals_id
JOIN vets V ON V.id = D.vets_id
WHERE V.name = 'William Tatcher'
ORDER BY D.date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT V.name AS vets_name, COUNT(DISTINCT A.name) AS total_animals
FROM animals A
JOIN visits D ON A.id = D.animals_id
JOIN vets V ON V.id = D.vets_id
WHERE V.name = 'Stephanie Mendez'
GROUP BY V.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT V.name AS vet_name, S.name AS specialties
FROM vets V
FULL JOIN specializations Z ON V.id = Z.vets_id
FULL JOIN species S ON S.id = Z.species_id
ORDER BY V.name;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT A.name AS animals, V.name AS vet_name, D.date_of_visit
FROM visits D
JOIN vets V ON V.id = D.vets_id
JOIN animals A ON A.id = D.animals_id
WHERE V.name = 'Stephanie Mendez' AND D.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30'
ORDER BY D.date_of_visit;

-- What animal has the most visits to vets?
SELECT A.name AS animal_name, COUNT(D.vets_id) AS total_visits
FROM visits D
JOIN animals A ON A.id = D.animals_id
GROUP BY A.name
ORDER BY COUNT(D.vets_id) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT A.name AS animal_name, V.name AS vet_name, D.date_of_visit
FROM visits D
JOIN animals A ON A.id = D.animals_id
JOIN vets V ON V.id = D.vets_id
WHERE V.name = 'Maisy Smith'
ORDER BY D.date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT D.date_of_visit AS most_recent_visit, A.name AS animal_name, A.date_of_birth, A.escape_attempts, A.neutered, A.weight_kg, V.name AS vet_name, V.age AS vet_age, V.date_of_graduation
FROM visits D
JOIN animals A ON A.id = D.animals_id
JOIN vets V ON V.id = D.vets_id
ORDER BY D.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT V.name AS vet_name, S.species_id AS vet_species_id, A.name AS animal_name, A.species_id AS animal_species_id
FROM visits D
FULL JOIN animals A ON A.id = D.animals_id
FULL JOIN vets V ON V.id = D.vets_id
FULL JOIN specializations S ON S.vets_id = V.id
WHERE V.name != 'Stephanie Mendez' AND (S.species_id IS NULL OR S.species_id != A.species_id);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT S.name, COUNT(S.name) AS total_visits
FROM visits D
JOIN vets V ON V.id = D.vets_id
JOIN animals A ON A.id = D.animals_id
JOIN species S ON S.id = A.species_id
WHERE V.name = 'Maisy Smith'
GROUP BY S.name;

-- FIFTH MILESTONE

SELECT COUNT(*) FROM visits where animals_id = 4;
SELECT * FROM visits where vets_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';