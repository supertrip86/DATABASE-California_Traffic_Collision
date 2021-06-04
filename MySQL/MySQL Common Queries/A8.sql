/*
	8.	Create a table to show the top 10 "life-threatening" vehicles (brands) , which each had over 10,000 collision,
    along with the number of killed victims per vehicle and the percentage of collison/death ratio.
*/

/*
	Note: As we look at this problem, we notice that grouping by "vehicle brands" with two different conditions
    (i.e. In one column, number of total collisions and in another number of fatal collisions)
    We have to write 2 different queries and use INNER JOIN to join them by their mutual column which is "Car_Brand"
*/

SELECT 
    Table1.Car_Brand,
    Table1.Collision_Count,
    Table2.Death_Count,
    ((Table2.Death_Count / Table1.Collision_Count) * 100) AS Death_Percentage
FROM
    (
		SELECT 
		p.vehicle_make AS Car_Brand,
			COUNT(p.case_id) AS Collision_Count
		FROM
			parties AS p
		WHERE
			p.vehicle_make IS NOT NULL
		GROUP BY Car_Brand
		ORDER BY Collision_Count
	) AS Table1
	
    INNER JOIN
    
    (
		SELECT 
			p.vehicle_make AS Car_Brand, COUNT(p.case_id) AS Death_Count
		FROM
			parties AS p
		JOIN victims AS v ON p.case_id = v.case_id
		WHERE
			p.vehicle_make IS NOT NULL
				AND v.victim_degree_of_injury = 'killed'
		GROUP BY Car_Brand
	) AS Table2 ON table1.Car_brand = Table2.Car_brand
    
WHERE
    Table1.Collision_Count > 10000
ORDER BY Death_Percentage DESC;

/*
	Comment: Looking at the obtained results, we can see that there are a lot of "Motorcycle" brands
    As motorcycles are generally considered as more dangerous vehicles while facing collisions.
*/

