CREATE TABLE main AS	
SELECT 
	table1.case_id AS case_id,
    table1.killed_victims AS killed_victims,
    table1.injured_victims AS injured_victims,
    table1.primary_collision_factor AS primary_collision_factor,
    table1.pcf_violation_category AS pcf_violation_category,
    table1.pedestrian_action AS pedestrian_action,
    table1.lighting AS lighting_condition,
    table1.alcohol_involved AS alcohol_involved,
    table1.collision_date AS collision_date,
    table2.party_type AS party_type,
	table2.party_race AS party_race,
    table2.party_sex AS party_sex,
    table2.party_sobriety AS party_sobriety,
    table2.party_drug_physical AS party_drug_physical,
    table2.under_influence_ethnicity AS under_influence_ethnicity,
    table2.vehicle_year AS vehicle_year,
    table2.vehicle_make AS vehicle_make,
	table3.victim_degree_of_injury AS victim_degree_of_injury,
    table3.victim_role AS victim_role,
    table3.victim_sex AS victim_sex,
    table3.victim_age AS victim_age
FROM
    (
		SELECT 
			*
		FROM
			collisions
		WHERE
			(primary_collision_factor IS NOT NULL) AND (primary_collision_factor != 2) AND (primary_collision_factor != 'unknown')
            AND (pcf_violation_category IS NOT NULL) AND (pcf_violation_category != 21804) AND (pcf_violation_category != 'unknown')
            AND (pedestrian_action IS NOT NULL)
            AND (lighting IS NOT NULL)
	) AS table1
	
    INNER JOIN
    
    (
		SELECT 
			*
		FROM
			parties
		WHERE
			(vehicle_year > 1929 OR vehicle_year < 2020)
            AND (vehicle_make IS NOT NULL)
            AND (party_drug_physical IS NOT NULL)
            AND (party_race IS NOT NULL)
            AND (under_influence_ethnicity IS NOT NULL)
	) AS table2 ON table1.case_id = table2.case_id
    
    INNER JOIN
	(
		SELECT 
			*
		FROM
			victims
		WHERE
			(victim_degree_of_injury IS NOT NULL) AND (victim_degree_of_injury != '7') AND (victim_degree_of_injury != '6') AND (victim_degree_of_injury != '5') AND (victim_degree_of_injury != 'M')
            AND (victim_age >-1 OR victim_age < 100)
            AND (victim_sex = 'male' OR victim_sex = 'female') 
            AND (victim_role != 'l') AND (victim_role != 'm') AND (victim_role IS NOT NULL)
	) AS table3 ON table1.case_id = table3.case_id