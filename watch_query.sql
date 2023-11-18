-- KPIs ------------------------------------------------------------------------------------------------------------

-- Total videos watched
SELECT COUNT(*) AS number_of_videos
FROM youtube_watch;

-- Total hours of videos watched minus ads
SELECT SUM(DATEPART(HOUR, time)) / 2 AS total_hours
FROM youtube_watch;

-- Average hours of videos watched
SELECT AVG(DATEPART(HOUR, time)) / 2 AS average_hours
FROM youtube_watch;

-- Group Analysis ---------------------------------------------------------------------------

-- How many videos were watched per year?
SELECT YEAR(date) AS year,
		COUNT(*) AS watched_number 
FROM youtube_watch
GROUP BY YEAR(date)
ORDER BY watched_number DESC;

-- How many videos are watched per season? 
SELECT CASE
		WHEN MONTH(date) IN (3,4,5) THEN 'spring'
		WHEN MONTH(date) IN (6,7,8) THEN 'summer'
		WHEN MONTH(date) IN (9,10,11) THEN 'autumn'
		ELSE 'winter'
		END AS 'seasons',
		MONTH(date) AS 'month'
INTO #season_watch
FROM youtube_watch;

SELECT seasons, COUNT(*) AS watched_number
FROM #season_watch
GROUP BY seasons
ORDER BY watched_number DESC;

-- Which months are the most videos watched?
SELECT MONTH(date) AS month,
		COUNT(*) AS watched_number 
FROM youtube_watch
GROUP BY MONTH(date)
ORDER BY watched_number DESC;

-- What day are the most videos watched?
SELECT DATENAME(WEEKDAY, date) AS 'day',
		COUNT(*) AS watched_number
FROM youtube_watch
GROUP BY DATENAME(WEEKDAY, date);

-- Time Analysis for year of most watched videos ----------------------------------------------------------------------

-- Is there a pattern in the hours of videos watched within the week, month?
SELECT DATEPART(MONTH, date) AS 'month',
		DATEPART(WEEK, date) AS 'week',
		DATEPART(WEEKDAY, date) AS 'day',
		AVG(DATEPART(HOUR, time)) AS hours_watched
INTO #youtube_2023
FROM youtube_watch
WHERE DATEPART(YEAR, date) = 2023
GROUP BY DATEPART(MONTH, date), DATEPART(WEEK, date), DATEPART(WEEKDAY, date)
ORDER BY month, week, day;

SELECT month,
		week,
		DATENAME(WEEKDAY, day) AS 'weekday',
		hours_watched,
		LAG(hours_watched) OVER(ORDER BY month, week, day) AS next_hours_watched,
		hours_watched - LAG(hours_watched) OVER(ORDER BY month, week, day) AS hours_difference
FROM #youtube_2023
ORDER BY month, week, day;

-- Which part of the day has the most search activity?
SELECT CASE
			WHEN time >= '05:00:00' AND time <= '12:00:00' THEN 'morning'
			WHEN time >= '12:00:01' AND time <= '17:00:00' THEN 'afternoon'
			WHEN time >= '17:00:01' AND time <= '21:00:00' THEN 'evening'
			ELSE 'night'
			END AS 'part_of_day',
		search_activity
INTO #youtube_search_2023
FROM youtube_watch
WHERE DATEPART(YEAR, date) = 2023;

SELECT part_of_day,
		COUNT(search_activity) AS number_of_searches
FROM #youtube_search_2023
GROUP BY part_of_day;

-- Content Analysis ------------------------------------------------------------------------------------------------

-- How many 'Official' non-ad videos were watched?
SELECT title,
		COUNT(*) AS watched_number,
		COUNT(search_activity) AS number_of_searches
FROM youtube_watch
WHERE title LIKE '%Official%'
GROUP BY title
HAVING COUNT(search_activity) = 0
ORDER BY watched_number DESC;

-- How many 'Official' ad videos were watched?
SELECT title,
		COUNT(*) AS watched_number,
		COUNT(search_activity) AS number_of_searches
FROM youtube_watch
WHERE title LIKE '%Official%'
GROUP BY title
HAVING COUNT(search_activity) > 0
ORDER BY watched_number DESC;

-- How many lyric non-ad videos are watched?
SELECT title,
		COUNT(*) watched_number,
		COUNT(search_activity) AS number_of_searches
FROM youtube_watch
WHERE title LIKE '%Lyric%'
GROUP BY title
HAVING COUNT(search_activity) = 0
ORDER BY watched_number DESC;

-- How many lyric ad videos are watched?
SELECT title,
		COUNT(*) watched_number,
		COUNT(search_activity) AS number_of_searches
FROM youtube_watch
WHERE title LIKE '%Lyric%'
GROUP BY title
HAVING COUNT(search_activity) > 0
ORDER BY watched_number DESC;

-- Of all the music videos, what is the portion of lyric videos are seen?
SELECT COUNT(*) AS watched_lyric,
		(SELECT COUNT(*)
			FROM youtube_watch
			WHERE title LIKE '%Official%') AS watched_official,
		(SELECT CAST(COUNT(*) AS FLOAT)
						FROM youtube_watch
						WHERE title LIKE '%Official%') / 
		(SELECT CAST(COUNT(*) AS FLOAT)
		FROM youtube_watch
		WHERE title LIKE '%Lyric%') AS official_to_lyric_ratio
FROM youtube_watch
WHERE title LIKE '%Lyric%';

--------------------------------------------------------------------------------