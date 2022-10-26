Create database Sql2Inclass2;
use Sql2Inclass2;
-- --------------------------------------------------------------
# Dataset Used: wine.csv
-- --------------------------------------------------------------
# Q1. Give a dense rank to the wine varities on the basis of the price.
 select price,variety,
 rank()over(order by price desc) rnk
 from wine;
# Q2. Use aggregate window functions to find the average of points for each row within
# its partition (country) and also arrange the final result in the descending order by country.
# print country,province,winery,variety
select * from
(select country,province,winery,variety,
avg(points) over(partition by country ) avg_p
from wine)t
 order by country desc;

# Dataset Used: students.csv
-- --------------------------------------------------------------
# Q3. Provide the new roll numbers to the students on the basis of their names alphabetically.
select student_id,name,
row_number() over(order by name )rn
from students;
-----------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
-----------------------------------------------------------------
select * from website_stats;
select * from web;
# Q4. Display the difference in ad_clicks between the current day and the next day for 
# the website 'Olympus'
select ad_clicks,lead(ad_clicks) over(order by day),
ad_clicks-lead(ad_clicks) over(order by day)diff
from website_stats
where website_id= (select id from web where name='olympus');

# Q5. Write a query that displays the statistics for website_id = 3 such that for each row,
# show the day, the number of users and the smallest number of users ever.
select day,no_users,
count(no_users) over(order by day) c_user,
min(no_users) over(order by day) m_user 
from website_stats
where website_id=3;
# Dataset Used: play_store.csv and sale.csv
-- ---------------------------------------------------------------

# Q6. Write a query thats orders games in the play store into three buckets as 
#per editor ratings received  from higher to lowest
#ntile()
# Q7. Write a query that displays the name of the game, the price, the sale date and 
#the 4th column should display # the sales consecutive number i.e. ranking of game as 
#per the sale took place, so that the latest game sold gets number 1. 
#Order the result by editor's rating of the game
select * from play_store;
select * from sale;
select name,price ,date,
rank() over(order by date desc) rnk
from play_store p join sale s
on p.id=s.game_id
order by editor_rating;
-----------------------------------------------------------------
# Dataset Used: movies.csv, ratings.csv, rent.csv
-----------------------------------------------------------------
# Q8. Write a query that displays basic movie informations as well as the previous rating 
#provided by customer for that same movie 
# make sure that the list is sorted by the id of the reviews.
select * from movies;
select * from ratings;
select * from rent;
select m.id,title,rating,
lag(rating) over (partition by id) review_by_cust
from movies m join ratings r 
on m.id=r.movie_id;
# Q9. For each movie, show the following information: title, genre, average user rating for 
#that movie  and its rank in the respective genre based on that average rating in descending 
#order (so that the best movies will be shown first).
with temp as
(select title,genre,avg(rating) avg_r
from ratings r join movies m
on r.movie_id=m.id
group by m.title,m.genre)


select title,genre,
rank() over (partition by genre order by avg_r desc)score
from temp;
-- or
select title,genre,avg(rating) avg_r
from ratings r join movies m
on r.movie_id=m.id
group by m.title,m.genre
order by avg_r;
# Q10. For each rental date, show the rental_date, the sum of payment amounts 
#(column name payment_amounts) from rent 
#on that day, the sum of payment_amounts on the previous day and the difference between 
#these two values.
with temp as
(select rental_date,sum(payment_amount),payment_amount
from rent
group by rental_date
order by rental_date)
select rental_date,payment_amount,lag(payment_amount) over(),
payment_amount - lag(payment_amount) over() diff
from temp;