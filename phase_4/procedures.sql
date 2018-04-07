delimiter //
CREATE OR REPLACE PROCEDURE studentpriv ()
BEGIN 
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
    SET @Q1 = CONCAT("Select * from Student where Username='",@user,"'");
    EXECUTE IMMEDIATE @Q1;
END//




CREATE OR REPLACE PROCEDURE takenpriv ()
BEGIN 
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
    SELECT RollNo from Student where Username=@user into @roll;
    SET @Q1 = CONCAT("Select * from Taken where RollNo='",@roll,"'");
    EXECUTE IMMEDIATE @Q1;
END//




CREATE OR REPLACE PROCEDURE getshortlist (IN pid int,IN roundno int,IN choice BIT(1))
BEGIN 
    if choice=0 then
        SELECT PID,RollNo,RoundNo,Status from PostsApplicants where PID=pid and RoundNo=roundno;
    else 
        SELECT PID,RollNo,RoundNo,Status from PostsApplicants where PID=pid and RoundNo=roundno and Status="Accepted";
    end if;
END//


create or replace function getmaxrounds(in_pid int)
RETURNS INT
READS SQL DATA
BEGIN 
IF EXISTS(SELECT MaxRounds from Postingstry where PID = in_pid)
   then 
    RETURN (SELECT MaxRounds from Postingstry where PID = in_pid);

else 
         RETURN (SELECT 0);
end if;
end;//



create or replace function getslotclashes(slots int ,pi int ,roundn int)
RETURNS INT
READS SQL DATA
BEGIN 

    select `Date`,`Time` from SlotsAvailable where slotId = slots into @date,@time;

    select count(*) from (select DISTINCT RollNo from PostsApplicants where (PID,RoundNo) in (select PID,RoundNo+1 from PostProcedure where slotId in (select slotId from SlotsAvailable where `Date`=@date and `Time`=@time and slotId!=slots)) ) as O where RollNo
    in      
    (select DISTINCT RollNo from PostsApplicants where PID=pi and RoundNo=roundn)  into @b;
     
    return @b;
end;//



create or replace procedure applyposts(IN in_pid int)
BEGIN
    select count(*) from openjobs where PID=in_pid into @count;
    if(@count=1) then
        SELECT USER() into @temp;
        SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
        select RollNo from Student where username=@user into @roll;
        if( ifnull(@roll,'#') not in (select RollNo from Student as S where S.Dept in (select Department from PostProfileBranch) and S.CGPA >= (select MinGPA from PostProfileBranch where Department=S.Dept))) then
          SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Eligible";
        end if;
        INSERT INTO PostsApplicants VALUES (in_pid,@roll,0,"PInterview");        
    else
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Join time over";
    end if;
end;//

CREATE OR REPLACE PROCEDURE applyprofile (pi int,roundd int)
BEGIN 
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
    select CID from CR where username=@user into @CID;
    SELECT CID from Postings where PID=PID into @iCID;


    if(ifnull(@iCID,'#')!=ifnull(@iCID,'#1')) then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "You are not a 
represenative for this company";
    end if;
    
    select * from (select RollNo from PostsApplicants where PID in (select PID from Postings where CID=@CID and Approval=1) and RoundNo=roundd and status="PInterview") as P where P.RollNo in (select DISTINCT RollNo from PostProfileCourse as P,Taken as T where P.CourseCode=T.CourseCode and P.PID=pi and T.sem=ifnull(P.sem,T.sem) and P.MinGrade+0 >= T.Grade+0);
    
END;//
