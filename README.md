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
Answer the following using [fivetran docs](https://fivetran.com/docs/getting-started), [knowledge base](https://fivetran.com/docs/getting-started), and [internet searches](http://letmegooglethat.com/?q=Internet+searches). Respond to teach as if you were responding to a customer through a ticketing system.

1. “My company is looking to add a Postgres connector. We are unsure if we should choose WAL or XMIN replication. What is your suggestion?”
    <pre><code>
    Hi John Doe,
    <br>
    In most scenarios, we recommend the WAL method. You should only consider
    XMIN for updating records when WAL is not available.
    <br>
    Currently, you can use WAL method with either pgoutput or test_decode plugins.
    You can see which plugins are supported for your Postgres instance here:
    https://fivetran.com/docs/databases/postgresql#supportedservices.
    <br>
    Read more about WAL logical replciation and XMIN here:
    https://fivetran.com/docs/databases/postgresql#updatingdata
    <br>
    Please reach out if you have further questions. I'm happy to help.
    <br>
    Best Regards,
    Zaw Mai
    </code></pre>
2. “I’ve added a new Salesforce field, but I don’t see it listed in the schema tab. Can you investigate why?”
    <pre><code>
    Hi John Doe,
    <br>
    This can be caused one or more of the following:
    <br>
    1. Make sure fivetran has the right access permission for objects in Saleforce.
    2. Review the synced field is not a formula or compound field types.
    3. Review the table/field name from saleforce matches table/field name in fivetran.
    4. Make sure there are no duplciate column fields or table with the same name.
    <br>
    Read more about syncing Salesforce fields here:
    https://support.fivetran.com/hc/en-us/articles/360052347794
    <br>
    Please note you can sync formula fields but there's no gurantee of accurate
    udpate because formula fields don't update when the source formula changes.
    Read more here: https://fivetran.com/docs/applications/salesforce/formula
    <br>
    Please reach out if you have further questions. I'm happy to help.
    <br>
    Best Regards,
    Zaw Mai
    </code></pre>
3. “What ETL/ELT steps does Fivetran take to move my data from my source database to my destination warehouse?”
    <pre><code>
    Hi John Doe,
    <br>
    Here's general steps overview of our ETL/ELT process of moving the source data
    to the destination warehouse.
    <br>
    1.  Fivetran secures an encrypted connection to the one or more source
        databases by using a pull or push connectors. Read more about connectors
        here: https://support.fivetran.com/hc/en-us/articles/1500003152601#connect
    <br>
    2.  Then, our core engine normalizes, cleans, and de-duplicates the data
        records to provide a optimal data format for the destination warehouse.
    <br>
    3.  Next, the formatted data is written to a temporary data store, waiting
        to be processed within 24 hours.
    <br>
    4.  Finally, Fivetran encrypts and writes the data to the destination data
        warehouse chunk by chunks. A success or a failed status will be sent via
        email or you can check on the fivetran dashboard.
    <br>
    Read more about Fivetran's ETL/ELT high-level process overview here:
    https://fivetran.com/docs/getting-started/architecture
    <br>
    Each data source and destinatation warehouse requires application-specific
    prequisites before Fivetran can start syncing, replicating, and updating data.
    Read more about setting up your source and destination applications here:
    https://fivetran.com/docs/applications
    <br>
    Please reach out if you have further questions. I'm happy to help.
    <br>
    Best Regards,
    Zaw Mai
    </code></pre>

## Troubleshooting

### Challenge 1 - Logs / Monitoring

You are tasked to analyze the following log file.

<pre>
1&nbsp;&nbsp;2018-10-11&nbsp;&nbsp;200&nbsp;&nbsp;192.168.11.1&nbsp;&nbsp;test
2&nbsp;&nbsp;2019-10-04&nbsp;&nbsp;201&nbsp;&nbsp;192.168.11.1&nbsp;&nbsp;test
4&nbsp;&nbsp;2018-08-11&nbsp;&nbsp;302&nbsp;&nbsp;212.168.11.1&nbsp;&nbsp;stage
7&nbsp;&nbsp;2019-02-11&nbsp;&nbsp;400&nbsp;&nbsp;192.168.11.1&nbsp;&nbsp;ci
10&nbsp;&nbsp;2017-10-11&nbsp;&nbsp;403&nbsp;&nbsp;192.167.11.1&nbsp;&nbsp;prod
11&nbsp;&nbsp;2019-10-11&nbsp;&nbsp;500&nbsp;&nbsp;192.168.1.1&nbsp;&nbsp;test
</pre>

Using any method you like. Write the specific step by step instructions to execute the following tasks:

- Extract all IP addresses into a single column.
- Count unique IP addresses

Used bash scripts in Ubuntu 20.04 linux distro to solve it.
<pre><code>
#!/bin/bash

# extract all IP Addresses into a single column
awk '{print $4}' log.txt

# count unique IP addresses
awk '{print $4}' log.txt | uniq -u | wc -l
</code></pre>

### Challenge 2 - API GET

API GET challenge, have the candidate provide us with the results of a GET request.

1. Sign up for a free Airtable account: [https://airtable.com/](https://airtable.com/)
2. Navigate to the Airtable API documentation: [https://airtable.com/api](https://airtable.com/api)
3. Provide a working API call to pull all names from the project tracker table using curl headers for authentication.

### Challenge 3 - Networking

## Communications

### Challenge 1

### Challenge 2