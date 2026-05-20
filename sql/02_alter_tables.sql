-- Alter SQL commands: 

-- Add CHECK constraint to ratings table to ensure rating_value is between 1 and 5
ALTER TABLE dbProj_ratings
ADD CONSTRAINT chk_rating_value
CHECK (rating_value BETWEEN 1 AND 5);


-- Add FULLTEXT index to movies table for title and description
ALTER TABLE dbProj_movies 
ADD FULLTEXT idx_movies_fulltext (title, description);