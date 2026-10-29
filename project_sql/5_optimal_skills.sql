WITH skill_demand AS(
    SELECT 
        skills_dim.skills,
        skills_dim.skill_id,
        count(skills_job_dim.job_id) as demand_skill
    FROM job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE job_title_short='Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home=TRUE
    GROUP BY 
        skills_dim.skill_id
),  top_paying_skills AS(
    SELECT 
        skills_job_dim.skill_id,
        round(avg(salary_year_avg),2) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE job_title_short='Data Analyst' AND
    job_work_from_home=TRUE AND
    salary_year_avg IS NOT NULL
    GROUP BY 
        skills_job_dim.skill_id
)

SELECT 
    skill_demand.skill_id,
    skill_demand.skills,
    demand_skill,
    avg_salary
FROM skill_demand
INNER JOIN top_paying_skills on skill_demand.skill_id=top_paying_skills.skill_id
WHERE demand_skill>10
ORDER BY
    avg_salary DESC,
    demand_skill DESC
LIMIT 30;