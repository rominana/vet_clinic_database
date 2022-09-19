/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, true, 11);

-- second milestone 

INSERT INTO
    animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    ('Charmander', '2020-02-08', 0, false, -11),
    ('Plantmon', '2021-11-15', 2, true, -5.7),
    ('Squirtle', '1993-04-02', 3, false, -12.13),
    ('Angemon', '2005-06-12', 1, true, -45),
    ('Boarmon', '2005-06-07', 7, true, 20.4),
    ('Blossom', '1998-10-13', 3, true, 17),
    ('Ditto', '2022-05-14', 4, true, 22);


    -- THIRD MILESTONE

INSERT INTO
    owners (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

INSERT INTO
    species (name)
VALUES
    ('Pokemon'),
    ('Digimon');

UPDATE animals
SET species_id = (SELECT id from species WHERE name = 'Digimon')
WHERE name LIKE '%mon'
RETURNING *;

UPDATE animals
SET species_id = (SELECT id from species WHERE name = 'Pokemon')
WHERE name NOT LIKE '%mon'
RETURNING *;

UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon'
RETURNING *;

UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Jennifer Orwell')
WHERE name = 'Gabumon' OR name = 'Pikachu'
RETURNING *;

UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Bob')
WHERE name = 'Devimon' OR name = 'Plantmon'
RETURNING *;

UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Melody Pond')
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom'
RETURNING *;

UPDATE animals
SET owner_id = (SELECT id from owners WHERE full_name = 'Dean Winchester')
WHERE name = 'Angemon' OR name = 'Boarmon'
RETURNING *;

-- FOUR MILESTONE

INSERT INTO
    vets (name, age, date_of_graduation)
VALUES
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-04-04'),
    ('Jack Harkness', 38, '2008-06-08');

INSERT INTO
    specializations (vets_id, species_id)
VALUES
    ((SELECT id from vets WHERE name = 'William Tatcher'), (SELECT id from species WHERE name = 'Pokemon')),
    ((SELECT id from vets WHERE name = 'Stephanie Mendez'), (SELECT id from species WHERE name = 'Digimon')),
    ((SELECT id from vets WHERE name = 'Stephanie Mendez'), (SELECT id from species WHERE name = 'Pokemon')),
    ((SELECT id from vets WHERE name = 'Jack Harkness'), (SELECT id from species WHERE name = 'Digimon'));

INSERT INTO
    visits (vets_id, animals_id, date_of_visit)
VALUES
    ((SELECT id from vets WHERE name = 'William Tatcher'), (SELECT id from animals WHERE name = 'Agumon'), '2020-04-24'),
    ((SELECT id from vets WHERE name = 'Stephanie Mendez'), (SELECT id from animals WHERE name = 'Agumon'), '2020-07-22'),
    ((SELECT id from vets WHERE name = 'Jack Harkness'), (SELECT id from animals WHERE name = 'Gabumon'), '2021-02-02'),
    ((SELECT id from vets WHERE name = 'Maisy Smith'), (SELECT id from animals WHERE name = 'Pikachu'), '2020-01-05'),
    ((SELECT id from vets WHERE name = 'Maisy Smith'), (SELECT id from animals WHERE name = 'Pikachu'), '2020-03-08'),
    ((SELECT id from vets WHERE name = 'Maisy Smith'), (SELECT id from animals WHERE name = 'Pikachu'), '2020-05-14'),
    ((SELECT id from vets WHERE name = 'Stephanie Mendez'), (SELECT id from animals WHERE name = 'Devimon'), '2021-05-04'),
    ((SELECT id from vets WHERE name = 'Jack Harkness'), (SELECT id from animals WHERE name = 'Charmander'), '2021-02-24'),
    ((SELECT id from vets WHERE name = 'Maisy Smith'), (SELECT id from animals WHERE name = 'Plantmon'), '2019-12-21'),
    ((SELECT id from vets WHERE name = 'William Tatcher'), (SELECT id from animals WHERE name = 'Plantmon'), '2020-08-10'),
    ((SELECT id from vets WHERE name = 'Maisy Smith'), (SELECT id from animals WHERE name = 'Plantmon'), '2021-04-07'),
    ((SELECT id from vets WHERE name = 'Stephanie Mendez'), (SELECT id from animals WHERE name = 'Squirtle'), '2019-09-29'),
    ((SELECT id from vets WHERE name = 'Jack Harkness'), (SELECT id from animals WHERE name = 'Angemon'), '2020-10-03'),
    ((SELECT id from vets WHERE name = 'Jack Harkness'), (SELECT id from animals WHERE name = 'Angemon'), '2020-11-04'),
    ((SELECT id from vets WHERE name = 'Maisy Smith'), (SELECT id from animals WHERE name = 'Boarmon'), '2019-01-24'),
    ((SELECT id from vets WHERE name = 'Maisy Smith'), (SELECT id from animals WHERE name = 'Boarmon'), '2019-05-15'),
    ((SELECT id from vets WHERE name = 'Maisy Smith'), (SELECT id from animals WHERE name = 'Boarmon'), '2020-02-27'),
    ((SELECT id from vets WHERE name = 'Maisy Smith'), (SELECT id from animals WHERE name = 'Boarmon'), '2020-08-03'),
    ((SELECT id from vets WHERE name = 'Stephanie Mendez'), (SELECT id from animals WHERE name = 'Blossom'), '2020-05-24'),
    ((SELECT id from vets WHERE name = 'William Tatcher'), (SELECT id from animals WHERE name = 'Blossom'), '2021-01-11');


    -- FIFTH MILESTONE 

    -- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animals_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
INSERT INTO owners (full_name, email) SELECT 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animals_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits V where V.vets_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';