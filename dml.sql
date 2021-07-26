/* Challenge 1 */
SELECT 
    e.emp_id,
    e.full_name,
    e.manager_id,
    e.join_date,
    e.team
FROM 
    employeedetails as e
    INNER JOIN managerdetails as m
    ON (e.manager_id = m.manager_id)
WHERE 
    m.name = 'Walter White';

/* Challenge 2 */
INSERT INTO employeedetails
VALUES (
    131,
    'Thomas Anderson',
    NULL,
    '4/1/2020',
    'Oakland'
);
UPDATE employeedetails
SET manager_id = (
    SELECT m.manager_id
    FROM managerdetails as m
    WHERE m.name = 'Ned Stark'
    LIMIT 1
)
WHERE emp_id = 131;

/* Challenge 3 */
SELECT e.full_name as employee_name, m.name as manager_name
FROM 
    employeedetails as e
    INNER JOIN managerdetails as m
    ON (e.manager_id = m.manager_id);

/* Challenge 4 */
SELECT AVG(s.salary) as Average_Salary_For_Employees_Under_Leia_Organa
FROM 
    employeedetails as e
    INNER JOIN managerdetails as m
    ON (e.manager_id = m.manager_id)
    INNER JOIN employeesalary as s
    ON (e.emp_id = s.emp_id)
WHERE m.name = 'Leia Organa';

/* Challenge 5 */
SELECT 
    e.team, 
    percentile_cont(0.5) WITHIN GROUP 
    (ORDER BY (COALESCE(s.salary,0) + COALESCE(s.bonus, 0))) as median_total_compensation
FROM 
    employeedetails as e
    INNER JOIN employeesalary as s
    ON (e.emp_id = s.emp_id)
GROUP BY e.team;

/* Challenge 6 */
SELECT 
    SUM(1.0*(COALESCE(s.salary,0) + COALESCE(s.bonus, 0))/m.annual_budget)
FROM
    employeedetails as e
    LEFT OUTER JOIN managerdetails as m
    ON (e.manager_id = m.manager_id)
    INNER JOIN employeesalary as s
    ON (e.emp_id = s.emp_id)
WHERE m.name = 'Leia Organa';