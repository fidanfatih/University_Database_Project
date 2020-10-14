--CREATE DATABASE University;
--USE University;

CREATE TABLE Regions (
  regionID int NOT NULL IDENTITY(1,1),
  region varchar(255) NOT NULL CONSTRAINT check_region CHECK (region in ('England', 'Scotland', 'Wales','Northern Ireland') ),
  --The university is administered in four geographical regions (England, Scotland, Wales and Northern Ireland). ✓
  PRIMARY KEY (regionID)
);

CREATE TABLE Staff (
  staffID int NOT NULL IDENTITY(10,1),
  regionID int NOT NULL,
  staffName varchar(255) NOT NULL,
  CONSTRAINT fk1_region_id FOREIGN KEY (regionID) REFERENCES Regions (regionID),
  PRIMARY KEY (staffID)
);

CREATE TABLE Students (
  studentID int NOT NULL IDENTITY(100,1),
  regionID int NOT NULL,
  counselorID int NOT NULL,
  studentName varchar(255) NOT NULL,
  registrationDate datetime NOT NULL,
  CONSTRAINT fk2_region_id FOREIGN KEY (regionID) REFERENCES Regions (regionID),
  CONSTRAINT fk1_counselor_id FOREIGN KEY (counselorID) REFERENCES Staff (staffID),
  PRIMARY KEY (studentID)
);

CREATE TABLE Courses (
  courseID int NOT NULL IDENTITY(1,1),
  courseTitle varchar(255) NOT NULL,
  creditPoint int NOT NULL CONSTRAINT check_credit CHECK (creditPoint=15 OR creditPoint=30),
  --A course is either a 15-point course or a 30-point course ✓
  quotaNum int NOT NULL,
  tutorID int NOT NULL,
  CONSTRAINT fk1_tutor_id FOREIGN KEY (tutorID) REFERENCES Staff (staffID),
  PRIMARY KEY (courseID)
);

CREATE TABLE Enrollments (
  courseID int NOT NULL, 
  studentID int NOT NULL,
  enrolledDate datetime NOT NULL,
  finalGrade int NOT NULL CONSTRAINT check_finalGrade CHECK (finalGrade BETWEEN 0 AND 100),
  -- finalGrade must be the mean value of assignments grades.
  CONSTRAINT fk1_course_id FOREIGN KEY (courseID) REFERENCES Courses (courseID),
  CONSTRAINT fk2_student_id FOREIGN KEY (studentID) REFERENCES Students (studentID),
  PRIMARY KEY (courseID,studentID)
	);

CREATE TABLE Assignments (
  courseID int NOT NULL, 
  studentID int NOT NULL,
  assignmentID int NOT NULL,
  grade int NOT NULL CONSTRAINT check_grade CHECK (grade BETWEEN 0 AND 100),
  --The grade for an assignment on any course is recorded as a mark out of 100. ✓
  CONSTRAINT fk_student_course FOREIGN KEY (courseID, studentID) REFERENCES Enrollments (courseID, studentID),
  PRIMARY KEY (courseID, studentID, assignmentID)
);

							--CONSTRAINT FUNCTIONS
--1)They may not take courses simultaneously if their combined points total exceeds 180 points.
CREATE FUNCTION check_volume_1()
RETURNS int
AS
BEGIN
DECLARE @ret int

IF EXISTS (SELECT e.studentID, SUM(creditPoint) as credit
			FROM Courses as c
			INNER JOIN Enrollments as e
			ON c.courseID=e.courseID
			GROUP BY e.studentID
			HAVING SUM(creditPoint) > 180)

SELECT @ret=1 ELSE SELECT @ret=0;
RETURN @ret;
END;

ALTER TABLE Enrollments
ADD CONSTRAINT square_volume_1 CHECK(dbo.check_volume_1()=0); --dbo mutlaka yazilmali.


--2)A staff member may only be COUNSEL or tutor a student who is resident in the same region as that staff member.
CREATE FUNCTION check_volume_2()
RETURNS int
AS
BEGIN
DECLARE @ret int

