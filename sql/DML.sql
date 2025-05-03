-- Group 100: Cassandra Fleming and Paul Meleason
-- Citations: Used the DML file provided on Canvas as reference.

-- -----------------------------------------------------
-- Queries for the List Customers Page
-- -----------------------------------------------------

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

-- -----------------------------------------------------
-- Queries for the List Pets Page
-- -----------------------------------------------------

-- Get all pets.
SELECT
    Pets.name,
    Pets.birthday,
    Pets.date_arrived,
    Pets.adoption_cost,
    Pets.gender,
    Species.name as species,
    Locations.name as shelter
FROM Pets
JOIN Locations
ON Pets.location_id = Locations.location_id
JOIN Species
ON Pets.species_id = Species.species_id;

-- -----------------------------------------------------
-- Queries for the List Shelter Locations Page
-- -----------------------------------------------------

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

-- Get all species.
SELECT
    species_id,
    name
FROM Species;

-- -----------------------------------------------------
-- Queries for the List Vaccines Page
-- -----------------------------------------------------

-- Get all vaccines.
SELECT
    vaccine_id,
    name
FROM Vaccines;

-- -----------------------------------------------------
-- Queries for the List Adoptions Page
-- -----------------------------------------------------

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

-- -----------------------------------------------------
-- Queries for the List Vaccinations Page
-- -----------------------------------------------------

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

-- -----------------------------------------------------
-- Beyond MVP
-- -----------------------------------------------------

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
WHERE Customers.customer_id = @id_of_customer;

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
WHERE Pets.pet_id = @id_of_pet;
