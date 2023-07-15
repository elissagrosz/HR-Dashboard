# Creating database 
CREATE DATABASE portfolioproject2;
SELECT count(*)
FROM hr;

# Changing column name and datatype for employee id
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

# Reveal data types of all columns in hr table
DESCRIBE hr;

# Changing 'birthdate' data type to date using string to date function
SELECT birthdate FROM hr;
SET SQL_SAFE_UPDATES = 0;
UPDATE hr
SET birthdate = CASE  
	WHEN birthdate LIKE '%/%' THEN date_format(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d') ## Orange is current birthdate format
	WHEN birthdate LIKE '%-%' THEN date_format(STR_TO_DATE(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;
SET SQL_SAFE_UPDATES = 1;

# Changing actual data type of 'birthdate' column from text to date
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

# Changing 'hiredate' data type to date using string to date function
SET SQL_SAFE_UPDATES = 0;
UPDATE hr
SET hire_date = CASE  
	WHEN hire_date LIKE '%/%' THEN date_format(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d') ## Orange is current birthdate format
	WHEN hire_date LIKE '%-%' THEN date_format(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;
# Actually changing data type to date 
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

# Termdate is in the correct format, but we don't need the time info
# AND we still need to change it to date data type where it's NOT NULL 
SET sql_mode = 'ALLOW_INVALID_DATES';

UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != ' ',
	date(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
 WHERE true;
 
 SELECT termdate FROM hr;
# Changing actual data type from text to date
 ALTER TABLE hr
 MODIFY COLUMN termdate DATE;

# Adding age column
ALTER TABLE hr ADD COLUMN age INT;
# Add age calculation
UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT age, birthdate FROM hr;
# Check youngest and oldest
SELECT 
	MIN(age) AS youngest, MAX(age) AS oldest
FROM hr;
# Getting negative ages due to incorrect birth dates, so check for values in age column less than 0
SELECT COUNT(*) FROM hr WHERE age < 18;
SELECT age FROM hr WHERE age <0;