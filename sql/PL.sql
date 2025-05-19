-- Group 100: Cassandra Fleming and Paul Meleason
-- No AI was used.

-- -----------------------------------------------------
-- CUD for Pets
-- -----------------------------------------------------

-- Citation: CREATE code is adapted from Canvas, CS 340 Module 8
-- Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

-- -----------------------------------------------------
-- CREATE Pets
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS sp_CreatePet;

DELIMITER //
CREATE PROCEDURE sp_CreatePet(
    IN pet_species_id INT,
    IN pet_location_id INT,
    IN pet_name VARCHAR(255),
    IN pet_birthday DATE,
    IN pet_date_arrived DATE,
    IN pet_adoption_cost DECIMAL(6, 2),
    IN pet_gender VARCHAR(1),
    OUT pet_id INT)
BEGIN
    INSERT INTO Pets (
        species_id,
        location_id,
        name,
        birthday,
        date_arrived,
        adoption_cost,
        gender)
    VALUES (
        pet_species_id,
        pet_location_id,
        pet_name,
        pet_birthday,
        pet_date_arrived,
        pet_adoption_cost,
        pet_gender);

    SELECT LAST_INSERT_ID() INTO pet_id;
    SELECT LAST_INSERT_ID() AS "new_id";
END //
DELIMITER ;

-- Citation: UPDATE code is adapted from Canvas, CS 340 Module 8
-- Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

-- -----------------------------------------------------
-- UPDATE Pets
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS sp_UpdatePet;

DELIMITER //
CREATE PROCEDURE sp_UpdatePet(
    IN pet_pet_id INT,
    IN pet_species_id INT,
    IN pet_location_id INT,
    IN pet_name VARCHAR(255),
    IN pet_birthday DATE,
    IN pet_date_arrived DATE,
    IN pet_adoption_cost DECIMAL(6, 2),
    IN pet_gender VARCHAR(1))
BEGIN
    UPDATE Pets
    SET
        species_id = pet_species_id,
        location_id = pet_location_id,
        name = pet_name,
        birthday = pet_birthday,
        date_arrived = pet_date_arrived,
        adoption_cost = pet_adoption_cost,
        gender = pet_gender
    WHERE pet_id = pet_pet_id;
END //
DELIMITER ;

-- Citation: DELETE code is adapted from Canvas, CS 340 Module 8
-- Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

-- -----------------------------------------------------
-- DELETE Pets
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS sp_DeletePet;

DELIMITER //
CREATE PROCEDURE sp_DeletePet(IN pet_pet_id INT)
BEGIN
    DELETE FROM Pets WHERE pet_id = pet_pet_id;
END //
DELIMITER ;

-- -----------------------------------------------------
-- CUD for Customers
-- -----------------------------------------------------

-- Citation: CREATE code is adapted from Canvas, CS 340 Module 8
-- Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

-- -----------------------------------------------------
-- CREATE Customers
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS sp_CreateCustomer;

DELIMITER //
CREATE PROCEDURE sp_CreateCustomer(
    IN customer_name VARCHAR(255),
    IN customer_address VARCHAR(255),
    IN customer_city VARCHAR(255),
    IN customer_state VARCHAR(255),
    IN customer_zip VARCHAR(5),
    IN customer_phone VARCHAR(20),
    IN customer_email VARCHAR(255),
    OUT customer_id INT)
BEGIN
    INSERT INTO Customers (
        name,
        address,
        city,
        state,
        zip,
        phone,
        email)
    VALUES (
               customer_name,
               customer_address,
               customer_city,
               customer_state,
               customer_zip,
               customer_phone,
               customer_email
           );
    SELECT LAST_INSERT_ID() INTO customer_id;
    SELECT LAST_INSERT_ID() AS "new_id";
END //
DELIMITER ;

-- Citation: UPDATE code is adapted from Canvas, CS 340 Module 8
-- Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

-- -----------------------------------------------------
-- UPDATE Customers
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS sp_UpdateCustomer;

DELIMITER //
CREATE PROCEDURE sp_UpdateCustomer(
    IN customer_customer_id INT,
    IN customer_name VARCHAR(255),
    IN customer_address VARCHAR(255),
    IN customer_city VARCHAR(255),
    IN customer_state VARCHAR(255),
    IN customer_zip VARCHAR(5),
    IN customer_phone VARCHAR(20),
    IN customer_email VARCHAR(255))
BEGIN
    UPDATE Customers
    SET
        customer_id = customer_customer_id,
        name = customer_name,
        address = customer_address,
        city = customer_city,
        state = customer_state,
        zip = customer_zip,
        phone = customer_phone,
        email = customer_email
    WHERE customer_id = customer_customer_id;
