# Introduction
Focusing on Data Analyst roles, this project explores top paying jobs, in demand skills and where highly demanded skills meets high salary in the field of data analytics

SQL Queries: [project_sql folder](/project_sql/)

# Questions I wanted to answer
1. What are the top paying data analyst jobs?

2. What skills are required for these jobs?

3. What skills are most in demand for data analyst jobs?

4. Which skills are associated with higher salaries?

5. What are the most optimal (High demand AND High salary) skills to learn?

# Tools I Used
- **SQL:** Built the whole project and answered all the questions with this with the queries and data handling
- **PostgreSQL:** The chosen database handling system
- **Visual Studio Code:** The chosen software for executing queries
- **Git & Github:** Allows me to track my projects and share the code


#  The Analysis
1. What are the top paying data analyst jobs?
```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10
```
2. What skills are required for these jobs?
```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY 
    salary_year_avg DESC
```
3. What skills are most in demand for data analyst jobs?
```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
GROUP BY 
    skills
ORDER BY 
    demand_count DESC
LIMIT 5
```
4. Which skills are associated with higher salaries?
```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 20
```
5. What are the most optimal (High demand AND High salary) skills to learn?
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 20
```
# What I learned
- **Writing queries and troubleshooting them:** As I was new to SQL and had only learnt the basic syntax, this project allowed me to apply and execute the syntaxes learnt.

- **Data Aggregation:** Dealing with a real dataset had also allowed me to understand the importance of data cleaning, and only work with the data I need.

- **Analysis skills:** This project also allowed me to work on my analysis skills, and really understand what kind of story the data is trying to tell.

# Conclusions
### Insights
1. **Top Paying Data Analyst Jobs:** The highest paying salaries can go up to $650,000.

2. **Skills for Top Paying Jobs:** High paying analyst jobs basically all require proficiency in SQL.

3. **Most In Demand Skill:** Coincidentally, the most in demand skill for data analysts also turns out to be SQL.

4. **Skills with Higher salaries:** Niche skills such as SW and Solidarity result in higher salaries compared to the other skills.

5. **Optimal Skills:** SQL takes the lead once again, indicating that it is one of the most important and optimal skills to learn if wishing to pursue a job as a Data Dnalyst.

### Closing thoughts
I had a lot of fun working on this project, and it was extremely insightful since it allowed me to learn more about the job I wish to pursue. It also enhanced my SQL skills as I had 0 knowledge prior to this project. I hope that the skills I've learnt from this project will allow me to learn more and better my future projects

### Extra notes
Credits to [Luke Barousse](https://www.youtube.com/@LukeBarousse) on Youtube for teaching me the SQL basics, as well as walking me through this project. I could not have learnt the skills and finished this project without him```