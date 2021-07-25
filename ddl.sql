DROP TABLE EmployeeDetails;
DROP TABLE EmployeeSalary;
DROP TABLE ManagerDetails;

Create TABLE ManagerDetails (
    MANAGER_ID INT PRIMARY KEY,
    "NAME" VARCHAR(50),
    DIRECT_REPORTS INT,
    ANNUAL_BUDGET INT  
);
INSERT INTO ManagerDetails VALUES (203, 'Ned Stark', 1, 100000);
INSERT INTO ManagerDetails VALUES (202, 'Walter White', 1, 100000);
INSERT INTO ManagerDetails VALUES (201, 'Leia Organa', 3, 200000); 

CREATE TABLE EmployeeSalary (
    EMP_ID INT PRIMARY KEY,
    PROJECT VARCHAR(2),
    SALARY INT,
    BONUS INT
); 
INSERT INTO EmployeeSalary VALUES (101, 'P1', 8000, 500);
INSERT INTO EmployeeSalary VALUES (102, 'P2', 10000, 1000);
INSERT INTO EmployeeSalary VALUES (103, 'P3', 12000, 0);
INSERT INTO EmployeeSalary VALUES (104, 'P1', 20000, 2000);
INSERT INTO EmployeeSalary VALUES (105, 'P2', 15000, 1000);
INSERT INTO EmployeeSalary VALUES (106, 'P0', 25000, 3000);

CREATE TABLE EmployeeDetails (
    EMP_ID INT PRIMARY KEY,
    FULL_NAME VARCHAR(50),
    MANAGER_ID INT,
    JOIN_DATE DATE,
    TEAM VARCHAR(10),
    FOREIGN KEY(MANAGER_ID) REFERENCES ManagerDetails(MANAGER_ID) ON DELETE SET NULL
);
INSERT INTO EmployeeDetails VALUES (101, 'John Snow', 203, '1/31/2019', 'AMER');
INSERT INTO EmployeeDetails VALUES (102, 'Jesse Pinkman', 202, '1/30/2020', 'EMEA');
INSERT INTO EmployeeDetails VALUES (103, 'Luke Skywalker', 201, '11/27/2018', 'APAC');
INSERT INTO EmployeeDetails VALUES (104, 'Ned Stark', 201, '7/10/2016', 'EMEA');
INSERT INTO EmployeeDetails VALUES (105, 'Walter White', 201, '8/24/2017', 'APAC');
INSERT INTO EmployeeDetails VALUES (106, 'Leia Organa', NULL, '7/15/2015', 'AMER');