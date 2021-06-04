/*
	6.	IMPROVED VERSION - Create a table to show how many cars has been 10 years or older at the time 
    of collision grouped by the ethnicity of the party.
*/

/*
	Note: First, we'll create a new table with the information we'll need from all 3 tables.
    In this way, we don't need to use JOIN anymore, since we have all the information we need
    in one single table.
*/

CREATE TABLE collisions_race_cars_date AS
SELECT
    p.party_race AS Party_Race,
    p.vehicle_year AS Vehicle_Year,
    YEAR(c.collision_date) AS Collision_Year
FROM
    parties AS p
        JOIN
    collisions AS c ON p.case_id = c.case_id
        JOIN
    victims AS v ON c.case_id = v.case_id
WHERE
        p.party_race IS NOT NULL
        AND v.victim_role = 1;


/*
	Note: Now that we have our desired table, we can run the below query and obtain the same result, more efficiently.
*/


SELECT
    Party_Race,
    COUNT(Vehicle_Year) AS Vehicle_Counts,
    COUNT(Vehicle_Year) / SUM(COUNT(Vehicle_Year)) OVER () * 100 AS Percentage
FROM
    collisions_race_cars_date
WHERE
    (Collision_Year - Vehicle_Year) >= 10
GROUP BY Party_Race
ORDER BY Vehicle_Counts DESC;
