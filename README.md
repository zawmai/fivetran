# Interview Assignment for FiveTran: Technical Support Engineer

Database and tables were created in <b>Postgres SQL</b> for testing purposes.

## DDL Create Tables

## DML Query Challenges

1. You are approached by your boss and he asks you to provide him a list of all the employees who report to Walter White.  Please provide the SQL query you would use to display this information.
    <pre><code>
    SELECT
      e.emp_id,
      e.full_name,
      e.manager_id,
      e.join_date,
      e.team
    FROM
      employeedetails as e
      LEFT OUTER JOIN managerdetails as m
      ON (e.manager_id = m.manager_id)
    WHERE
      m.name = 'Walter White';
    </code></pre>
2. Write an SQL query to add Thomas Anderson with the Employee ID of 131 to the EmployeeDetails table.  He joined the Oakland team on April 1, 2020, and his manager’s name is Ned Stark.
    <pre><code>
    INSERT INTO employeedetails
    VALUES (
        131,
        'Thomas Anderson',
        NULL,
        '4/1/2020',
        'Oakland'
    );
    <br>
    UPDATE employeedetails
    SET manager_id = (
        SELECT m.manager_id
        FROM managerdetails as m
        WHERE m.name = 'Ned Stark'
        LIMIT 1
    )
    WHERE emp_id = 131;
    </code></pre>
3. Write a single query to display all employee names and manager names.
    <pre><code>
    SELECT e.full_name as employee_name, m.name as manager_name
    FROM 
        employeedetails as e
        LEFT OUTER JOIN managerdetails as m
        ON (e.manager_id = m.manager_id);
    </code></pre>
4. Write a SQL query to calculate the average salary for all employees where the manager is Leia Organa.
    <pre><code>
    SELECT AVG(s.salary) as Average_Salary_For_Employees_Under_Leia_Organa
    FROM 
        employeedetails as e
        INNER JOIN managerdetails as m
        ON (e.manager_id = m.manager_id)
        INNER JOIN employeesalary as s
        ON (e.emp_id = s.emp_id)
    WHERE m.name = 'Leia Organa';
    </code></pre>
5. Write a SQL query to calculate the median total compensation per region where bonuses are always part of the compensation package 
    <pre><code>
    SELECT 
      e.team, 
      percentile_cont(0.5) WITHIN GROUP 
      (ORDER BY (s.salary + s.bonus)) as median_total_compensation
    FROM 
        employeedetails as e
        INNER JOIN employeesalary as s
        ON (e.emp_id = s.emp_id)
    GROUP BY e.team;
    </code></pre>
6. Write a SQL query to show the percentage of Leia Organa’s annual budget that is used for employee compensation.
<b>Note:</b> I assumed Leia Organa's compensation is not included in her annual budget.
    <pre><code>
    SELECT 
      SUM(1.0*(COALESCE(s.salary,0) + COALESCE(s.bonus, 0))/m.annual_budget)
    FROM
        employeedetails as e
        LEFT OUTER JOIN managerdetails as m
        ON (e.manager_id = m.manager_id)
        INNER JOIN employeesalary as s
        ON (e.emp_id = s.emp_id)
    WHERE m.name = 'Leia Organa';
    </code></pre>

## Database Architecture

## Troubleshooting

### Challenge 1 - Logs / Monitoring

### Challenge 2 - API GET

### Challenge 3 - Networking

## Communications

### Challenge 1

### Challenge 2