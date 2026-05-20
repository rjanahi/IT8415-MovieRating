--05_procedures.sql
-- Procedures SQL commands: 
-- • keyword search (optional) 
-- • start date (optional) 
-- • end date (optional) 
-- • popularity ranking automatically included 
 
-- 1) Basic search stored procedure 
DELIMITER $$

CREATE PROCEDURE sp_search_movies_basic (
    IN p_keyword VARCHAR(255),
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT
        m.movie_id,
        m.title,
        m.description,
        m.release_date,
        m.poster_image,

        IF(
            p_keyword IS NULL OR p_keyword = '',
            0,
            MATCH(m.title, m.description)
            AGAINST(p_keyword)
        ) AS relevance,

       ROUND(IFNULL(AVG(r.rating_value), 0), 1) AS avg_rating,
        COUNT(r.rating_id) AS total_ratings

    FROM dbProj_movies m

    LEFT JOIN dbProj_ratings r
        ON m.movie_id = r.movie_id

    WHERE
        (
            p_keyword IS NULL
            OR p_keyword = ''
            OR MATCH(m.title, m.description)
               AGAINST(p_keyword)
        )
        AND
        (
            p_start_date IS NULL
            OR m.release_date >= p_start_date
        )
        AND
        (
            p_end_date IS NULL
            OR m.release_date <= p_end_date
        )

    GROUP BY
        m.movie_id,
        m.title,
        m.description,
        m.release_date,
        m.poster_image

    ORDER BY
        relevance DESC,
        avg_rating DESC,
        total_ratings DESC,
        m.release_date DESC;

END $$

DELIMITER ;
 
-- 2) Full-text search stored procedure: 

DELIMITER $$

CREATE PROCEDURE sp_search_movies_boolean (
    IN p_keyword VARCHAR(255),
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT
        m.movie_id,
        m.title,
        m.description,
        m.release_date,
        m.poster_image,

        IF(
            p_keyword IS NULL OR p_keyword = '',
            0,
            MATCH(m.title, m.description)
            AGAINST( p_keyword IN BOOLEAN MODE)
        ) AS relevance,

        ROUND(IFNULL(AVG(r.rating_value), 0), 1) AS avg_rating,
        COUNT(r.rating_id) AS total_ratings

    FROM dbProj_movies m

    LEFT JOIN dbProj_ratings r
        ON m.movie_id = r.movie_id

    WHERE
        (
            p_keyword IS NULL
            OR p_keyword = ''
            OR MATCH(m.title, m.description)
               AGAINST( p_keyword IN BOOLEAN MODE)
        )
        AND
        (
            p_start_date IS NULL
            OR m.release_date >= p_start_date
        )
        AND
        (
            p_end_date IS NULL
            OR m.release_date <= p_end_date
        )

    GROUP BY
        m.movie_id,
        m.title,
        m.description,
        m.release_date,
        m.poster_image

    ORDER BY
        relevance DESC,
        avg_rating DESC,
        total_ratings DESC,
        m.release_date DESC;

END $$

DELIMITER ;