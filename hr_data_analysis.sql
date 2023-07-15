##### HR DATA ANALYSIS #####
SET sql_mode = 'ALLOW_INVALID_DATES';

-- 1. What is the gender breakdown of employees in the company?
# Seeing how many distinct genders are listed
SELECT DISTINCT(gender) FROM hr; 

# Selecting the genders of all people who are 18+ and are currently working at company
SELECT gender, count(*) AS gender_count FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of employees in the company? 
SELECT COUNT(DISTINCT(race)) FROM hr;
# Selecting races of all people who are 18+ and currently working at the company
SELECT race, count(race) AS race_count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY race;

-- 3. What is the age distribution of employees in the company?
SELECT 
	CASE
		WHEN age BETWEEN 18 AND 24 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
		WHEN age BETWEEN 35 AND 44 THEN '35-44'
		WHEN age BETWEEN 45 AND 54 THEN '45-54'
		WHEN age BETWEEN 55 AND 64 THEN '55-64'
	ELSE '65+'
END AS age_group,
count(*) AS age_count, gender
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- 4. How many employees work at headquarters versus remote locations?
SELECT location, count(*) AS location_count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location;
 
-- 5. What is the average length of employment for employees who have been terminated?
SELECT round(avg(datediff(termdate, hire_date))/365,0) AS avg_length_employment
FROM hr
WHERE termdate <= curdate() AND age >= 18 AND termdate != '0000-00-00';

-- 6. How does the gender distribution vary across departments and job titles?
SELECT department, gender, count(*) AS count # Checking by department
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department;

SELECT jobtitle, gender, count(*) AS count # Checking by jobtitle
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle, gender
ORDER BY jobtitle;

-- 7. What is the distribution of job titles across the company?
SELECT jobtitle, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC; 

-- 8. Which department has the highest turnover rate?
SELECT department,
	total_count,
	terminated_count,
	terminated_count/total_count AS termination_rate
FROM (
	SELECT department, 
	COUNT(*) AS total_count,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count  #Finding total terminated count; if they were terminated = 1
    FROM hr
    WHERE age >= 18
    GROUP BY department
    ) AS subquery
    ORDER BY termination_rate DESC;
    
-- 9. What is the distribution of employees across locations by city and state?
SELECT location_city, location_state, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_city, location_state
ORDER BY location_state;

SELECT location_state, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY count DESC;

-- 10. How has the company’s employee count changed over time based on hire and term dates?
SELECT 
	year,
    hires,
    terminations,
    hires-terminations AS net_change,
    round((hires-terminations)/hires*100,2) AS net_change_percent
FROM (
	SELECT YEAR(hire_date) AS year,
    COUNT(*) AS hires,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
    FROM hr
    WHERE age >= 18
    GROUP BY YEAR(hire_date)
) AS subquery 
ORDER BY year;

-- 11. What is the tenure distribution for each department? 
SELECT department, round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
FROM hr
WHERE termdate <= curdate() AND age >= 18 AND termdate <> '0000-00-00'
GROUP BY department;