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
DROP PROCEDURE IF EXISTS sp_DeleteAdoptions;

DELIMITER //
CREATE PROCEDURE sp_DeleteAdoption(IN adoption_adoption_id INT)
BEGIN
    DELETE FROM Adoptions
    WHERE adoption_id = adoption_adoption_id;
END //
DELIMITER ;
