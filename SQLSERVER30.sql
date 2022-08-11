CREATE TABLE EmployeeInfo( 
EmpID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  EmpFname VARCHAR(50),
  EmpLname VARCHAR(50),
  Department VARCHAR(50),
  Project VARCHAR(50),
  Address VARCHAR(50),
  DOB DATE,
  Gender VARCHAR(5)

);
INSERT INTO EmployeeInfo (EmpFname, EmpLname, Department, Project, Address, DOB, Gender) VALUES
('Sanjay', 'Mehra', 'HR', 'P1', 'Hyderabad(HYD)', '01/12/1976', 'M'),
('Ananya', 'Mishra', 'Admin', 'P2', 'Delhi(DEL)', '02/05/1968', 'F'),
('Rohan', 'Diwan', 'Account', 'P2', 'Mumbai(BOM)', '01/01/1980', 'M'),
('Sonia', 'Kulkarni', 'HR', 'P1', 'Hyderabad(HYD)', '02/05/1992', 'F'),
('Ankit', 'Kapoor', 'Admin', 'P2', 'Delhi(DEL)', '03/07/1994', 'M');

CREATE TABLE EmployeePosition ( 
EmpID INT NOT NULL PRIMARY KEY,
  EmpPosition VARCHAR(50),
  DateOfJoining DATE,
  Salary MONEY
);


INSERT INTO EmployeePosition (EmpID, EmpPosition, DateOfJoining, Salary) VALUES
('1', 'Manager', '01/05/2022', '500000'),
('2', 'Executive', '02/05/2022', '75000'),
('3', 'Manager', '01/05/2022', '90000'),
('4', 'Lead', '02/05/2022', '85000'),
('5', 'Executive', '01/05/2022', '300000');

SELECT * FROM EmployeeInfo
SELECT * FROM EmployeePosition

--Write a query to fetch the EmpFname from the EmployeeInfo table in the upper case and use the ALIAS name as EmpName.
SELECT UPPER(EmpFname) AS EmpName FROM EmployeeInfo

--Write a query to fetch the number of employees working in the department ‘HR’.
SELECT COUNT(*) FROM EmployeeInfo WHERE Department = 'HR'

--Write a query to get the current date.
SELECT GETDATE()

--Write a query to retrieve the first four characters of  EmpLname from the EmployeeInfo table.
SELECT SUBSTRING(EmpLname, 1,4)FROM EmployeeInfo

--Write a query to fetch only the place name(string before brackets) from the Address column of EmployeeInfo table.
SELECT SUBSTRING(Address, 1, CHARINDEX('(',Address)) FROM EmployeeInfo;

--Write a query to create a new table that consists of data and structure copied from the other table.
SELECT * INTO NewTable FROM EmployeeInfo WHERE 1=0
SELECT * FROM NewTable

--Write q query to find all the employees whose salary is between 50000 to 100000.
SELECT * FROM EmployeeInfo AS A JOIN EmployeePosition AS B ON A.EmpID=B.EmpID
WHERE Salary BETWEEN 50000 AND 100000

--Write a query to find the names of employees that begin with ‘S’
SELECT * FROM EmployeeInfo WHERE EmpFname LIKE 'S%'

--Write a query to fetch top N records.
SELECT TOP 5 * FROM EmployeePosition ORDER BY Salary DESC

--Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. The first name and the last name must be separated with space
SELECT CONCAT(EmpFname, ' ', EmpLname) AS FullName FROM EmployeeInfo

--Q11. Write a query find number of employees whose DOB is between 02/05/1970 to 31/12/1979 and are grouped according to gender
SELECT COUNT(*), Gender FROM EmployeeInfo WHERE DOB BETWEEN '1970-05-02' AND '1999-12-31' GROUP BY Gender;

--Q12. Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order and Department in the ascending order.
SELECT * FROM EmployeeInfo ORDER BY EmpLname DESC, Department ASC

--Q13. Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets.
SELECT * FROM EmployeeInfo WHERE EmpLname LIKE '____a'

--Q14. Write a query to fetch details of all employees excluding the employees with first names, “Sanjay” and “Sonia” from the EmployeeInfo table

SELECT * FROM EmployeeInfo WHERE EmpFname NOT IN ('Sanjay','Sonia')

--Q15. Write a query to fetch details of employees with the address as “DELHI(DEL)”.

SELECT * FROM EmployeeInfo WHERE Address IN  ('DELHI(DEL)')
-- or
SELECT * FROM EmployeeInfo WHERE Address LIKE 'DELHI(DEL)%';

--Q16. Write a query to fetch all employees who also hold the managerial position.

