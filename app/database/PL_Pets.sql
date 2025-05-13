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
DROP PROCEDURE IF EXISTS DeletePet;

DELIMITER //
CREATE PROCEDURE sp_DeletePet(IN pet_pet_id INT)
BEGIN
    DELETE FROM Pets WHERE pet_id = pet_pet_id;
END //
DELIMITER ;