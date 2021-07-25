# Interview Assignment for FiveTran: Technical Support Engineer

## Challenges

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
2. Hi

## Database Architecture

## Troubleshooting

### Challenge 1 - Logs / Monitoring

### Challenge 2 - API GET

### Challenge 3 - Networking

## Communications

### Challenge 1

### Challenge 2