END //
DELIMITER ;

-- Citation: DELETE code is adapted from Canvas, CS 340 Module 8
-- Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

-- -----------------------------------------------------
-- DELETE Customers
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS sp_DeleteCustomer;

DELIMITER //
CREATE PROCEDURE sp_DeleteCustomer(IN customer_customer_id INT)
BEGIN
    DELETE FROM Customers
    WHERE customer_id = customer_customer_id;
END //
DELIMITER ;

-- -----------------------------------------------------
-- CUD for Adoptions
-- -----------------------------------------------------

-- Citation: CREATE code is adapted from Canvas, CS 340 Module 8
-- Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

-- -----------------------------------------------------
-- CREATE Adoptions
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS sp_CreateAdoption;

DELIMITER //
CREATE PROCEDURE sp_CreateAdoption(
    IN adoption_customer_id INT,
    IN adoption_pet_id INT,
    IN adoption_adoption_date DATE,
    OUT adoption_id INT)
BEGIN
    INSERT INTO Adoptions (
        customer_id,
        pet_id,
        adoption_date)
    VALUES (
        adoption_customer_id,
        adoption_pet_id,
        adoption_adoption_date);
    SELECT LAST_INSERT_ID() INTO adoption_id;
    SELECT LAST_INSERT_ID() AS "new_id";
END //
DELIMITER ;

-- Citation: UPDATE code is adapted from Canvas, CS 340 Module 8
-- Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

-- -----------------------------------------------------
-- UPDATE Adoptions
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS sp_UpdateAdoption;

DELIMITER //
CREATE PROCEDURE sp_UpdateAdoption(
    IN adoption_adoption_id INT,
    IN adoption_customer_id INT,
    IN adoption_pet_id INT,
    IN adoption_adoption_date DATE)
BEGIN
    UPDATE Adoptions
    SET
        customer_id = adoption_customer_id,
        pet_id = adoption_pet_id,
        adoption_date = adoption_adoption_date
    WHERE adoption_id = adoption_adoption_id;
END //
DELIMITER ;

-- Citation: DELETE code is adapted from Canvas, CS 340 Module 8
-- Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

-- -----------------------------------------------------
-- DELETE Adoptions
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS sp_DeleteAdoption;

DELIMITER //
CREATE PROCEDURE sp_DeleteAdoption(IN adoption_adoption_id INT)
BEGIN
    DELETE FROM Adoptions
    WHERE adoption_id = adoption_adoption_id;
END //
DELIMITER ;

-- -----------------------------------------------------
-- CUD for Vaccinations
-- -----------------------------------------------------

-- Citation: CREATE code is adapted from Canvas, CS 340 Module 8
-- Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

-- -----------------------------------------------------
-- CREATE Vaccinations
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS sp_CreateVaccination;

DELIMITER //
CREATE PROCEDURE sp_CreateVaccination(
    IN vaccination_pet_id INT,
    IN vaccination_vaccine_id INT,
    IN vaccination_vaccination_date DATE,
    OUT vaccination_id INT)
BEGIN
    INSERT INTO Vaccinations (
        pet_id,
        vaccine_id,
        vaccination_date)
    VALUES (
        vaccination_pet_id,
        vaccination_vaccine_id,
        vaccination_vaccination_date);
    SELECT LAST_INSERT_ID() INTO vaccination_id;
    SELECT LAST_INSERT_ID() AS "new_id";
END //
DELIMITER ;
    
-- Citation: UPDATE code is adapted from Canvas, CS 340 Module 8
-- Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

-- -----------------------------------------------------
-- UPDATE Vaccinations
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS sp_UpdateVaccination;

DELIMITER //
CREATE PROCEDURE sp_UpdateVaccination(
    IN vaccination_vaccination_id INT,
    IN vaccination_pet_id INT,
    IN vaccination_vaccine_id INT,
    IN vaccination_vaccination_date DATE)
BEGIN
    UPDATE Vaccinations
    SET
        pet_id = vaccination_pet_id,
        vaccine_id = vaccination_vaccine_id,
        vaccination_date = vaccination_vaccination_date
    WHERE vaccination_id = vaccination_vaccination_id;
END //
DELIMITER ;

-- Citation: DELETE code is adapted from Canvas, CS 340 Module 8
-- Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

-- -----------------------------------------------------
-- DELETE Vaccinations
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS sp_DeleteVaccination;

DELIMITER //
CREATE PROCEDURE sp_DeleteVaccination(IN vaccination_vaccination_id INT)
BEGIN
    DELETE FROM Vaccinations
    WHERE vaccination_id = vaccination_vaccination_id;
END //
DELIMITER ;
