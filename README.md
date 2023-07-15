# HR-Employee Information Dashboard

# Data Used
Dataset - HR data of employees with over 22,000 rows from 2000-2020
Data cleaning & analysis - MySQL Workbench
Data visualization - PowerBI

# Questions
1. What is the gender breakdown of employees in the company?
2. What is the race/ethnicity breakdown of employees in the company?
3. What is the age distribution of employees in the company?
4. How many employees work at headquarters versus remote locations?
5. What is the average length of employment for employees who have been terminated?
6. How does the gender distribution vary across departments and job titles?
7. What is the distribution of job titles across the company?
8. Which department has the highest turnover rate?
9. What is the distribution of employees across locations by city and state?
10. How has the company’s employee count changed over time based on hire and term dates?
11. What is the tenure distribution for each department?

# Summary of Findings
1. Males make up the majority of the employees.
2. The race that is most dominant is White and the race that is least dominant is Native American and American Indian.
3. The youngest employee is 20 years old and the oldest employee is 57 years old.
4. Five age groups were created (18-24, 25-34, 35-44, 45-54, 55-64). A large number of employees were between the ages of 24-35, followed by 35-44. The smallest group was 55-64.
5. The majority of employees work at headquarters verus remotely.
6. The average length of employment for those who have been terminated is around 8 years.
7. The gender distribution is quite balanced throughout all the departments, but there are generally more male than female employees.
8. The Marketing department has the highest turnover rate, followed by Training. The Research and Development, Support, and Legal departments all have the lowest turnover rate.
9. The majority of employees come from the state of Ohio.
10. The net change in employees at this company has increased over time.
11. The average tenure for each department is about 8 years with Legal and Auditing having the highest, and Service, Sales, and Marketing having the lowest.

# Data Limitations
1. Some of the ages in the dataset were negative values (967 records). Therefore, these corresponding records were not used when querying. The queries used for analysis filtered the ages for only employees aged 18 and older.
2. Some of the term dates were far into the future and were not used for analysis (1562 records). The only term dates used were those less than or equal to the current date.
