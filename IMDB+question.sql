USE imdb; 

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/
 
 
 
 -- Segment 1:




-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:

-- Count the total number of rows in the 'role_mapping' table
SELECT 
    COUNT(*) AS total_role_mapping_rows
FROM
    role_mapping;
-- Count the total number of rows in the 'names' table
SELECT 
    COUNT(*) AS total_names_rows
FROM
    names;
-- Count the total number of rows in the 'movie' table
SELECT 
    COUNT(*) AS total_movie_rows
FROM
    movie;
-- Count the total number of rows in the 'genre' table
SELECT 
    COUNT(*) AS total_genre_rows
FROM
    genre;
-- Count the total number of rows in the 'ratings' table
SELECT 
    COUNT(*) AS total_ratings_rows
FROM
    ratings;
-- Count the total number of rows in the 'director_mapping' table
SELECT 
    COUNT(*) AS total_director_mapping_rows
FROM
    director_mapping;








-- Q2. Which columns in the movie table have null values?
-- Type your code below:

-- Count the total number of rows in the 'role_mapping' table
SELECT 
    COUNT(*) AS Total_num_rows									-- Alias for the count of rows in 'role_mapping' 
FROM
    role_mapping;
-- Count the total number of rows in the 'names' table
SELECT 
    COUNT(*) AS Total_num_rows									-- Alias for the count of rows in 'names'
FROM
    names;
-- Count the total number of rows in the 'movie' table
SELECT 
    COUNT(*) AS Total_num_rows									-- Alias for the count of rows in 'movie'
FROM
    movie;
-- Count the total number of rows in the 'genre' table
SELECT 
    COUNT(*) AS Total_num_rows									-- Alias for the count of rows in 'genre'
FROM
    genre;
-- Count the total number of rows in the 'ratings' table
SELECT 
    COUNT(*) AS Total_num_rows									-- Alias for the count of rows in 'ratings'
FROM
    ratings;
-- Count the total number of rows in the 'director_mapping' table
SELECT 
    COUNT(*) AS Total_num_rows									-- Alias for the count of rows in 'director_mapping'
FROM
    director_mapping;
    
    
    
    
    
    
    
-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)
/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+


Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

-- Retrieve the year and count the number of movies for each year
SELECT 
    year AS movie_year, 						-- Alias for the 'year' column
    COUNT(id) AS number_of_movies 				-- Alias for the count of movies
FROM
    movie
GROUP BY 
	movie_year 									-- Grouping by the 'movie_year' alias
ORDER BY 
	movie_year; 								-- Ordering by the 'movie_year' alias

-- Month wise trend
-- Retrieve the month number and count the number of movies for each month
SELECT 
    MONTH(date_published) AS month_num, 		-- Alias for the month number extracted from 'date_published'
    COUNT(id) AS number_of_movies 				-- Alias for the count of movies
FROM
    movie
GROUP BY 
	month_num 									-- Grouping by the 'month_num' alias
ORDER BY 
	month_num; 									-- Ordering by the 'month_num' alias



/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/

-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:

-- Retrieve the year and count the number of movies for each year, based on the specified conditions
SELECT 
    year AS movie_year, 						-- Alias for the 'year' column
    COUNT(id) AS number_of_movies 				-- Alias for the count of movies
FROM
    movie
WHERE
    country = 'USA' 							-- Filter for movies from USA
    OR (country = 'India' AND year = 2019) 		-- Filter for movies from India in 2019
GROUP BY 
	movie_year 									-- Grouping by the 'movie_year' alias
ORDER BY 
	movie_year; 								-- Ordering by the 'movie_year' alias







/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:

-- Retrieve distinct genre values from the 'genre' table
SELECT DISTINCT
    genre AS distinct_genre 				-- Alias for the distinct genre values
FROM
    genre;







/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:

-- Retrieve the count of movies for each genre, sorted in descending order of movie count
SELECT 
    COUNT(movie_id) AS number_of_movies, 				-- Alias for the count of movies
    genre 												-- Alias for the 'genre' column
FROM
    genre
GROUP BY 
	genre -- Grouping by the 'genre' column
ORDER BY 
	number_of_movies DESC; 								-- Ordering by the movie count in descending order