IF EXISTS (SELECT  s.studentName,s.regionID as student_region, sf.staffName, sf.regionID as stuff_region
			FROM Regions as r
			FULL OUTER JOIN Students as s
			ON r.regionID=s.regionID
			FULL OUTER JOIN Staff as sf
			ON sf.staffID=s.counselorID
			WHERE sf.regionID <> r.regionID)

SELECT @ret=1 ELSE SELECT @ret=0;
RETURN @ret;
END;

ALTER TABLE Students
ADD CONSTRAINT square_volume_2 CHECK(dbo.check_volume_2()=0); --dbo mutlaka yazilmali.


--3)A staff member may only be counsel or TUTOR a student who is resident in the same region as that staff member.
CREATE FUNCTION check_volume_3()
RETURNS int
AS
BEGIN
DECLARE @ret int

IF EXISTS (SELECT  s.studentName,
					s.regionID as student_region,
					c.courseTitle,
					sf.staffName as tutor_name,
					sf.regionID as tutor_region
			FROM Enrollments as e
			FULL OUTER JOIN Courses as c
			ON e.courseID=c.courseID
			FULL OUTER JOIN Staff as sf
			ON sf.staffID=c.tutorID
			FULL OUTER JOIN Regions as r
			ON sf.regionID=r.regionID
			FULL OUTER JOIN Students as s
			ON s.studentID=e.studentID
			WHERE s.regionID <> sf.regionID )

SELECT @ret=1 ELSE SELECT @ret=0;
RETURN @ret;
END;

ALTER TABLE Courses
ADD CONSTRAINT square_volume_3 CHECK(dbo.check_volume_3()=0); --dbo mutlaka yazilmali.

  
--4)a 15-point course may have up to three assignments per presentation.
CREATE FUNCTION check_volume_4()
RETURNS int
AS
BEGIN
DECLARE @ret int

IF EXISTS (SELECT e.courseID, e.studentID, COUNT(a.assignmentID)
			FROM Courses as c
			FULL OUTER JOIN Enrollments as e
			ON c.courseID=e.courseID
			FULL OUTER JOIN Assignments as a
			ON a.studentID=e.studentID and a.courseID=e.courseID
			WHERE c.creditPoint=15
			GROUP BY e.courseID,e.studentID
			HAVING COUNT(a.assignmentID) > 3 )

SELECT @ret=1 ELSE SELECT @ret=0;
RETURN @ret;
END;

ALTER TABLE Assignments
ADD CONSTRAINT square_volume_4 CHECK(dbo.check_volume_4()=0); --dbo mutlaka yazilmali.



--5)a 30-point course may have up to five assignments per presentation.
CREATE FUNCTION check_volume_5()
RETURNS int
AS
BEGIN
DECLARE @ret int

IF EXISTS (SELECT e.courseID, e.studentID, COUNT(a.assignmentID)
			FROM Courses as c
			FULL OUTER JOIN Enrollments as e
			ON c.courseID=e.courseID
			FULL OUTER JOIN Assignments as a
			ON a.studentID=e.studentID and a.courseID=e.courseID
			WHERE c.creditPoint=30
			GROUP BY e.courseID,e.studentID
			HAVING COUNT(a.assignmentID) > 5 )

SELECT @ret=1 ELSE SELECT @ret=0;
RETURN @ret;
END;

ALTER TABLE Assignments
ADD CONSTRAINT square_volume_5 CHECK(dbo.check_volume_5()=0); --dbo mutlaka yazilmali.

--6)A course may have a quota for the number of students enrolled in it at any one presentation.
CREATE FUNCTION check_volume_6()
RETURNS int
AS
BEGIN
DECLARE @ret int

IF EXISTS (SELECT c.courseID,
			c.quotaNum,
			COUNT(e.studentID) as enrolled_student_nums
			FROM Enrollments as e
			LEFT JOIN Courses as c
			ON c.courseID=e.courseID
			GROUP BY c.courseID, c.quotaNum
			HAVING COUNT(e.studentID) > c.quotaNum)

SELECT @ret=1 ELSE SELECT @ret=0;
RETURN @ret;
END;

ALTER TABLE Enrollments
ADD CONSTRAINT square_volume_6 CHECK(dbo.check_volume_6()=0); --dbo mutlaka yazilmali.

--7)at any particular point in time, a member of staff may not be allocated any students to tutor or counsel. 
