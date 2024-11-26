-- Create a new database
CREATE DATABASE winemag_data;

-- Use the new database
USE winemag_data;

-- Create the first table (wine_data_1)
CREATE TABLE wine_data_1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(255),
    description TEXT,
    designation VARCHAR(255),
    points INT,
    price FLOAT,
    province VARCHAR(255),
    region_1 VARCHAR(255),
    region_2 VARCHAR(255),
    taster_name VARCHAR(255),
    taster_twitter_handle VARCHAR(255),
    title VARCHAR(255),
    variety VARCHAR(255),
    winery VARCHAR(255)
);

-- Create the second table (wine_data_2)
CREATE TABLE wine_data_2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(255),
    description TEXT,
    designation VARCHAR(255),
    points INT,
    price FLOAT,
    province VARCHAR(255),
    region_1 VARCHAR(255),
    region_2 VARCHAR(255),
    variety VARCHAR(255),
    winery VARCHAR(255)
);

-- Upload wine_data_1 CSV
LOAD DATA INFILE '/path.../winemag-data-130k-v2.csv'
INTO TABLE wine_data_1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Upload wine_data_2 CSV
LOAD DATA INFILE '/path.../winemag-data_first150k.csv'
INTO TABLE wine_data_2
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Skill: JOIN, Filtering
-- This query joins both datasets by winery and filters the result to show wines priced above $50.

SELECT a.winery, a.title AS title_1, a.price AS price_1, a.points AS points_1,
       b.title AS title_2, b.price AS price_2, b.points AS points_2
FROM wine_data_1 a
INNER JOIN wine_data_2 b ON a.winery = b.winery
WHERE a.price > 50
LIMIT 10;

-- Skill: Aggregation (AVG), Grouping, JOIN
-- This query calculates the average price of wines from each winery, with wines priced greater than $50.

SELECT a.winery, AVG(a.price) AS avg_price_1, AVG(b.price) AS avg_price_2
FROM wine_data_1 a
LEFT JOIN wine_data_2 b ON a.winery = b.winery
WHERE a.price > 50
GROUP BY a.winery
ORDER BY avg_price_1 DESC;

-- Skill: Aggregation (COUNT), Grouping, Filtering
-- This query counts the number of wines from each country in wine_data_1 that have a rating greater than 90.

SELECT country, COUNT(*) AS wine_count
FROM wine_data_1
WHERE points > 90
GROUP BY country
ORDER BY wine_count DESC
LIMIT 10;

-- Skill: Aggregation (SUM, AVG), Grouping, Filtering
-- This query calculates the total points and average price for each wine variety in wine_data_1 from Napa Valley.

SELECT variety, SUM(points) AS total_points, AVG(price) AS avg_price
FROM wine_data_1
WHERE region_1 = 'Napa Valley'
GROUP BY variety
ORDER BY total_points DESC
LIMIT 10;

-- Skill: Aggregation, Filtering, Grouping, HAVING Clause
-- This query calculates the average price and total points for wines priced above $100, grouped by country.

SELECT country, AVG(price) AS avg_price, SUM(points) AS total_points
FROM wine_data_1
WHERE price > 100
GROUP BY country
HAVING AVG(price) > 100
ORDER BY total_points DESC;

-- Skill: JOIN, Aggregation, Filtering
-- This query calculates the average price and points for each winery across both datasets, filtering wines priced above $50.

SELECT a.winery, AVG(a.price) AS avg_price_1, AVG(b.price) AS avg_price_2,
       AVG(a.points) AS avg_points_1, AVG(b.points) AS avg_points_2
FROM wine_data_1 a
LEFT JOIN wine_data_2 b ON a.winery = b.winery
WHERE a.price > 50
GROUP BY a.winery
ORDER BY avg_price_1 DESC;

-- Skill: Filtering, Aggregation, JOIN
-- This query finds wines in wine_data_1 that are missing region information and have a rating greater than 85.

SELECT title, country, points, price
FROM wine_data_1
WHERE region_1 IS NULL AND points > 85
LIMIT 10;
