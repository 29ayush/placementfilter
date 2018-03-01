CREATE OR REPLACE PROCEDURE createuserstudent (IN pass varchar(30),IN username Varchar(50)   , IN FirstName Varchar(50)  , IN LastName Varchar(50)   , IN RollNo Int , IN Email Varchar(255)   , IN PCVId Varchar(500)   , IN PNo Int, IN Gender enum('M','F') , IN Dept Varchar(50) , IN Programme  enum('BTECH','MTECH','PhD','MSc','BSc','BA','MA') , IN CGPA   Numeric(4,2) , IN address varchar(200)  , IN Privpub BIT(5)  ) 
BEGIN 
    SELECT CURRENT_ROLE() into @role;
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
    SET @commonins = "INSERT INTO LOGIN VALUES(";
    if(@user="root" or @role="role_admin" or @role= "role_moderator")
        then
        if(username in (select Username from Login))
        then 
            SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'Username Already Exists';
        end if;
        INSERT INTO Login VALUES(username,PASSWORD(pass),"Student"); 
        INSERT INTO Student VALUES(username,FirstName,LastName,RollNo,Email,PCVId,PNo,Gender,Dept,Programme,CGPA,address,Privpub,0);
        SET @query3 = CONCAT("create user '",username,"'@'localhost' identified by '",pass,"'");
        SET @query4 = CONCAT("GRANT ","role_student"," to ",username,"@localhost");
        
        EXECUTE IMMEDIATE @query3;
        EXECUTE IMMEDIATE @query4;
    else 
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Not enough priviliges';
    end if;
END//




CREATE OR REPLACE PROCEDURE createuserprof (IN pass varchar(30),IN username Varchar(50)   , IN Name Varchar(50)  , IN StaffId INT , IN Email Varchar(255)   , IN PNo Int(10) , IN Dept Varchar(50) ) 
BEGIN 
    SELECT CURRENT_ROLE() into @role;
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
    SET @commonins = "INSERT INTO LOGIN VALUES(";
    if(@user="root" or @role="role_admin" or @role= "role_moderator")
        then
        if(username in (select Username from Login))
        then 
            SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'Username Already Exists';
        end if;
        INSERT INTO LOGIN VALUES(Username,PASSWORD(pass),"Professor"); 
        INSERT INTO Professor VALUES(username,Name,StaffId,Dept,Email,PNo);
        SET @query3 = CONCAT("create user '",username,"'@'localhost' identified by '",pass,"'");
        SET @query4 = CONCAT("GRANT ","role_professor"," to ",username,"@localhost");
        
        EXECUTE IMMEDIATE @query3;
        EXECUTE IMMEDIATE @query4;
    else 
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Not enough priviliges';
    end if;
END//





CREATE OR REPLACE PROCEDURE createusermod (IN pass varchar(30),IN username Varchar(50)   , IN Name Varchar(50)  , IN Email Varchar(255) , IN PNo Int(10) ) 
BEGIN 
    SELECT CURRENT_ROLE() into @role;
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
    SET @commonins = "INSERT INTO LOGIN VALUES(";
    if(@user="root" or @role="role_admin" or @role= "role_moderator")
        then
        if(username in (select Username from Login))
        then 
            SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'Username Already Exists';
        end if;
        INSERT INTO LOGIN VALUES(Username,PASSWORD(pass),"Moderator"); 
        INSERT INTO Moderator VALUES(username,Name,Email,PNo);
        SET @query3 = CONCAT("create user '",username,"'@'localhost' identified by '",pass,"'");
        SET @query4 = CONCAT("GRANT ","role_moderator"," to ",username,"@localhost");
        
        EXECUTE IMMEDIATE @query3;
        EXECUTE IMMEDIATE @query4;
    else 
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Not enough priviliges';
    end if;
END//





