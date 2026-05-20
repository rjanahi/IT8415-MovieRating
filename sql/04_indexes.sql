-- Index SQL commands: 

-- Indexes to improve query performance
-- Note: FULLTEXT index is already added in the alter_tables.sql file for title and description in movies table

-- Index on movie title for faster search
CREATE INDEX idx_movies_title 
ON dbProj_movies(title); 

-- Index on release date for sorting and filtering
CREATE INDEX idx_movies_release_date 
ON dbProj_movies(release_date); 

--Index on movie_id in ratings for faster aggregation and lookups
CREATE INDEX idx_ratings_movie_id 
ON dbProj_ratings(movie_id); 

--Index on movie_id in reviews for faster lookups
CREATE INDEX idx_reviews_movie_id 
ON dbProj_reviews(movie_id); 

--Index on user_id in reviews for faster lookups
CREATE INDEX idx_reviews_user_id 
ON dbProj_reviews(user_id); 

--Index on review_id in comments for faster lookups
CREATE INDEX idx_comments_review_id 
ON dbProj_comments(review_id);

--Index on user_id in comments for faster lookups
CREATE INDEX idx_comments_user_id 
ON dbProj_comments(user_id); 

--Index on role_id in users for faster lookups
CREATE INDEX idx_users_role_id 
ON dbProj_users(role_id);