/*
    1.	Create a table to show the total number and percentage of collisions, injuries and deaths 
    over the Californian roads throughout the years 2001-2020. 
*/

SELECT
    YEAR(collision_date) AS Years,
    COUNT(*) AS Collision_Count,
	SUM(injured_victims) AS Injury_Count,
    SUM(killed_victims) AS Death_Count
FROM
    collisions
GROUP BY Years
ORDER BY Years DESC;

/*
    Comment: By looking at the results, we notice that collisions started to decrease dramatically 
    from 2008 until 2015, although despite the fact that the number of collisions started to 
    increase from 2015, they haven’t reached above 500,000.
    
    11s
*/