/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:

-- Create a Common Table Expression (CTE) to count the number of movies that have exactly one genre
WITH cnt_genre AS
(
    SELECT 
        movie_id, 
        COUNT(genre) AS number_of_movies 				-- Alias for the count of genres per movie
    FROM 
        genre
    GROUP BY 
        movie_id
    HAVING 
        number_of_movies = 1 							-- Filtering for movies with exactly one genre
)
-- Retrieve the count of movies that have exactly one genre from the CTE
SELECT 
    COUNT(movie_id) AS number_of_movies 				-- Alias for the count of movies with one genre
FROM 
    cnt_genre;






/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)


/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

-- Retrieve the genre and average duration of movies for each genre, sorted in descending order of average duration
SELECT 
    a.genre, 											-- Alias for the 'genre' column
    AVG(b.duration) AS avg_duration 					-- Alias for the average duration of movies
FROM
    genre a
	INNER JOIN movie b 
		ON a.movie_id = b.id 							-- Joining the 'genre' and 'movie' tables based on movie_id and id
GROUP BY 
	a.genre 											-- Grouping by the 'genre' column
ORDER BY 
	avg_duration DESC; 									-- Ordering by the average duration in descending order







/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)


/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

-- Retrieve the genre, count of movies per genre, and the ranking of each genre based on movie count
SELECT 
	genre, 																		-- Alias for the 'genre' column
    COUNT(movie_id) AS movie_count, 											-- Alias for the count of movies per genre
    RANK() OVER (ORDER BY COUNT(movie_id) DESC) AS genre_rank 					-- Alias for the ranking of each genre based on movie count
FROM 
	genre
GROUP BY 
	genre;





/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/




-- Segment 2:




-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|min_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:

-- Retrieve the minimum and maximum values for average rating, total votes, and median rating from the ratings table
SELECT 
    MIN(avg_rating) AS min_avg_rating, 						-- Alias for the minimum average rating
    MAX(avg_rating) AS max_avg_rating, 						-- Alias for the maximum average rating
    MIN(total_votes) AS min_total_votes,					-- Alias for the minimum total votes
    MAX(total_votes) AS max_total_votes, 					-- Alias for the maximum total votes
    MIN(median_rating) AS min_median_rating, 				-- Alias for the minimum median rating
    MAX(median_rating) AS max_median_rating 				-- Alias for the maximum median rating
FROM
    ratings;







/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too

-- Create a Common Table Expression (CTE) named 'top_movies' to select the top-rated movies
WITH top_movies AS (
    SELECT 
        title, 																-- Alias for the 'title' column
        avg_rating, 														-- Alias for the average rating
        DENSE_RANK() OVER (ORDER BY avg_rating DESC) AS movie_rank 			-- Alias for the movie rank based on average rating
    FROM 
        movie
    INNER JOIN ratings ON id = movie_id 									-- Joining the 'movie' and 'ratings' tables based on movie_id
    GROUP BY 
        title, avg_rating 													-- Grouping by title and average rating
    ORDER BY 
        movie_rank 															-- Ordering by movie rank
)
-- Retrieve the top-rated movies with a movie rank less than or equal to 10
SELECT * FROM top_movies
WHERE 
    movie_rank <= 10;








/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have

-- Retrieve the median rating and count of movies for each median rating
SELECT 
    median_rating, 							-- Alias for the 'median_rating' column
    COUNT(movie_id) AS movie_count 			-- Alias for the count of movies for each median rating
FROM
    ratings
GROUP BY 
    median_rating 							-- Grouping by the 'median_rating' column
ORDER BY 
    median_rating; 							-- Ordering by median rating







/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:

-- Retrieve the production company, count of movies per production company, and ranking of each production company based on movie count
SELECT 
    production_company, 													-- Alias for the 'production_company' column
    COUNT(id) AS movie_count, 												-- Alias for the count of movies per production company
    DENSE_RANK() OVER (ORDER BY COUNT(id) DESC) AS prod_company_rank 		-- Alias for the ranking of each production company based on movie count
FROM 
    movie
