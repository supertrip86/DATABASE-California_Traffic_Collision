/*
	6.	IMPROVED VERSION - Create a table to show how many cars has been 10 years or older at the time 
    of collision grouped by the ethnicity of the party.
*/

SELECT * FROM old_car_collisions_by_ethnicity;

/*
	CREATE TABLE old_car_collisions_by_ethnicity AS 
	SELECT 
		p.party_race AS Party_Race,
		COUNT(p.vehicle_year) AS Vehicle_Counts,
		COUNT(p.vehicle_year) / (SELECT 
				COUNT(p.vehicle_year)
			FROM
				parties AS p
					JOIN
				collisions AS c ON p.case_id = c.case_id
					JOIN
				victims AS v ON c.case_id = v.case_id
			WHERE
				(YEAR(c.collision_date) - p.vehicle_year) >= 10
					AND p.party_race IS NOT NULL
					AND v.victim_role = 1) * 100 AS Percentage
	FROM
		parties AS p
			JOIN
		collisions AS c ON p.case_id = c.case_id
			JOIN
		victims AS v ON c.case_id = v.case_id
	WHERE
		(YEAR(c.collision_date) - p.vehicle_year) >= 10
			AND p.party_race IS NOT NULL
			AND v.victim_role = 1
	GROUP BY Party_Race
	ORDER BY Vehicle_Counts DESC;
*/