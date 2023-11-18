-- How many videos are watched per season? 
CREATE VIEW season_watch_v AS 
SELECT CASE
		WHEN MONTH(date) IN (3,4,5) THEN 'spring'
		WHEN MONTH(date) IN (6,7,8) THEN 'summer'
		WHEN MONTH(date) IN (9,10,11) THEN 'autumn'
		ELSE 'winter'
		END AS 'seasons',
		MONTH(date) AS 'month'
FROM youtube_watch;

-- Is there a pattern in the hours of videos watched within the week, month?
CREATE VIEW youtube_2023_v AS 
SELECT DATEPART(MONTH, date) AS 'month',
		DATEPART(WEEK, date) AS 'week',
		DATEPART(WEEKDAY, date) AS 'day',
		AVG(DATEPART(HOUR, time)) AS hours_watched
FROM youtube_watch
WHERE DATEPART(YEAR, date) = 2023
GROUP BY DATEPART(MONTH, date), DATEPART(WEEK, date), DATEPART(WEEKDAY, date);

-- Which part of the day has the most search activity?
CREATE VIEW youtube_search_2023_v AS 
SELECT CASE
			WHEN time >= '05:00:00' AND time <= '12:00:00' THEN 'morning'
			WHEN time >= '12:00:01' AND time <= '17:00:00' THEN 'afternoon'
			WHEN time >= '17:00:01' AND time <= '21:00:00' THEN 'evening'
			ELSE 'night'
			END AS 'part_of_day',
		search_activity
FROM youtube_watch
WHERE DATEPART(YEAR, date) = 2023;