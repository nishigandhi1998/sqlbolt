--CH1 - Select Queries 101

-- Find the title of each film

SELECT Title
FROM Movies;

-- Find the director of each film

SELECT Director
FROM Movies;

-- Find the title and director of each film

SELECT Title, Director
FROM Movies;

-- Find the title and year of each film

SELECT Title, Director
FROM Movies;

-- Find all the information about each film

SELECT *
FROM Movies;

-- CH2 - Queries with constraints (Pt. 1)

-- Find the movie with a row id of 6

SELECT *
FROM Movies
WHERE Id = 6;

-- Find the movies released in the years between 2000 and 2010

SELECT *
FROM Movies
WHERE Year BETWEEN 2000 AND 2010;

-- Find the movies not released in the years between 2000 and 2010

SELECT *
FROM Movies
WHERE Year NOT BETWEEN 2000 AND 2010;

-- Find the first 5 Pixar movies and their release  year

SELECT *
FROM Movies
WHERE Id BETWEEN 1 AND 5;

-- CH3 - Queries with constraints (Pt. 2)

-- Find all the Toy Story movies

SELECT *
FROM Movies
WHERE Title LIKE "%Toy Story%";

-- Find all the movies directed by John Lasseter

SELECT *
FROM Movies
WHERE Director = "John Lasseter";

-- Find all the movies (and director) not directed by John Lasseter

SELECT *
FROM Movies
WHERE Director != "John Lasseter";

-- Find all the WALL-* movies

SELECT *
FROM Movies
WHERE Title LIKE "%WALL%";

-- CH4 - Filtering and sorting Query results

-- List all directors of Pixar movies (alphabetically), without duplicates

SELECT DISTINCT Director
FROM Movies
ORDER BY Director;

-- List the last four Pixar movies released (ordered from most recent to least)

SELECT *
FROM Movies
ORDER BY Year DESC
LIMIT 4;

-- List the first five Pixar movies sorted alphabetically

SELECT *
FROM Movies
ORDER BY Title   /*by default asc */
LIMIT 5;

-- List the next five Pixar movies sorted alphabetically

SELECT *
FROM Movies
ORDER BY Title    /*by default asc */
LIMIT 5
OFFSET 5;

-- CH5 - Review Simple SELECT Queries

-- List all the Canadian cities and their populations 

SELECT *
FROM North_american_cities
WHERE Country LIKE "Canada";

-- Order all the cities in the United States by their latitude from north to south

SELECT *
FROM North_american_cities
WHERE Country = "United States"
ORDER BY Latitude DESC;

-- List all the cities west of Chicago, ordered from west to east

SELECT *
FROM North_american_cities
WHERE Longitude < -87.69
ORDER BY Longitude;                    /* by default asc */
 
-- List the two largest cities in Mexico (by population)

SELECT *
FROM North_american_cities
WHERE Country LIKE "Mexico"
ORDER BY Population DESC
LIMIT 2;

-- List the third and fourth largest cities (by population) in the United States and their population

SELECT *
FROM North_american_cities
WHERE Country LIKE "United States"
ORDER BY Population DESC
LIMIT 2
OFFSET 2;

-- CH6 - Multi-table queries with JOINs

-- Find the domestic and international sales for each movie

SELECT m.Title, bo.International_sales, bo.Domestic_sales
FROM Movies as m 
JOIN Boxoffice as bo
ON m.Id=bo.Movie_id;

-- Show the sales numbers for each movie that did better internationally rather than domestically

SELECT m.Title, bo.International_sales, bo.Domestic_sales
FROM Movies as m 
JOIN Boxoffice as bo
ON m.Id = bo.Movie_id
WHERE bo.International_sales > bo.Domestic_sales;

-- List all the movies by their ratings in descending order

SELECT m.Title, bo.Rating
FROM Movies as m
JOIN Boxoffice as bo
ON m.Id=bo.Movie_id
ORDER BY bo.Rating DESC;

-- CH7 - OUTER JOIN

-- Find the list of all buildings that have employees

SELECT DISTINCT e.Building
FROM Employees as e
LEFT JOIN Buildings as b
ON e.Building=b.Building_name
WHERE e.Years_employed NOT NULL;

-- Find the list of all buildings and their capacity

SELECT *
FROM Buildings;

-- List all buildings and the distinct employee roles in each building (including empty buildings)

SELECT DISTINCT b.Building_name, e.Role 
FROM Buildings as b
LEFT JOIN employees as e 
ON b.building_name = e.building;

-- CH8 - A short note on NULLs

-- Find the name and role of all employees who have not been assigned to a building

SELECT e.name , e.role
FROM Employees as e 
LEFT JOIN Buildings as b
ON b.Building_name = e.Building
WHERE e.Building IS NULL;

