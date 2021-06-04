/*
	For the faster execution and improvement, 
    we can have another query to find out the name of the most frequent PCF

*/
	
SELECT 
	primary_collision_factor, COUNT(primary_collision_factor)
FROM
	collisions
GROUP BY primary_collision_factor
ORDER BY COUNT(primary_collision_factor) DESC
LIMIT 1;


/*
	And then , we will write the name of the most frequent PCF that is "Vehicle Code Violation"
	Therefore we can have a much faster query

*/

SELECT * FROM B2_pcf_category_fast;


SELECT 
    pcf_violation_category AS PCF_Violation_Categories,
    COUNT(pcf_violation_category) AS PCF_Category_Count,
    COUNT(pcf_violation_category) / (SELECT 
            COUNT(pcf_violation_category)
        FROM
            collisions
        WHERE
            YEAR(collision_date) > 2010
                AND primary_collision_factor = 'vehicle code violation') * 100 AS Percentage_PCF_Category_Count,
    SUM(killed_victims) AS Death_Count,
    SUM(killed_victims) / (SELECT 
            SUM(killed_victims)
        FROM
            collisions
        WHERE
            YEAR(collision_date) > 2010
                AND primary_collision_factor = 'vehicle code violation') * 100 AS Death_Percentage,
    SUM(injured_victims) AS Injuries_Count,
    SUM(injured_victims) / (SELECT 
            SUM(injured_victims)
        FROM
            collisions
        WHERE
            YEAR(collision_date) > 2010
                AND primary_collision_factor = 'vehicle code violation') * 100 AS Injuries_Percentage
FROM
    collisions
WHERE
    primary_collision_factor = 'vehicle code violation'
        AND YEAR(collision_date) > 2010
GROUP BY pcf_violation_category
ORDER BY Death_Count DESC;

