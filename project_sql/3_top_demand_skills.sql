SELECT 
    skills,
    count(skills_job_dim.job_id) as demand_skill
FROM job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short='Data Analyst' AND
job_schedule_type='Full-time'
GROUP BY 
    skills
ORDER BY
    demand_skill DESC
limit 5
