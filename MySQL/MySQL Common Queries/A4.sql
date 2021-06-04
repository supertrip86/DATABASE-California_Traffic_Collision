/*
	4.	Check the relation between “alcohol_involved” with death and injuries with their respected percentages.
*/

SELECT DISTINCT
    (CASE
        WHEN alcohol_involved IS NULL THEN 0
        ELSE 1
    END) AS Alcohol_Involved,
    COUNT(CASE
        WHEN alcohol_involved IS NULL THEN 0
        ELSE 1
    END) AS Cases_Count,
    COUNT(CASE
        WHEN alcohol_involved IS NULL THEN 0
        ELSE 1
    END) / (SELECT 
            COUNT(CASE
                    WHEN alcohol_involved IS NULL THEN 0
                    ELSE 1
                END)
        FROM
            collisions) * 100 AS Alcohol_Involved_Percentage,
    SUM(killed_victims) AS Death,
    SUM(killed_victims) / (SELECT 
            SUM(killed_victims)
        FROM
            collisions) * 100 AS Death_Percentage,
    SUM(injured_victims) AS Injured,
    SUM(injured_victims) / (SELECT 
            SUM(injured_victims)
        FROM
            collisions) * 100 AS Injured_Percentage
FROM
    collisions
GROUP BY Alcohol_Involved;

/*
	Note: Looking at the “collisions” table and “alcohol_involved” column, we’ll notice 
    that whenever the alcohol was involved the value is 1 and when it wasn’t it’s NULL, 
    therefore, we have to create a CASE to sort out the results.
    
    Comment: Despite having only 10% of cases being involved with alcohol, we notice that 
    over 35% of the deaths fall under it.
    
    18s
*/

