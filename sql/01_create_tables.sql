-- Create SQL commands: 

-- Roles
CREATE TABLE dbProj_roles( 
role_id INT AUTO_INCREMENT PRIMARY KEY, 
role_name VARCHAR(50) NOT NULL UNIQUE 
);  

-- Users
CREATE TABLE dbProj_users( 
user_id INT AUTO_INCREMENT PRIMARY KEY, 
full_name VARCHAR(100) NOT NULL, 
email VARCHAR(150) NOT NULL UNIQUE, 
password_hash VARCHAR(255) NOT NULL, 
role_id INT NOT NULL, 
created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
CONSTRAINT fk_users_role FOREIGN KEY(role_id) REFERENCES dbProj_roles(role_id) 
ON DELETE RESTRICT ON UPDATE CASCADE 
);  

-- Categories
CREATE TABLE dbProj_categories( 
category_id INT AUTO_INCREMENT PRIMARY KEY, 
category_name VARCHAR(100) NOT NULL UNIQUE 
);  

-- Movies
CREATE TABLE dbProj_movies( 
movie_id INT AUTO_INCREMENT PRIMARY KEY, 
title VARCHAR(255) NOT NULL, 
description TEXT NOT NULL, 
release_date DATE NOT NULL, 
poster_image VARCHAR(255) NOT NULL, 
created_by INT NOT NULL, 
created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
CONSTRAINT fk_movies_user FOREIGN KEY(created_by) REFERENCES 
dbProj_users(user_id) ON DELETE CASCADE ON UPDATE CASCADE 
);  

-- Movie-Categories
CREATE TABLE dbProj_movie_categories( 
movie_id INT NOT NULL, 
category_id INT NOT NULL, 
PRIMARY KEY(movie_id, category_id), 
CONSTRAINT fk_moviecategories_movie FOREIGN KEY(movie_id) REFERENCES 
dbProj_movies(movie_id) ON DELETE CASCADE ON UPDATE CASCADE, 
CONSTRAINT fk_moviecategories_category FOREIGN KEY(category_id) REFERENCES 
dbProj_categories(category_id) ON DELETE CASCADE ON UPDATE CASCADE 
);  

-- Reviews
CREATE TABLE dbProj_reviews( 
review_id INT AUTO_INCREMENT PRIMARY KEY, 
movie_id INT NOT NULL, 
user_id INT NOT NULL, 
review_title VARCHAR(255) NOT NULL, 
review_text TEXT NOT NULL, 
created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE 
CURRENT_TIMESTAMP, 
CONSTRAINT fk_reviews_movie FOREIGN KEY(movie_id) REFERENCES 
dbProj_movies(movie_id) ON DELETE CASCADE ON UPDATE CASCADE, 
CONSTRAINT fk_reviews_user FOREIGN KEY(user_id) REFERENCES 
dbProj_users(user_id) ON DELETE CASCADE ON UPDATE CASCADE 
);  

-- Comments
CREATE TABLE dbProj_comments( 
comment_id INT AUTO_INCREMENT PRIMARY KEY, 
review_id INT NOT NULL, 
user_id INT NOT NULL, 
comment_text TEXT NOT NULL, 
created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
CONSTRAINT fk_comments_review FOREIGN KEY(review_id) REFERENCES 
dbProj_reviews(review_id) ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT fk_comments_user FOREIGN KEY(user_id) REFERENCES 
dbProj_users(user_id) ON DELETE CASCADE ON UPDATE CASCADE 
);  
  
-- Ratings
CREATE TABLE dbProj_ratings ( 
    rating_id INT AUTO_INCREMENT PRIMARY KEY, 
    movie_id INT NOT NULL, 
    user_id INT NOT NULL, 
    rating_value INT NOT NULL, 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
  
    CONSTRAINT uq_movie_user_rating UNIQUE (movie_id, user_id), 
  
    CONSTRAINT fk_ratings_movie 
        FOREIGN KEY (movie_id) 
        REFERENCES dbProj_movies(movie_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE, 
  
    CONSTRAINT fk_ratings_user 
        FOREIGN KEY (user_id) 
        REFERENCES dbProj_users(user_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE 
);