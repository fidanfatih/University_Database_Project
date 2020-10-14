
INSERT INTO Regions
VALUES  ('England'),('Scotland'),('Wales'),('Northern Ireland');
--select * from [dbo].[Regions]

INSERT INTO Staff
VALUES  (1,'James Smith'),
		(1,'Tom Hanks'),
		(3,'Maria Hernandez'),
		(2,'Robert Rodriguez'),
		(1,'Julia Roberts'),
		(4,'Maria Garcia'),
		(2,'Eva Green'),
		(2,'David Smith'),
		(4,'Maria Mercedes'),
		(3,'David Smith');
--select * from Staff

INSERT INTO Students
VALUES  (2,13,'Nicholas Cage', '2020-10-10'),
		(4,15,'Morgan Freeman', '2020-10-10'),
		(1,10,'Jim Carrey', '2020-10-05'),
		(3,12,'Robin Williams', '2019-09-09'),
		(2,16,'Will Smith', '2019-09-01'),
		(4,18,'Denzel Washington', '2020-10-01'),
		(3,19,'Slvester Stallonne', '2019-10-10'),
		(1,11,'George Colony', '2020-10-10'),
		(1,10,'Edward Nortan', '2020-10-08'),
		(2,17,'Monica Bellucci', '2020-10-05'),
		(2,13,'Robert De Niro', '2019-09-09'),
		(4,18,'Jet Li', '2019-09-01'),
		(1,14,'Bruce Lee', '2020-10-01');

--select * from Students
--select * from Students a, Staff b where a.counselorID=b.staffID

INSERT INTO Courses
VALUES  ('Computer Programming', 30, 5, 10),
		('Mathematics', 15, 3, 12),
		('History', 30, 3, 14),
		('Physics', 15, 5, 16),
		('Psychology', 30, 2,19),
		('Sociology', 30, 2, 12),
		('Philosophy', 15, 3, 13),
		('Linguistics', 15, 3, 15);

--select * from Courses;
--select * from Staff;
--select* from Students;

INSERT INTO Enrollments
VALUES (1, 112, '2020-10-20', 20),
	   (2, 106, '2020-10-21', 80),
	   (6, 106, '2020-10-21', 90),
	   (7, 110, '2020-10-22', 75),
	   (3, 107, '2020-10-23', 95),
	   (7, 104, '2020-10-29', 75),
	   (3, 108, '2020-10-25', 65),
	   (4, 109, '2020-10-26', 45),
	   (5, 109, '2020-10-26', 59),
	   (4, 104, '2020-10-20', 20),
	   (8, 105, '2020-10-27', 80),
	   (1, 108, '2020-10-28', 75),
	   (4, 110, '2020-10-29', 45),
	   (8, 101, '2020-10-22', 75),
	   (6, 103, '2020-10-28', 65),
	   (5, 103, '2020-10-28', 90),
	   (2, 103, '2020-10-28', 75);

--select * from Enrollments;
--select* from Courses;

INSERT INTO Assignments
VALUES (1, 108, 1, 30),
	   (2, 103, 1, 75),
	   (8, 105,  1, 15),
	   (7, 104, 1, 95),
	   (6, 103, 1, 80),
	   (3, 108,  1, 20),
	   (4, 110,1, 75),
	   (1, 112, 1, 75),
	   (4, 104, 1, 55),
	   (7, 110, 1, 75),
	   (2, 106, 1, 75),
	   (3, 107, 1, 100),
	   (5, 103, 1, 20),
	   (1, 108, 2, 40),
	   (2, 103, 2, 35),
	   (8, 105, 2, 55),
	   (7, 104, 2, 75),
	   (2, 106, 2, 55),
	   (3, 108,2, 79),
	   (6, 103,2, 35),
	   (3, 107,2, 26),
	   (4, 110,2, 75),
	   (1, 112,2, 74),
	   (4, 104,2, 53),
	   (7, 110,2, 76),
	   (5, 103,2, 70),
	   (1, 108, 3, 90),
	   (2, 103, 3, 85),
	   (8, 105, 3, 95),
	   (7, 104, 3, 85),
	   (3, 107,3, 79),
	   (6, 103,3, 85),
	   (3, 108,3, 76),
	   (4, 110,3, 95),
	   (1, 112,3, 94),
	   (4, 104,3, 83),
	   (7, 110,3, 76),
	   (2, 106,3, 95),
	   (5, 103,3, 90),
	   (1, 108,4, 50),
	   (3, 108,4, 55),
	   (5, 103,4, 88),
	   (1, 108,5, 90),
	   (3, 107,5, 100);

--select * from Assignments

