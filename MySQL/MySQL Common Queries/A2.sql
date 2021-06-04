/*
    2.	Create a table to show the number of collisions, deaths and injuries with 
    their respected percentages for everyday in the week.
*/

SELECT
    MONTHNAME(collision_date) AS Month_Name,
    DAYNAME(collision_date) AS Weekday,
    COUNT(case_id) AS Collisions_Count,
    COUNT(case_id) / (SELECT 
            COUNT(case_id)
        FROM
            collisions) * 100 AS Collisions_Percentage,
    SUM(injured_victims) AS Injuries_Count,
    SUM(injured_victims) / (SELECT 
            SUM(injured_victims)
        FROM
            collisions) * 100 AS Injuries_Percentage,
    SUM(killed_victims) AS Death_Count,
    SUM(killed_victims) / (SELECT 
            SUM(killed_victims)
        FROM
            collisions) * 100 AS Death_Percentage
FROM
    collisions
GROUP BY Month_Name , Weekday
ORDER BY Death_Count DESC;

/*
    Comment: We notice that even though on Fridays we had more collisions than other days, 
    but the collisions happened on weekend (Saturdays and Sundays) lead to more death counts.
    
    27s
*/