CREATE OR REPLACE PROCEDURE createuseradmin (IN pass varchar(30),IN username Varchar(50)   , IN Email Varchar(255) , IN PNo Int(10) ) 
BEGIN 
    SELECT CURRENT_ROLE() into @role;
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
    SET @commonins = "INSERT INTO LOGIN VALUES(";
    if(@user="root" or @role="role_admin" )
        then
        if(username in (select Username from Login))
        then 
            SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'Username Already Exists';
        end if;
        INSERT INTO LOGIN VALUES(Username,PASSWORD(pass),"Admin"); 
        INSERT INTO Admin VALUES(username,Email,PNo);
        SET @query3 = CONCAT("create user '",username,"'@'localhost' identified by '",pass,"'");
        SET @query4 = CONCAT("GRANT ","role_admin"," to ",username,"@localhost");
        
        EXECUTE IMMEDIATE @query3;
        EXECUTE IMMEDIATE @query4;
    else 
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Not enough priviliges';
    end if;
END//




CREATE OR REPLACE PROCEDURE createusercr (IN pass varchar(30),IN username Varchar(50)   , IN Name Varchar(50)  ,  IN Email Varchar(255)   , IN PNo Int(10) , IN CID int) 
BEGIN 
    SELECT CURRENT_ROLE() into @role;
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
    SET @commonins = "INSERT INTO LOGIN VALUES(";
    if(@user="root" or @role="role_admin" or @role= "role_moderator")
        then
        if(username in (select Username from Login))
        then 
            SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'Username Already Exists';
        end if;
        INSERT INTO LOGIN VALUES(Username,PASSWORD(pass),"CR"); 
        INSERT INTO CR VALUES(username,Name,Email,PNo,CID);
        SET @query3 = CONCAT("create user '",username,"'@'localhost' identified by '",pass,"'");
        SET @query4 = CONCAT("GRANT ","role_cr"," to ",username,"@localhost");
        
        EXECUTE IMMEDIATE @query3;
        EXECUTE IMMEDIATE @query4;
    else 
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Not enough priviliges';
    end if;
END//





CREATE OR REPLACE PROCEDURE addinternship (CID INT ,Field Varchar(50), Description TEXT , MaxStu Int, MinStu Int, Approval BIT(1),MaxRounds int,PPO Bit(1),Duration integer,Stipend Numeric(12,2) )
BEGIN 
    SELECT CURRENT_ROLE() into @role;
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;

    SET @Q1 = CONCAT("Select CID from CR where Username=",@user);

    if(@user="root" or @role="role_admin" or @role= "role_moderator" or @role="role_cr")
        then
        if(@role="role_cr" and @Q1 != CID)
        then 
            SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'NOT ENOUGH PRIVILIGES';
        end if;
        INSERT INTO Postings(CID,Field,Description,MaxStu,MinStu,Approval,MaxRounds) VALUES(CID,Field,Description,MaxStu,MinStu,Approval,MaxRounds);
        
        SELECT LAST_INSERT_ID() into @PID;
        
        INSERT INTO Internships VALUES(@PID,PPO,Duration,Stipend);
        

    else 
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Not enough priviliges';
    end if;
END//





CREATE OR REPLACE PROCEDURE addjobs (CID INT ,Field Varchar(50), Description TEXT , MaxStu Int, MinStu Int, Approval BIT(1),MaxRounds int,MaxPay Numeric(12,2),MinPay Numeric(12,2), Shift enum("Morning","Evening","Both"))
BEGIN 
    SELECT CURRENT_ROLE() into @role;
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
    SET @Q1 = CONCAT("Select CID from CR where Username=",@user);

    if(@user="root" or @role="role_admin" or @role= "role_moderator" or @role="role_cr")
        then
        if(@role="role_cr" and @Q1 != CID)
        then 
            SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'NOT ENOUGH PRIVILIGES';
        end if;
        INSERT INTO Postings(CID,Field,Description,MaxStu,MinStu,Approval,MaxRounds) VALUES(CID,Field,Description,MaxStu,MinStu,Approval,MaxRounds);
        SELECT LAST_INSERT_ID() into @PID;
        
        INSERT INTO Jobs VALUES(@PID,MaxPay,MinPay,Shift);

    else 
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Not enough priviliges';
    end if;
END//




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
    SET @Q1 = CONCAT("Select * from Taken where Username='",@user,"'");
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
end;










