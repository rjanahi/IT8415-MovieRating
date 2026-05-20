-- Trigger SQL commands: 

-- Trigger to validate rating value before inserting a new rating
DELIMITER $$ 
CREATE TRIGGER trg_rating_before_insert 
BEFORE INSERT ON dbProj_ratings 
FOR EACH ROW 
BEGIN 
    IF NEW.rating_value < 1 OR NEW.rating_value > 5 THEN 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Rating value must be between 1 and 5'; 
    END IF; 
END $$ 
  
DELIMITER ; 
  
-- Trigger to validate rating value before updating an existing rating
DELIMITER $$ 
  
CREATE TRIGGER trg_rating_before_update 
BEFORE UPDATE ON dbProj_ratings 
FOR EACH ROW 
BEGIN 
    IF NEW.rating_value < 1 OR NEW.rating_value > 5 THEN 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Rating value must be between 1 and 5'; 
    END IF; 
END $$ 
DELIMITER ;