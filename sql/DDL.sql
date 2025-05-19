-- Group 100: Cassandra Fleming and Paul Meleason
-- Note: Used forward engineering as starting point and modified as needed.
-- No AI was used.

DROP PROCEDURE IF EXISTS sp_ResetDatabase;

DELIMITER //
CREATE PROCEDURE sp_ResetDatabase()
BEGIN

    -- Included these lines suggested on Canvas:
    SET FOREIGN_KEY_CHECKS=0;
    SET AUTOCOMMIT = 0;

    -- Clear out tables.
    DROP TABLE IF EXISTS `Customers`;
    DROP TABLE IF EXISTS `Species`;
    DROP TABLE IF EXISTS `Locations`;
    DROP TABLE IF EXISTS `Pets`;
    DROP TABLE IF EXISTS `Adoptions`;
    DROP TABLE IF EXISTS `Vaccines`;
    DROP TABLE IF EXISTS `Vaccinations`;

    -- -----------------------------------------------------
    -- Table `Customers`
    -- -----------------------------------------------------
    CREATE TABLE IF NOT EXISTS `Customers` (
                                               `customer_id` INT NOT NULL AUTO_INCREMENT,
                                               `name` VARCHAR(255) NOT NULL,
                                               `address` VARCHAR(255) NOT NULL,
                                               `city` VARCHAR(255) NOT NULL,
                                               `state` VARCHAR(255) NOT NULL,
                                               `zip` VARCHAR(5) NOT NULL,
                                               `phone` VARCHAR(20) NOT NULL,
                                               `email` VARCHAR(255) NOT NULL,
                                               PRIMARY KEY (`customer_id`));

    -- -----------------------------------------------------
    -- Table `Species`
    -- -----------------------------------------------------
    CREATE TABLE IF NOT EXISTS `Species` (
                                             `species_id` INT NOT NULL AUTO_INCREMENT,
                                             `name` VARCHAR(255) NOT NULL UNIQUE,
                                             PRIMARY KEY (`species_id`));

    -- -----------------------------------------------------
    -- Table `Locations`
    -- -----------------------------------------------------
    CREATE TABLE IF NOT EXISTS `Locations` (
                                               `location_id` INT NOT NULL AUTO_INCREMENT,
                                               `name` VARCHAR(255) NOT NULL,
                                               `address` VARCHAR(255) NOT NULL,
                                               `city` VARCHAR(255) NOT NULL,
                                               `state` VARCHAR(255) NOT NULL,
                                               `zip` VARCHAR(5) NOT NULL,
                                               PRIMARY KEY (`location_id`));

    -- -----------------------------------------------------
    -- Table `Pets`
    -- -----------------------------------------------------
    CREATE TABLE IF NOT EXISTS `Pets` (
                                          `pet_id` INT NOT NULL AUTO_INCREMENT,
                                          `species_id` INT NOT NULL,
                                          `location_id` INT NOT NULL,
                                          `name` VARCHAR(255) NOT NULL,
                                          `birthday` DATE NULL,
                                          `date_arrived` DATE NOT NULL,
                                          `adoption_cost` DECIMAL(6,2) NOT NULL,
                                          `gender` VARCHAR(1) NOT NULL,
                                          PRIMARY KEY (`pet_id`),
                                          CONSTRAINT `fk_Pets_Species`
                                              FOREIGN KEY (`species_id`)
                                                  REFERENCES `Species` (`species_id`)
                                                  ON DELETE CASCADE,
                                          CONSTRAINT `fk_Pets_Locations`
                                              FOREIGN KEY (`location_id`)
                                                  REFERENCES `Locations` (`location_id`)
                                                  ON DELETE CASCADE);

    -- -----------------------------------------------------
    -- Table `Adoptions`
    -- -----------------------------------------------------
    CREATE TABLE IF NOT EXISTS `Adoptions` (
                                               `adoption_id` INT NOT NULL AUTO_INCREMENT,
                                               `customer_id` INT NOT NULL,
                                               `pet_id` INT NOT NULL,
                                               `adoption_date` DATE NOT NULL,
                                               PRIMARY KEY (`adoption_id`),
                                               CONSTRAINT `fk_Adoptions_Customers`
                                                   FOREIGN KEY (`customer_id`)
                                                       REFERENCES `Customers` (`customer_id`)
                                                       ON DELETE CASCADE,
                                               CONSTRAINT `fk_Adoptions_Pets`
                                                   FOREIGN KEY (`pet_id`)
                                                       REFERENCES `Pets` (`pet_id`)
                                                       ON DELETE CASCADE);

    -- -----------------------------------------------------
    -- Table `Vaccines`
    -- -----------------------------------------------------
    CREATE TABLE IF NOT EXISTS `Vaccines` (
                                              `vaccine_id` INT NOT NULL AUTO_INCREMENT,
                                              `name` VARCHAR(255) NOT NULL,
                                              PRIMARY KEY (`vaccine_id`));

    -- -----------------------------------------------------
    -- Table `Vaccinations`
    -- -----------------------------------------------------
    CREATE TABLE IF NOT EXISTS `Vaccinations` (
                                                  `vaccination_id` INT NOT NULL AUTO_INCREMENT,
                                                  `pet_id` INT NOT NULL,
                                                  `vaccine_id` INT NOT NULL,
                                                  `vaccination_date` DATE NOT NULL,
                                                  PRIMARY KEY (`vaccination_id`),
                                                  CONSTRAINT `fk_Vaccinations_Pets`
                                                      FOREIGN KEY (`pet_id`)
                                                          REFERENCES `Pets` (`pet_id`)
                                                          ON DELETE CASCADE,
                                                  CONSTRAINT `fk_Vaccinations_Vaccines`
                                                      FOREIGN KEY (`vaccine_id`)
                                                          REFERENCES `Vaccines` (`vaccine_id`)
                                                          ON DELETE CASCADE);

    -- -----------------------------------------------------
    -- Sample Customers
    -- -----------------------------------------------------
    INSERT INTO `Customers` (name, address, city, state, zip, phone, email)
    VALUES
        ("Andrew Smith", "905 Fake Street", "Fake Town", "TX", "55555", "123-456-7890", "asmith@example.com"),
        ("Becky Bunker", "123 Any Street", "Anyville", "MD", "12345", "555-292-5551", "bbunker@example.com"),
        ("Carole Day", "1234 Oak Avenue", "Oak City", "OK", "99999", "555-444-3333", "cday@example.com"),
        ("Doug Adams", "987 Terrace Lane", "Grand View", "MI", "54321", "123-555-7890", "dadams@example.com"),
        ("Earl Cooke", "906 Fake Street", "Fake Town", "TX", "55555", "123-456-7891", "ecooke@example.com");

    -- -----------------------------------------------------
    -- Sample Species
    -- -----------------------------------------------------
    INSERT INTO `Species` (name)
    VALUES
        ("Dog"),
        ("Cat"),
        ("Rabbit"),
        ("Turtle"),
        ("Hamster");

    -- -----------------------------------------------------
    -- Sample Locations
    -- -----------------------------------------------------
    INSERT INTO `Locations` (name, address, city, state, zip)
    VALUES
        ("Hope Street Shelter", "555 Hope Street", "Fake Town", "TX", "55555"),
        ("Cherry Street Shelter", "123 Cherry Street", "Cherrytown", "FL", "54321"),
        ("Main Street Shelter", "100 Main Street", "Anyville", "MD", "12345");

    -- -----------------------------------------------------
    -- Sample Pets
    -- -----------------------------------------------------
    INSERT INTO `Pets` (
        name,
        species_id,
        birthday,
        date_arrived,
        location_id,
        adoption_cost,
        gender
    )
    VALUES
        (
            "Fluffy",
            (SELECT species_id FROM Species WHERE name = "Cat"),
            "2024-02-01",
            "2025-01-01",
            1,
            100.00,
            "F"
        ),
        (
            "Scruffy",
            (SELECT species_id FROM Species WHERE name = "Dog"),
            "2024-06-07",
            "2025-04-27",
            2,
            250.00,
            "M"
        ),
        (
            "Franklin",
            (SELECT species_id FROM Species WHERE name = "Turtle"),
            "2023-07-04",
            "2025-03-01",
            1,
            150.00,
            "M"
        ),
        (
            "Mildred",
            (SELECT species_id FROM Species WHERE name = "Dog"),
            "2024-05-15",
            "2024-10-31",
            3,
            125.00,
            "F"
        ),
        (
            "Doug",
            (SELECT species_id FROM Species WHERE name = "Dog"),
            "2024-01-01",
            "2025-01-01",
            3,
            200.00,
            "M"
        );

    -- -----------------------------------------------------
    -- Sample Adoptions
    -- -----------------------------------------------------
    INSERT INTO Adoptions (
        customer_id,
        pet_id,
        adoption_date
    )
    VALUES
        (
            1,
            1,
            "2025-02-17"
        ),
        (
            1,
            3,
            "2025-04-27"
        ),
        (
            2,
            5,
            "2025-02-24"
        );

    -- -----------------------------------------------------
    -- Sample Vaccines
    -- -----------------------------------------------------
    -- NOTE: Fake, generic vaccine names used.
    INSERT INTO Vaccines (name)
    VALUES
        ("Vaccine A"),
        ("Vaccine B"),
        ("Vaccine C");

    -- -----------------------------------------------------
    -- Sample Vaccinations
    -- -----------------------------------------------------
    INSERT INTO Vaccinations (
        pet_id,
        vaccine_id,
        vaccination_date)
    VALUES
        (
            1,
            1,
            "2025-02-08"
        ),
        (
            1,
            2,
            "2025-02-08"
        ),
        (
            3,
            1,
            "2024-08-01"
        );

    -- Included these lines suggested on Canvas:
    SET FOREIGN_KEY_CHECKS=1;
    COMMIT;

end //

DELIMITER  ;