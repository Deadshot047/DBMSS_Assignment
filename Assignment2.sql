/* 1. Create a university database that consists of tables such as the schema diagram above
(SQL data definition and tuples of some tables as shown above)
2. Please complete SQL data definition and tuples of some tables others*/

CREATE DATABASE UNIVERSITY;
CREATE TABLE Teaches (
    ID INT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Sec_ID INT NOT NULL,
    Semester VARCHAR(255) NOT NULL,
    Year INT NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Instructor(ID),
    FOREIGN KEY (Sec_ID,Semester,Year) REFERENCES Section(Sec_ID,Semester,Year)
);

CREATE TABLE Section (
    Customer_ID INT NOT NULL,
    Sec_ID INT NOT NULL,
    Semester VARCHAR(255) NOT NULL,
    Year INT NOT NULL,
    Building VARCHAR(255) NOT NULL,
    Room_Number VARCHAR(255) NOT NULL,
    Time_Slot_ID INT NOT NULL,
    PRIMARY KEY (Customer_ID, Sec_ID, Semester, Year),
    FOREIGN KEY (Customer_ID) REFERENCES Instructor(ID)
);

CREATE TABLE Instructor (
    ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Dept_Name VARCHAR(255) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Dept_Name) REFERENCES Department(Dept_Name)
);

CREATE TABLE Department (
    Dept_Name VARCHAR(255) PRIMARY KEY,
    Building VARCHAR(255) NOT NULL,
    Budget DECIMAL(10,2) NOT NULL
);

CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Dept_Name VARCHAR(255) NOT NULL,
    Credits INT NOT NULL,
    FOREIGN KEY (Dept_Name) REFERENCES Department(Dept_Name)
);

CREATE TABLE Student (
    ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Dept_Name VARCHAR(255) NOT NULL,
    Tot_Credit INT NOT NULL,
    FOREIGN KEY (Dept_Name) REFERENCES Department(Dept_Name)
);

INSERT INTO Teaches (ID, Customer_ID, Sec_ID, Semester, Year)
VALUES (1, 1, 101, 'First', 2020),
       (2, 2, 102, 'Second', 2021),
       (3, 3, 103, 'Third', 2022),
       (4, 4, 104, 'First', 2023),
       (5, 5, 105, 'Second', 2024),
       (6, 6, 106, 'Third', 2025),
       (7, 7, 107, 'Fourth', 2026),
       (8, 8, 108, 'First', 2027),
       (9, 9, 109, 'Second', 2028),
       (10, 10, 110, 'Third', 2029);

--3. Fillthe tuple of each table at least 10 tuples

INSERT INTO Section (Customer_ID, Sec_ID, Semester, Year, Building, Room_Number, Time_Slot_ID)
VALUES (1, 101, 'First', 2020, 'Science Building', 'S101', 1),
       (2, 102, 'Second', 2021, 'Arts Building', 'A201', 2),
       (3, 103, 'Third', 2022, 'Engineering Building', 'E301', 3),
       (4, 104, 'First', 2023, 'Business Building', 'B401', 4),
       (5, 105, 'Second', 2024, 'Law Building', 'L501', 5),
       (6, 106, 'Third', 2025, 'Medical Building', 'M601', 6),
       (7, 107, 'Fourth', 2026, 'Education Building', 'E701', 7),
       (8, 108, 'First', 2027, 'Arts Building', 'A801', 8),
       (9, 109, 'Second', 2028, 'Science Building', 'S901', 9),
       (10, 110, 'Third', 2029, 'Engineering Building', 'E1001', 10);

INSERT INTO Instructor (ID, Name, Dept_Name, Salary)
VALUES (1, 'John Smith', 'History', 70000),
       (2, 'Jane Doe', 'Computer Science', 80000),
       (3, 'Bob Williams', 'Physics', 90000),
       (4, 'Emily Davis', 'Mathematics', 85000),
       (5, 'Michael Brown', 'Biology', 75000),
       (6, 'Emily Wilson', 'Chemistry', 95000),
       (7, 'Joshua Davis', 'English', 72000),
       (8, 'Ashley Taylor', 'Philosophy', 78000),
       (9, 'Matthew Anderson', 'Geography', 80000),
       (10, 'Olivia Thomas', 'Political Science', 90000);


