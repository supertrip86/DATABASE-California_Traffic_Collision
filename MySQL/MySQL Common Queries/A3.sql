/*
	3.	Create a table to show the pedestrian action when the parties were crossing the road, 
    and its relation to party race, to measure how many deaths caused by each action and ethnicity.
*/

SELECT
    c.pedestrian_action AS Pedestrian_Action,
    p.party_race AS Party_Race,
    COUNT(c.pedestrian_action) AS Action_Count,
    SUM(c.killed_victims) AS Death_Count,
    (SUM(c.killed_victims) / COUNT(c.pedestrian_action)) * 100 AS Percentage
FROM
    collisions AS c
        JOIN
    parties AS p ON c.case_id = p.case_id
WHERE
    c.pedestrian_action LIKE 'cross%'
        AND c.pedestrian_action IS NOT NULL
        AND p.party_race IS NOT NULL
GROUP BY c.pedestrian_action , p.party_race
ORDER BY Percentage DESC;

/*
    Comment: We notice that “crossing not in crosswalk” ended up with higher chance of getting killed 
    on the street, with having “white” and “Asian” ethnicity as the top highest percentages.
    
    Comment: We notice that even though on Fridays we had more collisions than other days, 
    but the collisions happened on weekend (Saturdays and Sundays) lead to more death counts.
    
    9s
*/

