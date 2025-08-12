/*
Question: What is the most optimal skill for Data Analysts to learn? (High demand, High salary)
- Focus on skills in high demand and high average salaries for Data Analysts
- Focus on roles with specified salaries (No NULL)
- Focus on all postings, not only remote jobs
*/

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