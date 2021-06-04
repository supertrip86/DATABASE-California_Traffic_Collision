/*
	7.	We know that on 4th March 2020 California state went under lockdown because of Covid-19 virus. 
	At first, find the most recent date of collision in our schema and compare the number of collisions, 
    deaths, and injuries at the same period in 2019.
*/

SELECT
    YEAR(collision_date) AS YEAR_LIST,
    COUNT(case_id) AS Collision_Count,
    SUM(killed_victims) AS Death_Count,
    SUM(injured_victims) AS Injury_Count
FROM
    collisions
WHERE
    collision_date >= '2020-03-04' 
		AND collision_date <= (
			SELECT MAX(collision_date)
				FROM collisions
			)
UNION SELECT 
    YEAR(collision_date) AS YEAR_LIST,
    COUNT(case_id) AS Collision_Count,
    SUM(killed_victims) AS Death_Count,
    SUM(injured_victims) AS Injury_Count
FROM
    collisions
WHERE
    collision_date >= '2019-03-04'
        AND collision_date <= DATE_SUB((
			SELECT MAX(collision_date)
				FROM collisions
			), INTERVAL 1 YEAR)
GROUP BY YEAR(collision_date);

/*
    Comment: The most recent record is on 22nd Oct 2020, in the following query, we’ll check the same 
    information for both time intervals (i.e., From 4th March 2020 – 22nd Oct 2020, and From 4th March 2019 – 22nd Oct 2019)
    
    Comment: We notice the number of collisions, deaths and injuries decreased dramatically during lockdown Covid-19.
*/