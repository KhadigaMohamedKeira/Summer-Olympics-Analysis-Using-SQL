--Inspecting for blank rows
SELECT COUNT(*) AS noblank,
       COUNT("Year") AS year_noblank,
	   COUNT("City") AS city_noblank,
	   COUNT("Sport") AS sport_noblank,
	   COUNT("Discipline") AS discipline_noblank,
	   COUNT("Athlete") AS athlete_noblank,
	   COUNT("Country") AS country_noblank,
	   COUNT("Gender") AS gender_noblank,
	   COUNT("Event") AS event_noblank,
	   COUNT("Medal") AS medal_noblank
FROM summer;
--No blank rows or columns
--Exploring the summer dataset
SELECT * FROM summer;

--How many medal each athlete won
SELECT "Athlete",
       "Medal",
	   COUNT(*) AS num_medals
FROM summer
GROUP BY 1,2
ORDER BY "Athlete",num_medals DESC;

--Top winner
SELECT "Athlete",
       "Medal",
	   COUNT(*) AS num_medals
FROM summer
GROUP BY 1,2
ORDER BY num_medals DESC;

--running total for medals per each athlete
SELECT "Year","Athlete",
       COUNT(*) OVER(PARTITION BY "Athlete") AS num_medals
FROM summer
ORDER BY "Year" ASC, num_medals DESC;
-- Exploring the summer dataset where discipline is swimming and gender is male
SELECT * FROM summer
WHERE "Discipline" = 'Swimming' AND "Gender" = 'Men';

--Select the distinct years
SELECT DISTINCT "Year" FROM summer
ORDER BY 1 ASC;

--We are interested in rows between 2004 & 2012
SELECT * FROM summer
WHERE "Year"::numeric BETWEEN 2004::numeric AND 2012::numeric;

--Counting gold medals per each athlete
SELECT "Athlete", 
      SUM(gold_medals) AS gold_medals
FROM
(SELECT "Athlete",
CASE WHEN "Medal" = 'Gold' THEN 1
ELSE 0 END gold_medals
FROM summer) AS sub
GROUP BY 1
ORDER BY 2 DESC;
       