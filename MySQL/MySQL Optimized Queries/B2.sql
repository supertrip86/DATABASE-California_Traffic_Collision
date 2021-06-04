/*
    2.	IMPROVED VERSION - Create a table to show the number of collisions, deaths and injuries with 
    their respected percentages for everyday in the week. 
*/

SELECT * FROM countby_day_month;

SELECT
	MONTHNAME(collision_date) AS Month_Name,
    DAYNAME(collision_date) AS Weekday,
    COUNT(*) AS Collisions_Count,
    COUNT(*) * 100 / SUM(COUNT(*)) OVER () AS Collision_Percentage,
    SUM(injured_victims) AS Injuries_Count,
    SUM(injured_victims) * 100 / SUM(SUM(injured_victims)) OVER () AS Injury_Percentage,
    SUM(killed_victims) AS Death_Count,
    SUM(killed_victims) * 100 / SUM(SUM(killed_victims)) OVER () AS Death_Percentage
FROM
    collisions
GROUP BY Month_Name, Weekday
ORDER BY Death_Count DESC;

/*
    Comment: We notice that even though on Fridays we had more collisions than other days, 
    but the collisions happened on weekend (Saturdays and Sundays) lead to more death counts.
    
    21s
*/