INNER JOIN ratings ON id = movie_id 										-- Joining the 'movie' and 'ratings' tables based on movie_id
WHERE 
    avg_rating > 8 															-- Filter for movies with an average rating greater than 8
    AND production_company IS NOT NULL 										-- Filter for movies with a non-null production company
GROUP BY 
    production_company; 													-- Grouping by the 'production_company' column







-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

-- Retrieve the genre and count of movies for each genre based on specific conditions, sorted in descending order of movie count
SELECT 
    g.genre, 												-- Alias for the 'genre' column
    COUNT(m.id) AS movie_count 								-- Alias for the count of movies for each genre
FROM
    genre g
    INNER JOIN movie m ON m.id = g.movie_id 				-- Joining the 'genre' and 'movie' tables based on movie_id
    INNER JOIN ratings r ON m.id = r.movie_id 				-- Joining the 'movie' and 'ratings' tables based on movie_id
WHERE
    year = 2017 											-- Filter for movies released in the year 2017
    AND MONTH(date_published) = 4 							-- Filter for movies with a date of publication in April (month 4)
    AND country = 'USA' 									-- Filter for movies from the USA
    AND total_votes > 1000 									-- Filter for movies with more than 1000 total votes
GROUP BY g.genre 											-- Grouping by the 'genre' column
ORDER BY COUNT(m.id) DESC; 									-- Ordering by the movie count in descending order









-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

-- Retrieve the title, average rating, and genre of movies that start with 'The' and have an average rating greater than 8, sorted in descending order of average rating
SELECT 
    m.title, 											-- Alias for the 'title' column
    r.avg_rating, 										-- Alias for the average rating
    g.genre 											-- Alias for the 'genre' column
FROM
    genre g
    INNER JOIN movie m 
		ON m.id = g.movie_id 							-- Joining the 'genre' and 'movie' tables based on movie_id
    INNER JOIN ratings r 
		ON m.id = r.movie_id 							-- Joining the 'movie' and 'ratings' tables based on movie_id
WHERE
    m.title LIKE 'The%' 								-- Filter for movies that start with 'The'
    AND r.avg_rating > 8 								-- Filter for movies with an average rating greater than 8
ORDER BY
    r.avg_rating DESC; 									-- Ordering by average rating in descending order








-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:

-- Retrieve the count of movies and median rating for movies published between April 1, 2018 and April 1, 2019 with a median rating of 8
SELECT 
    COUNT(m.id) AS movie_count, 							-- Alias for the count of movies
    median_rating 											-- Alias for the median rating
FROM
    movie m
INNER JOIN ratings r ON m.id = r.movie_id 					-- Joining the 'movie' and 'ratings' tables based on movie_id
WHERE
    date_published BETWEEN '2018-04-01' AND '2019-04-01' 	-- Filter for movies published between April 1, 2018 and April 1, 2019
    AND median_rating = 8 									-- Filter for movies with a median rating of 8
GROUP BY 
    median_rating; 											-- Grouping by the median rating







-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:

-- Retrieve the country and the sum of total votes for movies from Germany and Italy
SELECT 
    country, 												-- Alias for the 'country' column
    SUM(total_votes) AS votes 								-- Alias for the sum of total votes
FROM
    ratings r
INNER JOIN movie m ON r.movie_id = m.id 					-- Joining the 'ratings' and 'movie' tables based on movie_id
WHERE
    country IN ('Germany', 'Italy') 						-- Filter for movies from Germany and Italy
GROUP BY 
    country; 												-- Grouping by the 'country' column

-- Answer is Yes





/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/



-- Segment 3:




-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

-- Retrieve the count of NULL values for specific columns in the 'names' table
SELECT 
    SUM(CASE
        WHEN name IS NULL THEN 1
        ELSE 0
    END) AS null_name, 									-- Alias for the count of NULL values in the 'name' column
    SUM(CASE
        WHEN height IS NULL THEN 1
        ELSE 0
    END) AS null_height, 								-- Alias for the count of NULL values in the 'height' column
    SUM(CASE
        WHEN date_of_birth IS NULL THEN 1
        ELSE 0
    END) AS null_date_of_birth, 						-- Alias for the count of NULL values in the 'date_of_birth' column
    SUM(CASE
        WHEN known_for_movies IS NULL THEN 1
        ELSE 0
    END) AS null_known_for_movies 						-- Alias for the count of NULL values in the 'known_for_movies' column
