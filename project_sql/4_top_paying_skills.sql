/*
Question: What are the top skills based on salary for Data Analysts?
- Focus on the average salary for each skill 
- Focus on roles with specified salaries (No NULL)
- Focus on all postings, not only remote jobs
*/

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