INSERT INTO Department (Dept_Name, Building, Budget)
VALUES ('History', 'H Building', 100000),
       ('Computer Science', 'CS Building', 120000),
       ('Physics', 'P Building', 140000),
       ('Mathematics', 'M Building', 110000),
       ('Biology', 'B Building', 130000),
       ('Chemistry', 'C Building', 150000),
       ('English', 'E Building', 95000),
       ('Philosophy', 'PH Building', 105000),
       ('Geography', 'G Building', 115000),
       ('Political Science', 'PS Building', 125000);


INSERT INTO Course (Course_ID, Title, Dept_Name, Credits)
VALUES (101, 'World History', 'History', 3),
       (102, 'Introduction to Programming', 'Computer Science', 4),
       (103, 'Classical Mechanics', 'Physics', 3),
       (104, 'Linear Algebra', 'Mathematics', 3),
       (105, 'Ecology', 'Biology', 4),
       (106, 'Organic Chemistry', 'Chemistry', 4),
       (107, 'Game Design', 'Puber', 3),
       (108, 'Game Design', 'Dynamite', 3),
       (109, 'Physical Geography', 'Geography', 4),
       (110, 'International Relations', 'Political Science', 4);


INSERT INTO Student (ID, Name, Dept_Name, Tot_Credit)
VALUES (101, 'Mike Smith', 'Computer Science', 30),
       (102, 'Jane Doe', 'History', 25),
       (103, 'Bob Johnson', 'Physics', 35),
       (104, 'Emily Brown', 'Mathematics', 32),
       (105, 'Michael Davis', 'Biology', 29),
       (106, 'Emily Martinez', 'Chemistry', 27),
       (107, 'Joshua Robinson', 'English', 31),
       (108, 'Ashley Taylor', 'Philosophy', 28),
       (109, 'Matthew Anderson', 'Geography', 26),
       (110, 'Olivia Perez', 'Political Science', 34);

/*1. Finds the names of all instructors in the History department*/
--SQL
SELECT Name
FROM Instructor 
WHERE Dept_Name='History';

--Relational Alegbra
π Name (σ Dept_Name = 'History' (Instructor))

/*2. Findsthe instructor ID and department name of all instructors associated with a
department with budget of greater than $95,000*/
--SQL
SELECT Instructor.ID, Dept_Name 
FROM Instructor 
INNER JOIN 
Department ON Instructor.Dept_Name=Department.Dept_Name 
WHERE Budget>95000;

--Relational Algebra
π ID, Dept_Name (Instructor) × σ Budget > 95000 (Department)

/*3. Findsthe names of all instructors in the Comp. Sci. department together with the
course titles of all the courses that the instructors teach*/
--SQL
SELECT Instructor.Name, Course.Title
FROM Instructor
JOIN Teaches ON Instructor.ID = Teaches.ID
JOIN Section ON Teaches.Sec_ID = Section.Sec_ID
JOIN Course ON Section.Course_ID = Course.Course_ID
WHERE Instructor.Dept_Name = 'Computer Science';

--Relational Algebra
π Name, Title (Instructor ⨝ Teaches ⨝ Section ⨝ Course) 

/*4. Find the names of all students who have taken the course title of “Game Design”.*/
--SQL
SELECT Student.Name
FROM Student
JOIN Enrolls ON Student.ID = Enrolls.ID
JOIN Section ON Enrolls.Sec_ID = Section.Sec_ID
JOIN Course ON Section.Course_ID = Course.Course_ID
WHERE Course.Title = 'Game Design';

--Relational Algebra
π Name (Student ⨝ Enrolls ⨝ Section ⨝ σ Title = 'Game Design' (Course))


/*5. For each department, find the maximum salary of instructors in that department. You
may assume that every department has at least one instructor.*/
--SQL
SELECT Dept_Name, MAX(Salary)
FROM Instructor
GROUP BY Dept_Name;

--Relational Algebra
σ MAX(Salary) (Instructor) GROUPBY Dept_Name

/* 6. Find the lowest, across all departments, of the per-department maximum salary
computed by the preceding query.*/
--SQL
WITH per_dept_max_salary AS (
  SELECT Dept_Name, MAX(Salary) as max_salary
  FROM Instructor
  GROUP BY Dept_Name
)
SELECT MIN(max_salary)
FROM per_dept_max_salary;

--Relational Algebra
MIN (σ MAX(Salary) (Instructor) GROUPBY Dept_Name)


/*7. Find the ID and names of all students who do not have an advisor.*/
--SQL
SELECT ID, Name
FROM Student
WHERE Advisor_ID IS NULL;

--Relational Algebra
π ID, Name (σ Advisor_ID = NULL (Student))