FROM
    names; 												-- The 'names' table







/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/


-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

-- Retrieve the top 3 directors with the highest movie count from the top 3 genres based on average rating

-- CTE to select the top 3 genres based on movie count
WITH top3_genres AS (
    -- CTE to select the top 3 genres based on movie count with average rating > 8
    SELECT
        g.genre,
        COUNT(g.movie_id) AS movie_count 																						-- Count the number of movies for each genre
    FROM
        genre g 																												-- Joining the genre table
    INNER JOIN ratings r 																										-- Joining the ratings table
		ON g.movie_id = r.movie_id
    WHERE
        avg_rating > 8 																											-- Filter genres with average rating > 8
    GROUP BY
        genre 																													-- Grouping the results by genre
    ORDER BY
        movie_count DESC 																										-- Ordering the results by movie count in descending order
    LIMIT 3 																													-- Limiting the results to the top 3 genres
),
-- CTE to select the directors and their movie count, and assign ranks
top3_directors AS (
    SELECT
        n.name AS director_name,
        COUNT(d.movie_id) AS movie_count, 																						-- Count the number of movies for each director
        RANK() OVER(ORDER BY COUNT(d.movie_id) DESC) AS director_rank 															-- Assigning ranks to directors based on movie count
    FROM
        names n 																												-- Joining the names table
    INNER JOIN director_mapping d 																								-- Joining the director_mapping table
		ON n.id = d.name_id
    INNER JOIN ratings r 																										-- Joining the ratings table
		ON r.movie_id = d.movie_id
    INNER JOIN genre g 																											-- Joining the genre table
		ON g.movie_id = d.movie_id
    INNER JOIN top3_genres 																										-- Joining the top3_genres CTE
		ON g.genre = top3_genres.genre
    WHERE
        r.avg_rating > 8 																										-- Filter directors with average rating > 8
    GROUP BY
        n.name 																													-- Grouping the results by director name
    ORDER BY
        movie_count DESC 																										-- Ordering the results by movie count in descending order
)
-- Final SELECT statement to retrieve the director name and movie count of the top 3 directors
SELECT
    director_name,
    movie_count
FROM
    top3_directors 																												-- Selecting the director name and movie count from the top3_directors CTE
WHERE
    director_rank <= 3 																											-- Limiting the results to the top 3 directors based on rank
LIMIT 3; 																														-- Limiting the overall results to 3 rows







/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/


-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

-- Retrieve the top 2 actors with the highest movie count based on a median rating of 8 or higher

SELECT
    n.name AS actor_name,
    COUNT(m.id) AS movie_count
FROM
    names n
	INNER JOIN role_mapping rm 
		ON n.id = rm.name_id 					-- Join the names and role_mapping tables based on the name_id column
	INNER JOIN movie m 
		ON rm.movie_id = m.id 					-- Join the movie table based on the movie_id column from role_mapping
	INNER JOIN ratings r 
		ON m.id = r.movie_id 					-- Join the ratings table based on the movie_id column from movie
WHERE
    median_rating >= 8 							-- Filter movies with a median rating of 8 or higher
GROUP BY
    n.name 										-- Group the results by actor name
ORDER BY
    movie_count DESC 							-- Order the results by movie count in descending order
LIMIT 2; 										-- Limit the result to the top 2 actors








/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/


-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

-- Retrieve the top 3 production companies based on the total vote count from ratings
WITH ranked_data AS (
    -- Subquery to calculate the vote count and rank for each production company
    SELECT 
        production_company, 
        SUM(ratings.total_votes) AS vote_count, 																-- Calculate the total vote count for each production company
        RANK() OVER (ORDER BY SUM(ratings.total_votes) DESC) AS prod_comp_rank 									-- Rank the production companies based on vote count
    FROM 
        movie 																									-- Joining the movie table
    INNER JOIN ratings		 																					-- Joining the ratings table
        ON movie.id = ratings.movie_id
    GROUP BY 
        production_company 																						-- Grouping the results by production company
)
SELECT 
    production_company, 
    vote_count, 
    prod_comp_rank
