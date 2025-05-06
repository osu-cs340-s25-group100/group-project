-- Group 100: Cassandra Fleming and Paul Meleason
-- Citations: Used the DML file provided on Canvas as reference.
-- No AI was used.

-- -----------------------------------------------------
-- Queries for the List Customers Page
-- -----------------------------------------------------

-- READ
-- Get all customers.
SELECT
    customer_id,
    name,
    address,
    city,
    state,
    zip,
    phone,
    email
FROM Customers;

-- CREATE
-- Add a new customer.
-- NOTE: This is a parameterized query.
INSERT INTO Customers (
    name,
    address,
    city,
    state,
    zip,
    phone,
    email
)
VALUES ( 
    @name,
    @address,
    @city,
    @state,
    @zip,
    @phone,
    @email
);

-- UPDATE
-- Update a customer.
-- NOTE: This is a parameterized query.
UPDATE Customers
SET
    name = @name,
    address = @address,
    city = @city,
    state = @state,
    zip = @zip,
    phone = @phone,
    email = @email
WHERE customer_id = @customer_id;

-- DELETE
-- Delete a customer.
-- NOTE: This is a parameterized query.
DELETE FROM Customers
WHERE customer_id = @customer_id;

-- -----------------------------------------------------
-- Queries for the List Pets Page
-- -----------------------------------------------------

-- READ
-- Get all pets.
SELECT
    Pets.pet_id,
    Pets.name,
    Pets.birthday,
    Pets.date_arrived,
    Pets.adoption_cost,
    Pets.gender,
    Species.name AS species,
    Locations.name AS shelter,
    Pet_Adoptions.adopted
FROM Pets
JOIN Locations
ON Pets.location_id = Locations.location_id
JOIN Species
ON Pets.species_id = Species.species_id
JOIN
-- Subquery for adoption status for each pet.
(
    SELECT
        Pets.pet_id,
        -- learned from https://stackoverflow.com/questions/3215454/mysql-ifnull-else/23395407#23395407
        IF(
            Adoptions.adoption_id IS NOT NULL,
            "Y",
            "N"
        ) AS adopted
    FROM Pets
    LEFT JOIN Adoptions
    ON Pets.pet_id = Adoptions.pet_id
) AS Pet_Adoptions
ON Pets.pet_id = Pet_Adoptions.pet_id;

-- CREATE
-- Add a new pet.
-- NOTE: This is a parameterized query.
INSERT INTO Pets (
    species_id,
    location_id,
    name,
    birthday,
    date_arrived,
    adoption_cost,
    gender
)
VALUES ( 
    @species_id,
    @location_id,
    @name,
    @birthday,
    @date_arrived,
    @adoption_cost,
    @gender
);

-- UPDATE
-- Get a single pet for update form.
-- NOTE: This is a parameterized query.
SELECT
    Pets.name,
    Pets.birthday,
    Pets.date_arrived,
    Pets.adoption_cost,
    Pets.gender,
    Pets.species_id,
    Species.name AS species,
    Pets.location_id,
    locations.name AS shelter
FROM Pets
JOIN Locations
ON Pets.location_id = Locations.location_id
JOIN Species
ON Pets.species_id = Species.species_id
WHERE Pets.pet_id = @pet_id;

-- Update a pet.
-- NOTE: This is a parameterized query.
UPDATE Pets
SET
    species_id = @species_id,
    location_id = @location_id,
    name = @name,
    birthday = @birthday,
    date_arrived = @date_arrived,
    adoption_cost = @adoption_cost,
    gender = @gender
WHERE pet_id = @pet_id;

-- DELETE
-- Delete a pet.
-- NOTE: This is a parameterized query.
DELETE FROM Pets
WHERE pet_id = @pet_id;

-- -----------------------------------------------------
-- Queries for the List Shelter Locations Page
-- -----------------------------------------------------

-- READ
-- Get all shelter locations.
SELECT
    location_id,
    name,
    address,
    city,
    state,
    zip
FROM Locations;

-- -----------------------------------------------------
-- Queries for the List Species Page
-- -----------------------------------------------------

-- READ
-- Get all species.
SELECT
    species_id,
    name
FROM Species;

-- -----------------------------------------------------
-- Queries for the List Vaccines Page
-- -----------------------------------------------------

-- READ
-- Get all vaccines.
SELECT
    vaccine_id,
    name
FROM Vaccines;

-- -----------------------------------------------------
-- Queries for the List Adoptions Page
-- -----------------------------------------------------

