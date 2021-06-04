/*
	4.	IMPROVED VERSION - As we have noticed in the 4th query, we had to use "CASE" in order to deal with 
    "alcohol_involved" column, using the code below, we can update our table to set 0 in "alcohol_involved" 
    column whenever the value is NULL, therefore, we can improve performance and speed up the query.
*/


/*
	Note: We also use OVER clause, that in our case is an empty OVER clause; 
    this means the window of records is the complete set of records returned by the query.
    In other words, it'll accumulate the total records, therefore we can avoid using the 
    nested query to calculate the percentages.
*/

SELECT
    alcohol_involved_Binary AS Alcohol_Involved,
    COUNT(alcohol_involved_Binary) AS Cases_Count,
    COUNT(alcohol_involved_Binary) / SUM(COUNT(alcohol_involved_Binary)) OVER () * 100 AS Alcohol_Involved_Percentage,
    SUM(killed_victims) AS Death,
    SUM(killed_victims) / SUM(SUM(killed_victims)) OVER () * 100 AS Death_Percentage,
    SUM(injured_victims) AS Injured,
    SUM(injured_victims) / SUM(SUM(injured_victims)) OVER () * 100 AS Injured_Percentage
FROM
    collisions
GROUP BY Alcohol_Involved;


/*
	ALTER TABLE collisions ADD alcohol_involved_Binary BIT;
	------------------------------------------
	UPDATE collisions
	SET alcohol_involved_Binary = 0
	WHERE alcohol_involved IS NULL;
    ------------------------------------------
	UPDATE collisions
	SET alcohol_involved_Binary = 1
	WHERE alcohol_involved IS NOT NULL;
    
    21s
*/

