/*
	5.	Create the table to show the number of people under influence of drugs or 
    alcohol based on their “party_race”, with their respected percentages.
*/

SELECT
    party_race AS Race,
    COUNT(party_sobriety) AS Party_UI_Alcohol_Count,
    COUNT(party_sobriety) / (SELECT 
            COUNT(party_sobriety)
        FROM
            parties
        WHERE
            (party_race IS NOT NULL)
                AND (party_sobriety = 'B'
                OR party_drug_physical = 'E')) * 100 AS UI_Alcohol_Percentage,
    COUNT(party_drug_physical) AS Party_UI_Drug_Count,
    COUNT(party_drug_physical) / (SELECT 
            COUNT(party_drug_physical)
        FROM
            parties
        WHERE
            (party_race IS NOT NULL)
                AND (party_sobriety = 'B'
                OR party_drug_physical = 'E')) * 100 AS UI_Drug_Percentage
FROM
    parties
WHERE
    (party_race IS NOT NULL)
        AND (party_sobriety = 'B'
        OR party_drug_physical = 'E')
GROUP BY Race
ORDER BY COUNT(party_sobriety) DESC;

/*
    Comment: Looking at the retrieved information, we noticed that almost half (46%) 
    of the parties who were under alcohol influence were “Hispanic”, even though over 
    the half of the parties under drugs influence were identified as “White”.
    
    30s
*/