FROM 
    ranked_data 																								-- Selecting the production company, vote count, and rank from the ranked_data subquery
ORDER BY 
    vote_count DESC 																							-- Ordering the results by vote count in descending order
LIMIT 3; 																										-- Limiting the results to the top 3 production companies based on vote count







/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/


-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Retrieve actor statistics based on movie ratings and total votes

SELECT 
    n.name AS actor_name, 																						-- Select the actor name
    SUM(total_votes) AS total_votes, 																			-- Calculate the total votes for the actor's movies
    COUNT(rm.movie_id) AS movie_count, 																			-- Count the number of movies the actor has appeared in
    ROUND(SUM(total_votes * avg_rating) / SUM(total_votes), 2) AS actor_avg_rating, 							-- Calculate the average rating for the actor's movies
    RANK() OVER (ORDER BY SUM(total_votes * avg_rating) / SUM(total_votes) DESC) AS actor_rank 					-- Assign a rank to the actor based on their average rating
FROM 
    names n 																									-- Select from the 'names' table for actor information
INNER JOIN role_mapping rm 																						-- Join the 'role_mapping' table to link actors to movies
    ON n.id = rm.name_id 
INNER JOIN movie m 																								-- Join the 'movie' table to retrieve movie information
    ON rm.movie_id = m.id 
INNER JOIN ratings r 																							-- Join the 'ratings' table to get movie ratings
    ON r.movie_id = m.id 
WHERE 
    country = 'India' AND category = 'actor' 																	-- Filter for actors from India and belonging to the 'actor' category
GROUP BY 
    actor_name 																									-- Group the results by actor name
HAVING 
    COUNT(rm.movie_id) >= 5 																					-- Include only actors who have appeared in at least 5 movies
ORDER BY 
    actor_avg_rating DESC; 																						-- Sort the results by actor's average rating in descending order







-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

SELECT
    n.name AS actor_name, 																					-- Select the actor name
    SUM(r.total_votes) AS total_votes, 																		-- Sum of total votes for all movies of the actor
    COUNT(DISTINCT r.movie_id) AS movie_count, 																-- Count of distinct movies the actor has appeared in
    ROUND(AVG(r.avg_rating), 2) AS actress_avg_rating, 														-- Average rating of the actor's movies rounded to 2 decimal places
    RANK() OVER (ORDER BY ROUND(AVG(r.avg_rating), 2) DESC, SUM(r.total_votes) DESC) AS actress_rank 		-- Rank the actresses based on average rating and total votes
FROM
    names n 																								-- Table containing actor names
JOIN
    role_mapping rm ON n.id = rm.name_id 																	-- Join the role_mapping table to map actors to movies
JOIN
    movie m ON rm.movie_id = m.id 																			-- Join the movie table to get movie information
JOIN
    ratings r ON m.id = r.movie_id 																			-- Join the ratings table to get movie ratings
JOIN
    genre g ON m.id = g.movie_id 																			-- Join the genre table to get movie genres
WHERE
    m.country = 'India' 																					-- Consider only Indian movies
    AND rm.category = 'actress' 																			-- Consider only actresses
    AND m.languages = 'Hindi' 																				-- Consider only movies in Hindi language
GROUP BY
    n.name 																									-- Group the results by actor name
HAVING
    COUNT(DISTINCT r.movie_id) >= 3 																		-- Consider only actresses with at least three movies
ORDER BY
    actress_rank 																							-- Order the results by actress rank
LIMIT 5; 																									-- Limit the results to top 5 actresses







/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:
SELECT
    m.title AS movie_title, 																	-- Select the movie title
    AVG(r.avg_rating) AS avg_rating, 															-- Calculate the average rating of the movie
    CASE
        WHEN AVG(r.avg_rating) > 8 THEN 'Superhit movies' 										-- Categorize movies with average rating greater than 8 as "Superhit movies"
        WHEN AVG(r.avg_rating) BETWEEN 7 AND 8 THEN 'Hit movies' 								-- Categorize movies with average rating between 7 and 8 as "Hit movies"
        WHEN AVG(r.avg_rating) BETWEEN 5 AND 7 THEN 'One-time-watch movies' 					-- Categorize movies with average rating between 5 and 7 as "One-time-watch movies"
        ELSE 'Flop movies' 																		-- Categorize movies with average rating less than 5 as "Flop movies"
    END AS movie_category 																		-- Assign the movie category based on the average rating
