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