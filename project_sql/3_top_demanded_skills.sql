/*
Question: What are the most demanded skills for data analyst jobs?
- Use inner join similar to query 2
- Identify the top 5 skills
- Focus on all postings, not only remote jobs
*/

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