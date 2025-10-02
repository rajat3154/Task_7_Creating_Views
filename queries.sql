CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    Age INT,
    DepartmentID INT
);


CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);


CREATE TABLE ExamResults (
    ResultID INT PRIMARY KEY,
    StudentID INT,
    SubjectName VARCHAR(50),
    MarksObtained INT
);


INSERT INTO Departments VALUES 
(1, 'Computer Science'), 
(2, 'Electronics');


INSERT INTO Students VALUES 
(101, 'Alice', 20, 1),
(102, 'Bob', 21, 1),
(103, 'Charlie', 22, 2);


INSERT INTO ExamResults VALUES
(1, 101, 'DBMS', 85),
(2, 102, 'DBMS', 75),
(3, 103, 'DBMS', 65);


CREATE VIEW StudentNames AS
SELECT student_id, name 
FROM Students;

SELECT * FROM StudentNames;

CREATE VIEW StudentDepartment AS
SELECT s.name, d.department_name
FROM Students s
JOIN Departments d ON s.department_id = d.department_id;

SELECT * FROM StudentDepartment;

CREATE VIEW HighScorers AS
SELECT s.name, r.subject, r.marks
FROM Students s
JOIN Results r ON s.student_id = r.student_id
WHERE r.marks > 80;

SELECT * FROM HighScorers;

DROP VIEW HighScorers;

CREATE VIEW CS_Students AS
SELECT * FROM Students
WHERE department_id = 1
WITH CHECK OPTION;

CREATE VIEW StudentPerformance AS
SELECT s.name,
       r.subject,
       r.marks,
       CASE 
         WHEN r.marks >= 80 THEN 'Excellent'
         WHEN r.marks BETWEEN 60 AND 79 THEN 'Average'
         ELSE 'Needs Improvement'
       END AS performance_status
FROM Students s
JOIN Results r ON s.student_id = r.student_id;

CREATE VIEW AvgMarksByDept AS
SELECT d.department_name, 
       AVG(r.marks) AS avg_marks
FROM Students s
JOIN Results r ON s.student_id = r.student_id
JOIN Departments d ON s.department_id = d.department_id
GROUP BY d.department_name;

CREATE VIEW CS_Students AS
SELECT s.student_id, s.name, d.department_name
FROM Students s
JOIN Departments d ON s.department_id = d.department_id
WHERE d.department_name = 'Computer Science';
