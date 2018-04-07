-- Departments::--
insert into Departments values ('Biology'),
('Comp. Sci.'),
('Elec. Eng.'),
('Finance'),
('History'),
('Music'),
('Physics'),
('Civ. Eng.'),
('Mech. Eng.');


--Courses
insert into Courses values ('BIO-101', 'Intro. to Biology',  4);
insert into Courses values ('BIO-301', 'Genetics',4);
insert into Courses values ('BIO-399', 'Computational Biology',  3);
insert into Courses values ('CS-101', 'Intro. to Computer Science', 4);
insert into Courses values ('CS-190', 'Game Design',  4);
insert into Courses values ('CS-315', 'Robotics',  3);
insert into Courses values ('CS-319', 'Image Processing',  3);
insert into Courses values ('CS-347', 'Database System Concepts', 3);
insert into Courses values ('EE-181', 'Intro. to Digital Systems', 3);
insert into Courses values ('FIN-201', 'Investment Banking',  3);
insert into Courses values ('HIS-351', 'World History', 3);
insert into Courses values ('MU-199', 'Music Video Production', 3);
insert into Courses values ('PHY-101', 'Physical Principles',  4);

--Company
insert into Company(Name,address) values ("Google","Banglore"),
("i-exceed","Hyderabad"),
("Roller","Kanpur"),
("Arista","Banglore"),
("IBM","Banglore"),
("Microsoft","Banglore");

--Blacklist 
insert into Blacklist(Name,address) values ("Shravya","Hyderabad");

--Slots
insert into SlotsAvailable (Room,`Date`,`Time`) VALUES 
(2,"2018-05-07","10:00"),
(3,"2018-05-07","10:00"),
(4,"2018-05-07","10:00"),
(2,"2018-06-07","10:00"),
(2,"2018-06-13","10:00");

--Users 
--Student
call createuserstudent('1yushbooze','29ayush','Ayush Mittal',111501035,'29ayush@gmail.com',NULL,945761595,'M','Comp. Sci.','BTECH',9.1,NULL,0000);
call createuserstudent('nightfox','nightfox','Rajat Sharma',111501023,'nightfox@gmail.com',NULL,94891399,'M','Civ. Eng.','BTECH',9.1,NULL,0000);

--Professor

--CR



