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
    
