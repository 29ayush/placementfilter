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

--Job Fields
insert into JobFields VALUES
("Web Design","Design websites"),
("Cooking","DO cooking not judge"),
("Home Decor","wannabe architect"),
("Programming","coders gonna code"),
("Android","chahca");

--Broadcast Channel
insert into Login values ('#role_student','pass123','Broadcast');
insert into Login values ('#role_moderator','pass123','Broadcast');
--Users 
--Student
call createuserstudent('1yushbooze','29ayush','Ayush Mittal',111501035,'29ayush@gmail.com',NULL,945761595,'M','Comp. Sci.','BTECH',9.1,NULL,0000);
call createuserstudent('nightfox','nightfox','Rajat Sharma',111501023,'nightfox@gmail.com',NULL,94891399,'M','Civ. Eng.','BTECH',9.1,NULL,0000);

--Professor
call createuserprof('kamlika','kamlika','Kamalika Choudary',23903,'kaml@gmail.com',989898,'Comp. Sci.');
 call createuserprof('raju','raju','raju shrivastav',09909,'raju@gmail.com',989932,'Comp. Sci.');
--CR
call createusercr('billgate','billgate','Bill gates','bill@microsft.com',9898989,2);
call createusercr('sunder','sunder','Sunder Pichai','sunder@google.com',4324324,3);
--Moderator
call createusermod('ravi','ravi','Ravi Ahlawat','ravi@ravi.com',4323423);

---------------------------------------------------------------
call addjobs("Programming","come work",8,1,10,10000,18,'Morning');