-- READ
-- Get all adoptions.
SELECT
    Adoptions.adoption_id,
    Adoptions.customer_id,
    Customers.name AS customer_name,
    Adoptions.pet_id,
    Pets.name AS pet_name,
    Adoptions.adoption_date
FROM Adoptions
JOIN Customers
ON Adoptions.customer_id = Customers.customer_id
JOIN
Pets
ON Adoptions.pet_id = Pets.pet_id;

-- CREATE / UPDATE
-- Queries for dropdown selectors:
-- Get all customers for dropdown selector.
SELECT
    customer_id,
    name
FROM Customers;

-- Get all UNADOPTED pets for dropdown selector.
SELECT
    pet_id,
    name
FROM Pets
WHERE pet_id NOT IN
-- Subquery for ids of already adopted pets
(
    SELECT pet_id
    FROM Adoptions
);

-- CREATE
-- Add a new adoption.
-- NOTE: This is a parameterized query.
INSERT INTO Adoptions (
    customer_id,
    pet_id,
    adoption_date
)
VALUES (
    @customer_id,
    @pet_id,
    @adoption_date
);

-- UPDATE
-- Get a single adoption for update form.
-- NOTE: This is a parameterized query.
SELECT
    adoption_id,
    customer_id,
    pet_id,
    adoption_date
FROM Adoptions
WHERE adoption_id = @adoption_id;

-- Update an adoption.
-- NOTE: This is a parameterized query.
UPDATE Adoptions
SET
    customer_id = @customer_id,
    pet_id = @pet_id,
    adoption_date = @adoption_date
WHERE adoption_id = @adoption_id;

-- DELETE
-- Delete an adoption.
-- NOTE: This is a parameterized query.
DELETE FROM Adoptions
WHERE adoption_id = @adoption_id;

-- -----------------------------------------------------
-- Queries for the List Vaccinations Page
-- -----------------------------------------------------

-- READ
-- Get all vaccinations.
SELECT
    Vaccinations.vaccination_id,
    Vaccinations.pet_id,
    Pets.name AS pet_name,
    Vaccinations.vaccine_id,
    Vaccines.name AS vaccine_name,
    Vaccinations.vaccination_date
FROM Vaccinations
JOIN Pets
ON Vaccinations.pet_id = Pets.pet_id
JOIN Vaccines
ON Vaccinations.vaccine_id = Vaccines.vaccine_id;

-- CREATE / UPDATE
-- Queries for dropdown selectors:
-- Get all pets for dropdown selector.
SELECT
    pet_id,
    name
FROM Pets;

-- Get all vaccines for dropdown selector.
SELECT
    vaccine_id,
    name
FROM Vaccines;

-- CREATE
-- Add a new vaccination.
-- NOTE: This is a parameterized query.
INSERT INTO Vaccinations (
    pet_id,
    vaccine_id,
    vaccination_date
)
VALUES (
    @pet_id,
    @vaccine_id,
    @vaccination_date
);

-- UPDATE
-- Get a single vaccination for update form.
-- NOTE: This is a parameterized query.
SELECT
    vaccination_id,
    pet_id,
    vaccine_id,
    vaccination_date
FROM Vaccinations
WHERE vaccination_id = @vaccination_id;

-- Update a vaccination.
-- NOTE: This is a parameterized query.
UPDATE Vaccinations
SET
    pet_id = @pet_id,
    vaccine_id = @vaccine_id,
    vaccination_date = @vaccination_date
WHERE vaccination_id = @vaccination_id;

-- DELETE
-- Delete a vaccination.
-- NOTE: This is a parameterized query.
DELETE FROM Vaccinations
WHERE vaccination_id = @vaccination_id;

-- -----------------------------------------------------
-- Beyond MVP
-- -----------------------------------------------------

-- READ
-- Get all adopted pets for a given customer.
-- NOTE: This is a parameterized query.
SELECT
    Pets.pet_id,
    Pets.name AS pet_name
FROM Customers
JOIN Adoptions
ON Customers.customer_id = Adoptions.customer_id
JOIN Pets
ON Adoptions.pet_id = Pets.pet_id
WHERE Customers.customer_id = @customer_id;

-- Get all vaccines for a given pet.
-- NOTE: This is a parameterized query.
SELECT
    Vaccines.vaccine_id,
    Vaccines.name AS vaccine_name
FROM Pets
JOIN Vaccinations
ON Pets.pet_id = Vaccinations.pet_id
JOIN Vaccines
ON Vaccinations.vaccine_id = Vaccines.vaccine_id
WHERE Pets.pet_id = @pet_id;