-- Find the names of the buildings that hold no employees

SELECT b.Building_name
FROM Buildings as b
LEFT JOIN Employees as e
ON b.Building_name = e.Building
WHERE e.Building IS NULL;

-- CH9 - Queries with expressions

-- List all movies and their combined sales in millions of dollars

SELECT m.Title, (bo.Domestic_sales + bo.International_sales)/1000000 AS Total_Sales_Millions
FROM Movies as m
LEFT JOIN Boxoffice as bo 
ON m.Id=bo.Movie_Id;

-- List all movies and their ratings in percent

SELECT m.Title, bo.Rating*10 as Percent
FROM Movies as m
LEFT JOIN Boxoffice as bo
ON m.Id=bo.Movie_Id;

-- List all movies that were released on even number years

SELECT m.Title, m.Year
FROM Movies as m
LEFT JOIN Boxoffice as bo
ON m.Id=bo.Movie_Id
WHERE m.Year % 2 = 0;

-- CH10 - Queries with aggregates (Pt. 1)

-- Find the longest time that an employee has been at the studio

SELECT MAX(Years_employed)
FROM Employees;

-- For each role, find the average number of years employed by employees in that role

SELECT Role, AVG(Years_Employed) 
FROM Employees
GROUP BY Role;

-- Find the total number of employee years worked in each building

SELECT Building, SUM(Years_Employed) 
FROM Employees
GROUP BY Building;

-- CH11 - Queries with aggregates (Pt. 2)

-- Find the number of Artists in the studio (without a HAVING clause)

SELECT Role, COUNT(role) AS Number_of_Artists
FROM Employees
WHERE Role = "Artist";

-- Find the number of Employees of each role in the studio

SELECT Role, COUNT(role)
FROM Employees
GROUP BY Role;

-- Find the total number of years employed by all Engineers

SELECT Role, SUM(Years_Employed)
FROM Employees
GROUP BY Role
HAVING Role = "Engineer";

-- CH12 - Order of execution of a Query

-- Find the number of movies each director has directed

SELECT director, COUNT(Title)
FROM Movies
GROUP BY Director;

-- Find the total domestic and international sales that can be attributed to each director

SELECT m.Director, sum(bo.Domestic_sales + bo.International_Sales) as Total_Sales
FROM Movies as m
JOIN Boxoffice as bo
ON m.Id = bo.Movie_ID
GROUP BY m.Director;

-- CH13 - Inserting rows

-- Add the studio's new production, Toy Story 4 to the list of movies (you can use any director)

INSERT INTO Movies,
VALUES (4, "Toy Story 4", "Nishi Gandhi", 1998, 123);

-- Toy Story 4 has been released to critical acclaim! It had a rating of 8.7, and made 340 million domestically and 270 million internationally. Add the record to the  BoxOffice table. 
INSERT INTO Boxoffice
VALUES (4, 8.7, 340000000, 270000000);

-- CH14 - Updating rows

-- The director for A Bug's Life is incorrect, it was actually directed by John Lasseter
update Movies
set director = "John Lasseter"
where id = 2;

-- The year that Toy Story 2 was released is incorrect, it was actually released in 1999
update Movies
set year = 1999
where id = 3;

-- Both the title and directory for Toy Story 8 is incorrect! The title should be "Toy Story 3" and it was directed by Lee Unkrich
update Movies
set title = "Toy Story 3",
     director = "Lee Unkrich"
where id = 11;
-- CH15 - Deleting rows

-- This database is getting too big, lets remove all movies that were released before 2005.
DELETE FROM Movies
WHERE Year < 2005;

-- Andrew Stanton has also left the studio, so please remove all movies directed by him.
DELETE FROM Movies
WHERE Director = "Andrew Stanton";

-- CH16 - Creating Tables

-- Create a new table named Database with the following columns:
-- 1. Name A string (text) describing the name of the database
-- 2. Version A number (floating point) of the latest version of this database
-- 3. Download_count An integer count of the number of times this database was downloaded
-- This table has no constraints.
CREATE TABLE Database (
    Name TEXT,
    Version FLOAT,
    Download_Count INTEGER);
    
-- CH17 - Altering Tables

-- Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each movie was released in.
ALTER TABLE Movies
  ADD COLUMN Aspect_ratio FLOAT DEFAULT 3;
  
-- Add another column named Language with a TEXT data type to store the language that the movie was released in. Ensure that the default for this language is English.
ALTER TABLE Movies
  ADD COLUMN Language TEXT DEFAULT "English";

-- CH18 - Dropping Tables

-- We've sadly reached the end of our lessons, lets clean up by removing the Movies table
DROP TABLE Movies;

-- And drop the BoxOffice table as well
DROP TABLE BoxOffice;