FROM
    movie m 																					-- Table containing movie information
JOIN
    genre g ON m.id = g.movie_id 																-- Join the genre table to get genre information
JOIN
    ratings r ON m.id = r.movie_id 																-- Join the ratings table to get movie ratings
WHERE
    g.genre = 'Thriller' 																		-- Consider only thriller movies
GROUP BY
    m.title 																					-- Group the results by movie title
ORDER BY
    avg_rating DESC; 																			-- Order the results by average rating in descending order








/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/




-- Segment 4:




-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:
WITH genre_avg AS (
    SELECT 
        genre, 
        AVG(duration) AS avg_duration 														-- Calculate the average duration for each genre
    FROM 
        genre AS g 																			-- Table containing genre information
    INNER JOIN movie AS m 																	-- Join the movie table to get movie duration
        ON g.movie_id = m.id
    GROUP BY 
        genre 																				-- Group the results by genre
    ORDER BY 
        AVG(duration) 																		-- Order the results by average duration
)
SELECT 
    genre, 
    ROUND(avg_duration, 2) AS avg_duration, 												-- Round the average duration to 2 decimal places
    ROUND(SUM(avg_duration) OVER (ORDER BY avg_duration), 2) AS running_total_duration, 	-- Calculate the running total of average duration
    ROUND(AVG(avg_duration) OVER (ORDER BY avg_duration), 2) AS moving_avg_duration 		-- Calculate the moving average of average duration
FROM 
    genre_avg; 																				-- Use the genre_avg CTE as the data source

-- Round is good to have and not a must have; Same thing applies to sorting







-- Let us find top 5 movies of each year with top 3 genres.


-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 Genres based on most number of movies

WITH top_genres AS (
    SELECT 
        genre, 
        COUNT(*) AS movie_count 																									-- Count the number of movies for each genre
    FROM 
        genre
    GROUP BY 
        genre
    ORDER BY 
        movie_count DESC
    LIMIT 3 																														-- Select the top 3 genres with the highest movie count
),
top_movies AS (
    SELECT
        g.genre,
        m.year,
        m.title AS movie_name,
        CASE
            WHEN m.worlwide_gross_income LIKE 'INR%' THEN CONCAT('$', ROUND(SUBSTRING(m.worlwide_gross_income, 4) / 80, 2)) 		-- Convert INR to USD and round the converted value to 2 decimal places
            ELSE m.worlwide_gross_income 																							-- Keep the original value if it's not in INR format
        END AS worldwide_gross_income,
        RANK() OVER (PARTITION BY m.year, g.genre ORDER BY m.worlwide_gross_income DESC) AS movie_rank 								-- Assign a rank to movies within each genre and year based on worldwide gross income
    FROM
        movie m
    JOIN
        genre g ON m.id = g.movie_id
    JOIN
        top_genres tg ON g.genre = tg.genre 																						-- Filter movies by the top genres
    WHERE
        m.worlwide_gross_income IS NOT NULL 																						-- Exclude movies with NULL worldwide gross income
    ORDER BY
        m.year, g.genre, movie_rank 																								-- Order the results by year, genre, and movie rank
    LIMIT 5
)
SELECT 
    g.genre, 
    year, 
    movie_name, 
    worldwide_gross_income, 
    movie_rank 
FROM 
    top_genres g
JOIN 
    top_movies m ON m.genre = g.genre 																								-- Join the top_genres and top_movies CTEs on the genre
GROUP BY 
    g.genre, 
    year, 
    movie_name, 
    worldwide_gross_income, 
    movie_rank 																														-- Group the results by genre, year, movie name, worldwide gross income, and movie rank
ORDER BY 
    movie_rank; 																													-- Order the final results by movie rank







-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.


-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:
SELECT
    m.production_company AS production_company,
    COUNT(*) AS movie_count, 																	-- Count the number of movies for each production company
    RANK() OVER (ORDER BY COUNT(*) DESC) AS prod_comp_rank 										-- Assign a rank to each production company based on the movie count
