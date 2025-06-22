
-- MovieVerse SQL Project (No ML)

-- 1. Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    join_date DATE
);

-- 2. Movies Table
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(150),
    release_year INT,
    duration INT,
    rating FLOAT,
    language VARCHAR(50)
);

-- 3. Genres Table
CREATE TABLE Genres (
    genre_id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- 4. Movie_Genres Table
CREATE TABLE Movie_Genres (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)
);

-- 5. Watch_History Table
CREATE TABLE Watch_History (
    user_id INT,
    movie_id INT,
    watch_date DATE,
    watch_duration INT,
    PRIMARY KEY (user_id, movie_id, watch_date),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- 6. Reviews Table
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 10),
    comment TEXT,
    review_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- Sample Data
INSERT INTO Users VALUES
(1, 'Alice', 'alice@email.com', '2022-01-10'),
(2, 'Bob', 'bob@email.com', '2023-03-21');

INSERT INTO Movies VALUES
(1, 'Inception', 2010, 148, 8.8, 'English'),
(2, 'Interstellar', 2014, 169, 8.6, 'English'),
(3, '3 Idiots', 2009, 171, 8.4, 'Hindi'),
(4, 'Tenet', 2020, 150, 7.5, 'English');

INSERT INTO Genres VALUES
(1, 'Sci-Fi'), (2, 'Drama'), (3, 'Comedy'), (4, 'Thriller');

INSERT INTO Movie_Genres VALUES
(1, 1), (1, 2),
(2, 1), (2, 2),
(3, 2), (3, 3),
(4, 1), (4, 4);

INSERT INTO Watch_History VALUES
(1, 1, '2024-06-01', 148),
(1, 3, '2024-06-02', 171),
(2, 2, '2024-06-03', 160);

INSERT INTO Reviews VALUES
(101, 1, 1, 9, 'Mind-blowing visuals and plot.', '2024-06-02'),
(102, 1, 3, 8, 'Very emotional and funny.', '2024-06-03'),
(103, 2, 2, 10, 'A masterpiece of sci-fi cinema.', '2024-06-04');
