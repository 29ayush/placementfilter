create or replace view publictaken 
as select * from Taken where Privpub=1 and Verified=1;

create or replace view freeslots 
as select * from SlotsAvailable where (slotId,Room) not in (Select slotId,Room from PostProcedure );

create view publicstudent as 
select T1.*,Email,PCVId,PNo,CGPA,address from 
((select Name,RollNo,Gender,Dept,Programme,Verified from Student) as T1 left join  
(select RollNo,Email from Student) as T2 on T1.RollNo=T2.RollNo left join 
(select RollNo,PCVId from Student) as T3 on T1.RollNo=T3.RollNo left join 
(select RollNo,PNo from Student)   as T4 on T1.RollNo=T4.RollNo left join 
(select RollNo,CGPA from Student)  as T5 on T1.RollNo=T5.RollNo left join
(select RollNo,address from Student) as T6 on T1.RollNo=T6.RollNo);

create view openjobs as 
select DISTINCT PID from Postings where PID NOT IN (select PID from PostProcedure as p1 left join SlotsAvailable as p2 on p1.slotId=p2.slotId where RoundNo=0 and DATE_SUB(`Date`,INTERVAL 1 DAY) < curdate() );

create view pernotifs as 
select * from Notifications where Username= SUBSTRING_INDEX((SELECT USER()), '@', 1) or Username=CONCAT('#',(select default_role from mysql.user where user=(SELECT SUBSTRING_INDEX( (SELECT USER()), '@', 1) )));

create or replace view fulljobs as
SELECT PID,CID,Field,Description,MaxStu,MinStu,MaxRounds,MaxPay,MinPay,Shift from Postings P INNER JOIN Jobs J ON P.PID=J.JID where Approval=1;

create or replace view fullintern as
SELECT PID,CID,Field,Description,MaxStu,MinStu,MaxRounds,PPO,Duration,Stipend from Postings P INNER JOIN Internships I ON P.PID=I.IID where Approval=1;


