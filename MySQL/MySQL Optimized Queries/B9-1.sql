/*
	Note: Writing the second query, using “A New Table” to save time and effort.
*/


/*
	For A3, we have to write the exact double nested query, 
	in the improvement version, we have create a new table to store the filtered table, so we can save time and effort
    
	All the records of this table will b fall under the most frequent Primary Collision Factor (PCF), 
	We assumed that we don't know the name of the PCF that was the most common one
*/

/*
	Note: As a new practice, in the code above
    We also use IN instead of the "=" to have an example of negated subquery.
*/

SELECT 
    pcf_violation_category AS PCF_Violation_Categories,
    COUNT(pcf_violation_category) AS PCF_Category_Count,
    COUNT(pcf_violation_category) / (SELECT 
            COUNT(pcf_violation_category)
        FROM
            collisions_vehicle_code_violation
        WHERE
            YEAR(collision_date) <= 2010) * 100 AS Percentage_PCF_Category_Count,
    SUM(killed_victims) AS Death_Count,
    SUM(killed_victims) / (SELECT 
            SUM(killed_victims)
        FROM
            collisions_vehicle_code_violation
        WHERE
            YEAR(collision_date) <= 2010) * 100 AS Death_Percentage,
    SUM(injured_victims) AS Injuries_Count,
    SUM(injured_victims) / (SELECT 
            SUM(injured_victims)
        FROM
            collisions_vehicle_code_violation
        WHERE
            YEAR(collision_date) <= 2010) * 100 AS Injuries_Percentage
FROM
    collisions_vehicle_code_violation
WHERE
    YEAR(collision_date) <= 2010
GROUP BY pcf_violation_category
ORDER BY Death_Count DESC;

/*
	CREATE TABLE collisions_vehicle_code_violation
	AS (
	SELECT *
	FROM collisions
	WHERE primary_collision_factor IN (SELECT 
					primary_collision_factor
				FROM
					collisions
				GROUP BY primary_collision_factor
				ORDER BY COUNT(primary_collision_factor) DESC
				LIMIT 1)
	);
    
	Note: Even though, if we had the name of the most common PCF, we could write it in our 
    WHERE clause and improve the performance much faster.
	Using the below query, we can find the most common Primary Collision Factor.
*/