/*
	5.	IMPROVED VERSION - Create the table to show the number of people under influence of drugs or 
    alcohol based on their “party_race”, with their respected percentages.
*/

SELECT
    party_race AS Race,
    COUNT(party_sobriety) AS Party_UI_Alcohol_Count,
    COUNT(party_sobriety) * 100 / SUM(COUNT(party_sobriety)) OVER () AS UI_Alcohol_Percentage,
    COUNT(party_drug_physical) AS Party_UI_Drug_Count,
    COUNT(party_drug_physical) * 100 / SUM(COUNT(party_drug_physical)) OVER () AS UI_Drug_Percentage
FROM
    parties
WHERE
	under_influence_ethnicity
GROUP BY Race
ORDER BY COUNT(party_sobriety) DESC;

/*    
    ALTER TABLE parties ADD under_influence_ethnicity BIT;
	--------------------------------------------------------
	UPDATE parties
	SET under_influence_ethnicity = 0
	WHERE party_race IS NULL OR (party_sobriety != 'B' OR party_drug_physical != 'E');
    --------------------------------------------------------
	UPDATE parties
	SET under_influence_ethnicity = 1
    WHERE under_influence = 0 AND (party_race IS NOT NULL AND (party_sobriety = 'B' OR party_drug_physical = 'E'));
    --------------------------------------------------------

    Not only we improve the schema by creating an additional OPTIMIZED (BIT) column containing exactly 
    the information we need (summarizing three columns), but we also get the opportunity of getting rid
    of two nested queries
    
    10.3s
*/

