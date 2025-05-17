-- Citation: CREATE code is adapted from Canvas, CS 340 Module 8
-- Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

-- -----------------------------------------------------
-- CREATE Customers
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS sp_CreateCustomer;

DELIMITER //
CREATE PROCEDURE sp_CreateCustomer(
    IN customer_customer_id INT,
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
        customer_id,
        name,
        address,
        city,
        state,
        zip,
        phone,
        email)
    VALUES (
               customer_customer_id,
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
        customer_customer_id = customer_customer_id,
        customer_name = customer_name,
        customer_address = customer_address,
        customer_city = customer_city,
        customer_state = customer_state,
        customer_zip = customer_zip,
        customer_phone = customer_phone,
        customer_email = customer_email
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
CREATE PROCEDURE sp_DeleteAdoption(IN customer_customer_id INT)
BEGIN
    DELETE FROM Customers
    WHERE customer_id = customer_customer_id;
END //
DELIMITER ;
