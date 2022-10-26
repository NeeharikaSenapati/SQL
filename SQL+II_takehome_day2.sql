CREATE SCHEMA IF NOT EXISTS Video_Games;
USE Video_Games;
SELECT * FROM Video_Games_Sales;

# 1. Display the names of the Games, platform and total sales in North America for respective platforms.
select * from video_games_sales;
select name,platform,
sum(NA_sales)over(partition by platform) 'sum_na'
from video_games_sales;

# 2. Display the name of the game, platform , Genre and total sales in North America for corresponding Genre as Genre_Sales,total sales for the given platform as Platformm_Sales and also display the global sales as total sales .
# Also arrange the results in descending order according to the Total Sales.
(select name,platform,genre,
sum(NA_sales) over(partition by genre) genre_sales,
sum(NA_sales) over (partition by platform) platform_sales,
sum(Global_Sales) over() total_sales
from video_games_sales) order by total_sales desc;

# 3. Use nonaggregate window functions to produce the row number for each row 
# within its partition (Platform) ordered by release year.
select platform,Year_of_Release,
row_number() over(partition by platform order by Year_of_Release) row_no
from video_games_sales;


# 4. Use aggregate window functions to produce the average global sales of each row within its partition (Year of release). Also arrange the result in the descending order by year of release.
   (select name, global_sales,year_of_release,
   avg(global_sales) over(partition by year_of_release) avg_global_sales
   from video_games_sales)order by Year_of_Release desc;
select * from video_games_sales;
# 5. Display the name of the top 5 Games with highest Critic Score For Each Publisher. 
select * from
(select name,critic_score,
dense_rank() over(partition by publisher order by critic_score desc) drnk
from video_games_sales)a
where drnk<=5;


------------------------------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
------------------------------------------------------------------------------------
# 6. Write a query that displays the opening date two rows forward i.e. the 1st row should display the 3rd website launch date
select * from web;
select * from website_stats;
select id,name,launch_date,lead(launch_date,2)
over()third_web
from web;

# 7. Write a query that displays the statistics for website_id = 1 i.e. for each row, show the day, the income and the income on the first day.
select * from
(select day,income,
dense_rank() over(order by website_id) drnk
from website_stats)r
where drnk=1;

-----------------------------------------------------------------
# Dataset Used: play_store.csv 
-----------------------------------------------------------------
# 8. For each game, show its name, genre and date of release. In the next three columns, show RANK(), DENSE_RANK() and ROW_NUMBER() sorted by the date of release.
select  name,genre,released,
rank() over( order by released),
dense_rank() over(order by released),
row_number() over(order by released)
from play_store;