FROM
    movie m
JOIN
    ratings r ON m.id = r.movie_id
WHERE
    r.median_rating >= 8 																		-- Consider only movies with a median rating of 8 or higher
    AND m.production_company IS NOT NULL 														-- Exclude movies with NULL production company
GROUP BY
    m.production_company
HAVING
    COUNT(*) > 0 																				-- Filter out production companies with zero movie count
ORDER BY
    prod_comp_rank 																				-- Order the results by production company rank
LIMIT 2; 																						-- Limit the output to the top 2 production companies based on movie count




-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:
SELECT
    n.name AS actress_name,
    SUM(r.total_votes) AS total_votes,
    COUNT(DISTINCT r.movie_id) AS movie_count,
    ROUND(SUM(r.avg_rating * total_votes) / SUM(total_votes), 2) AS actress_avg_rating,                              -- Calculating the wighted average of the avg_rating of actress
    DENSE_RANK() OVER (ORDER BY COUNT(DISTINCT r.movie_id) DESC) AS actress_rank
FROM
    names n
JOIN
    role_mapping rm ON n.id = rm.name_id
JOIN
    movie m ON rm.movie_id = m.id
JOIN
    ratings r ON m.id = r.movie_id
JOIN
    genre g ON m.id = g.movie_id
WHERE
    rm.category = 'actress' 																						-- Consider only actresses
    AND g.genre = 'drama' 																							-- Consider only movies with drama genre
    AND r.avg_rating > 8 																							-- Consider only Super Hit movies
GROUP BY
    n.name
ORDER BY
    actress_rank, 																									-- Order the results by actress rank
    actress_avg_rating DESC, 																						-- Then by actress average rating in descending order
    movie_count; 																									-- Then by movie count

/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:
WITH top_director_summary AS (
    -- CTE to select top directors and gather relevant information
    WITH top_directors AS (
        SELECT 
            name_id, 
            name, 
            dm.movie_id, 
            avg_rating, 
            total_votes,
            m.date_published, 
            LEAD(date_published) OVER (PARTITION BY dm.name_id ORDER BY date_published, dm.movie_id) AS next_movie_published,   		-- Using window function lead to get the previous date 
            duration
        FROM 
            director_mapping dm 																										-- Joining director_mapping table
        INNER JOIN names n 																												-- Joining names table
            ON dm.name_id = n.id
        INNER JOIN ratings r 																											-- Joining ratings table
            ON dm.movie_id = r.movie_id
        INNER JOIN movie m 																												-- Joining movie table
            ON dm.movie_id = m.id
    )
    SELECT 
        name_id AS director_id, 
        name AS director_name, 
        COUNT(movie_id) AS number_of_movies, 																							-- Counting the number of movies per director
        ROUND(AVG(DATEDIFF(next_movie_published, date_published)), 2) AS avg_inter_movie_days, 											-- Calculating average days between consecutive movies
        ROUND(AVG(avg_rating), 2) AS avg_rating, 																						-- Calculating average rating per director
        ROUND(SUM(avg_rating * total_votes) / SUM(total_votes), 2) AS avg_ratings, 														-- Calculating average rating weighted by total votes
        SUM(total_votes) AS total_votes, 																								-- Calculating the total votes received by the director's movies
        MIN(avg_rating) AS min_rating, 																									-- Finding the minimum rating among the director's movies
        MAX(avg_rating) AS max_rating, 																									-- Finding the maximum rating among the director's movies
        SUM(duration) AS total_duration, 																								-- Calculating the total duration of the director's movies
        RANK() OVER (ORDER BY COUNT(movie_id) DESC) AS movie_rank 																		-- Ranking the directors based on the number of movies
    FROM 
        top_directors
    GROUP BY 
        name_id 																														-- Grouping the results by director ID
)
SELECT 
    director_id,
    director_name,
    number_of_movies,
    avg_inter_movie_days,
    avg_ratings,
    total_votes,
    min_rating,
    max_rating,
    total_duration
FROM
    top_director_summary
WHERE 
    movie_rank <= 9; 																													-- Filtering the results to include only the top 9 ranked directors
    
    