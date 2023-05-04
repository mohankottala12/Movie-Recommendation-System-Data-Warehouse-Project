create database task;
use task;
CREATE TABLE movies (
  movieId INT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  genres VARCHAR(255) NOT NULL
);
SET GLOBAL local_infile=1;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/movies.csv' INTO TABLE movies
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE ratings (
  userId INT,
  movieId INT NOT NULL,
  rating VARCHAR(255) NOT NULL,
  timestamp VARCHAR(255) NOT NULL
);
SET GLOBAL local_infile=1;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ratings.csv' INTO TABLE ratings
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- displaying top 5 rows in movies table
SELECT movieId, title FROM movies LIMIT 5;

-- displaying top 5 rows in ratings table
SELECT userId, movieId, rating FROM ratings LIMIT 5;

-- creating view MOVIE_RATINGS by combining movies and ratings
CREATE VIEW movie_ratings AS
SELECT m.movieId AS movie_id, m.title, m.genres, r.userId, r.rating, r.timestamp
FROM movies m
JOIN ratings r ON m.movieId = r.movieId;

-- displaying top 10 rows in newly created view
SELECT * FROM movie_ratings LIMIT 10;

-- Total number of movies
SELECT COUNT(*) AS total_movies FROM movies;

-- Total number of users
SELECT COUNT(DISTINCT userId) AS total_users FROM ratings;

-- movies rated by each user
SELECT userId, COUNT(*) AS num_movies_rated FROM ratings GROUP BY userId;

-- number of users rated each movie
SELECT m.movieId, m.title, COUNT(*) AS num_users_rated FROM movies m
INNER JOIN ratings r ON m.movieId = r.movieId GROUP BY m.movieId, m.title;

--  top 10 highest rated movies of all time:
SELECT m.title, AVG(r.rating) AS avg_rating FROM movies m
INNER JOIN ratings r ON m.movieId = r.movieId
GROUP BY m.title
ORDER BY avg_rating DESC LIMIT 10;

-- most rated genres
SELECT m.genres, COUNT(*) AS num_ratings FROM movies m
INNER JOIN ratings r ON m.movieId = r.movieId
GROUP BY m.genres
ORDER BY num_ratings DESC LIMIT 10;



-- average rating per genre
SELECT m.genres, AVG(r.rating) AS avg_rating FROM movies m
INNER JOIN ratings r ON m.movieId = r.movieId
GROUP BY m.genres
ORDER BY avg_rating DESC LIMIT 10;







