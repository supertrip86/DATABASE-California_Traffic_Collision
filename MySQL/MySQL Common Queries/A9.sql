/*
    9.	Create a table to show the count of most frequent PCF (Primary Collision Factor) 
    Violation Categories that are under the most frequent PCF, and the number of dead and 
    injuries associated with each of them among the 2 decades under study. (i.e., 2001 - 2010 and 2011 – 2020)
*/

SELECT 
    pcf_violation_category AS PCF_Violation_Categories,
    COUNT(pcf_violation_category) AS PCF_Category_Count,
    COUNT(pcf_violation_category) / (SELECT 
            COUNT(pcf_violation_category)
        FROM
            collisions
        WHERE
            YEAR(collision_date) > 2010
                AND pcf_violation_category = (SELECT 
                    COUNT(pcf_violation_category)
                FROM
                    collisions
                WHERE
                    pcf_violation_category = (SELECT 
                            primary_collision_factor
                        FROM
                            collisions
                        GROUP BY primary_collision_factor
                        ORDER BY COUNT(primary_collision_factor) DESC
                        LIMIT 1))) * 100 AS Percentage_PCF_Category_Count,
    SUM(killed_victims) AS Death_Count,
    SUM(killed_victims) / (SELECT 
            SUM(killed_victims)
        FROM
            collisions
        WHERE
            YEAR(collision_date) > 2010
                AND pcf_violation_category = (SELECT 
                    COUNT(pcf_violation_category)
                FROM
                    collisions
                WHERE
                    pcf_violation_category = (SELECT 
                            primary_collision_factor
                        FROM
                            collisions
                        GROUP BY primary_collision_factor
                        ORDER BY COUNT(primary_collision_factor) DESC
                        LIMIT 1))) * 100 AS Death_Percentage,
    SUM(injured_victims) AS Injuries_Count,
    SUM(injured_victims) / (SELECT 
            SUM(injured_victims)
        FROM
            collisions
        WHERE
            YEAR(collision_date) > 2010
                AND pcf_violation_category = (SELECT 
                    COUNT(pcf_violation_category)
                FROM
                    collisions
                WHERE
                    pcf_violation_category = (SELECT 
                            primary_collision_factor
                        FROM
                            collisions
                        GROUP BY primary_collision_factor
                        ORDER BY COUNT(primary_collision_factor) DESC
                        LIMIT 1))) * 100 AS Injuries_Percentage
FROM
    collisions
WHERE
    pcf_violation_category = (SELECT 
            COUNT(pcf_violation_category)
        FROM
            collisions
        WHERE
            pcf_violation_category = (SELECT 
                    primary_collision_factor
                FROM
                    collisions
                GROUP BY primary_collision_factor
                ORDER BY COUNT(primary_collision_factor) DESC
                LIMIT 1))
        AND YEAR(collision_date) > 2010
GROUP BY pcf_violation_category
ORDER BY Death_Count DESC;


/*
    Note: Firstly, we write the query to retrieve the data in the recent decade (2011-2020)
    
    Comment: Looking at the results obtained in the following pages, we notice that even though 
    “DUI” (Driving Under Influence) is the cause of only 7% of the collisions, it is responsible 
    for over 20% of the deaths, standing as the main cause of collisions ending up in death of a party 
    for both decades.
	“Speeding” is the most common PCF violation category under ‘Vehicle Code Violation’ being responsible 
    for almost one third of the collisions in both decades.
	Another interesting fact is that the number of deaths in the recent decade is decreased compared to 
    the previous one (2001-2010). Even though, it is apparent that we don’t have all the information about 
    the year 2020.
	In the recent decade (2011-2020) we don’t have any death caused by “pedestrian dui” which is a huge 
    improvement since the previous decade, as it caused 124 death counts standing as top 15 causes of death 
    under “Vehicle Code Violation”.
*/