SELECT E.EmpFname, E.EmpLname, P.EmpPosition 
FROM EmployeeInfo E INNER JOIN EmployeePosition P ON
E.EmpID = P.EmpID WHERE P.EmpPosition IN ('Manager')

--Q17. Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order.

SELECT Department, count(EmpID) AS EmpDeptCount 
FROM EmployeeInfo GROUP BY Department 
ORDER BY EmpDeptCount ASC;

--Q18. Write a query to calculate the even and odd records from a table.

--fOR ODD RECORDS
SELECT a.EmpID, a.EmpFname FROM (SELECT ROW_NUMBER() OVER (ORDER BY EmpID) AS rowno, EmpFname, EmpID from EmployeeInfo) a WHERE a.rowno % 2=0
--EVEN RECORDS
SELECT a.EmpID, a.EmpFname FROM (SELECT ROW_NUMBER() OVER (ORDER BY EmpID) AS rowno, EmpFname, EmpID from EmployeeInfo) a WHERE a.rowno % 2=1

--Q19. Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining in the EmployeePosition table.

SELECT * FROM EmployeeInfo E
WHERE EXISTS 
(SELECT * FROM EmployeePosition P WHERE E.EmpId = P.EmpId);

SELECT * FROM EmployeeInfo E
JOIN EmployeePosition P on E.EmpID = P.EmpID
WHERE EXISTS (SELECT DateOfJoining FROM EmployeePosition)

--Q20. Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table.
--BOTTOM 2
SELECT DISTINCT Salary FROM EmployeePosition E1 
 WHERE 2 >= (SELECT COUNT(DISTINCT Salary)FROM EmployeePosition E2 
  WHERE E1.Salary >= E2.Salary) ORDER BY E1.Salary DESC;
--TOP 2
  SELECT DISTINCT Salary FROM EmployeePosition E1 
 WHERE 2 >= (SELECT COUNT(DISTINCT Salary) FROM EmployeePosition E2 
  WHERE E1.Salary <= E2.Salary) ORDER BY E1.Salary DESC;

--Q21. Write a query to find the Nth highest salary from the table without using TOP/limit keyword.

SELECT Salary 
FROM EmployeePosition E1 
WHERE 3-1 = ( 
      SELECT COUNT( DISTINCT ( E2.Salary ) ) 
      FROM EmployeePosition E2 
      WHERE E2.Salary >  E1.Salary );

--Q22. Write a query to retrieve duplicate records from a table.

SELECT EmpID, EmpFname, Department, COUNT (*) 
FROM EmployeeInfo GROUP BY EmpID, EmpFname, Department 
HAVING COUNT(*) > 1;

--Q23. Write a query to retrieve the list of employees working in the same department.

select * from EmployeeInfo

Select DISTINCT E.EmpID, E.EmpFname, E.Department 
FROM EmployeeInfo E, EmployeeInfo E1 
WHERE E.Department = E1.Department AND E.EmpID != E1.EmpID;

--Q24. Write a query to retrieve the last 3 records from the EmployeeInfo table.

SELECT * FROM EmployeeInfo WHERE
EmpID <=3 
UNION 
SELECT * FROM
(SELECT * FROM EmployeeInfo E ORDER BY E.EmpID DESC) 
AS E1 WHERE E1.EmpID <=3;

--Q25. Write a query to find the third-highest salary from the EmpPosition table.

SELECT TOP 1 salary
FROM(
SELECT TOP 3 salary
FROM EmployeePosition
ORDER BY salary DESC) AS emp
ORDER BY salary ASC;

--Q26. Write a query to display the first and the last record from the EmployeeInfo table.
--First record
SELECT * FROM EmployeeInfo WHERE EmpID = (SELECT MIN(EmpID) FROM EmployeeInfo);

--Last record
SELECT * FROM EmployeeInfo WHERE EmpID = (SELECT MAX(EmpID) FROM EmployeeInfo);

--Q28. Write a query to retrieve Departments who have less than 2 employees working in it.

SELECT DEPARTMENT, COUNT(EmpID) as 'EmpNo' FROM EmployeeInfo GROUP BY DEPARTMENT HAVING COUNT(EmpID) < 2;

--Q29. Write a query to retrieve EmpPostion along with total salaries paid for each of them.

SELECT EmpPosition, SUM(Salary) from EmployeePosition GROUP BY EmpPosition;

--Q30. Write a query to fetch 50% records from the EmployeeInfo table.

SELECT * 
FROM EmployeeInfo WHERE
EmpID <= (SELECT COUNT(EmpID)/2 from EmployeeInfo);
