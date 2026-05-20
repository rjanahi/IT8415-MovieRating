-- Insert  SQL commands: 

-- Roles
INSERT INTO dbProj_roles (role_name) VALUES 
('Admin'), 
('Reviewer'), 
('User'); 

-- Users (Note: Passwords will be hashed later so we use placeholders here)
INSERT INTO dbProj_users (full_name, email, password_hash, role_id, created_at) 
VALUES 
('Omar Janahi', 'omar@example.com', 'hash123', 1, NOW()), 
('Fatima Ali', 'fatima@example.com', 'hash456', 2, NOW()), 
('Ahmed Salman', 'ahmed@example.com', 'hash789', 3, NOW()), 
('Sara Hassan', 'sara@example.com', 'hash101', 3, NOW()); 

-- Movies
INSERT INTO dbProj_movies (title, description, release_date, poster_image, 
created_by, created_at) VALUES 
('Interstellar', 'A sci-fi journey through space and time.', '2014-11-07', 'interstellar.jpg', 
1, NOW()), 
('Inception', 'A thief who steals secrets through dream-sharing technology.', '2010-07
16', 'inception.jpg', 2, NOW()), 
('The Dark Knight', 'Batman faces the Joker in Gotham City.', '2008-07-18', 
'dark_knight.jpg', 1, NOW()); 

-- Categories
INSERT INTO dbProj_categories (category_name) VALUES 
('Sci-Fi'), 
('Action'), 
('Drama'), 
('Thriller'); 

-- Movie-Categories
INSERT INTO dbProj_movie_categories (movie_id, category_id) VALUES 
(1, 1), 
(2, 1), 
(2, 4), 
(3, 2), 
(3, 4); 

-- Reviews
INSERT INTO dbProj_reviews (movie_id, user_id, review_title, review_text, created_at, 
updated_at) VALUES 
(1, 2, 'Amazing Sci-Fi', 'A masterpiece with emotional depth.', NOW(), NOW()), 
(2, 3, 'Mind-Bending', 'Complex but brilliant storytelling.', NOW(), NOW()), 
(3, 4, 'Best Batman Movie', 'Heath Ledger delivered an unforgettable performance.', 
NOW(), NOW()); 

-- Ratings
INSERT INTO dbProj_ratings (movie_id, user_id, rating_value, created_at) VALUES 
(1, 2, 5, NOW()), 
(1, 3, 4, NOW()), 
(2, 4, 5, NOW()), 
(3, 2, 5, NOW()); 

-- Comments
INSERT INTO dbProj_comments (review_id, user_id, comment_text, created_at) 
VALUES 
(1, 3, 'Totally agree with this review!', NOW()), 
(2, 1, 'Interesting perspective on the story.', NOW()), 
(3, 2, 'One of the best superhero movies ever made.', NOW());