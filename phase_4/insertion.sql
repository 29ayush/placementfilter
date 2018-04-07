delimiter //
CREATE OR REPLACE PROCEDURE createuserstudent (IN pass varchar(30),IN userna Varchar(50)   , IN Name Varchar(50)  , IN RollNo Int , IN Email Varchar(255)   , IN PCVId Varchar(500)   , IN PNo Int, IN Gender enum('M','F') , IN Dept Varchar(50) , IN Programme  enum('BTECH','MTECH','PhD','MSc','BSc','BA','MA') , IN CGPA   Numeric(4,2) , IN address varchar(200)  , IN Privpub BIT(5)  ) 
BEGIN 

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    ROLLBACK;
    RESIGNAL;
    END;

    start transaction;
    SELECT CURRENT_ROLE() into @role;
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
    SET @commonins = "INSERT INTO Login VALUES(";
    if(@user="root" or @role="role_admin" or @role= "role_moderator")
        then
        if(userna in (select Username from Login))
        then 
            SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'Username Already Exists';
        end if;
        INSERT INTO Login VALUES(userna,PASSWORD(pass),"Student"); 
        INSERT INTO Student VALUES(userna,Name,RollNo,Email,PCVId,PNo,Gender,Dept,Programme,CGPA,address,Privpub,0);
        SET @query3 = CONCAT("create user '",userna,"'@'localhost' identified by '",pass,"'");
        SET @query4 = CONCAT("GRANT ","role_student"," to ",userna,"@localhost");
        SET @query5 = CONCAT("SET DEFAULT ROLE  ","role_student"," for ",userna,"@localhost");
        EXECUTE IMMEDIATE @query3;
        EXECUTE IMMEDIATE @query4;
        EXECUTE IMMEDIATE @query5;
    else 
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Not enough priviliges';
    end if;
    commit;
END//




CREATE OR REPLACE PROCEDURE createuserprof (IN pass varchar(30),IN userna Varchar(50)   , IN Name Varchar(50)  , IN StaffId INT , IN Email Varchar(255)   , IN PNo Int(10) , IN Dept Varchar(50) ) 
BEGIN 
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    ROLLBACK;
    RESIGNAL;
    END;
    
    start transaction;
    SELECT CURRENT_ROLE() into @role;
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
    SET @commonins = "INSERT INTO Login VALUES(";
    if(@user="root" or @role="role_admin" or @role= "role_moderator")
        then
        if(userna in (select Username from Login))
        then 
            SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'Username Already Exists';
        end if;
        INSERT INTO Login VALUES(userna,PASSWORD(pass),"Professor"); 
        INSERT INTO Professor VALUES(userna,Name,StaffId,Dept,Email,PNo);
        SET @query3 = CONCAT("create user '",userna,"'@'localhost' identified by '",pass,"'");
        SELECT @query3;
        SET @query4 = CONCAT("GRANT ","role_professor"," to ",userna,"@localhost");
        SET @query5 = CONCAT("SET DEFAULT ROLE ","role_professor"," for ",userna,"@localhost");
        EXECUTE IMMEDIATE @query3;
        EXECUTE IMMEDIATE @query4;
        EXECUTE IMMEDIATE @query5;
    else 
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Not enough priviliges';
    end if;
    commit;
END//






CREATE OR REPLACE PROCEDURE createusermod (IN pass varchar(30),IN username Varchar(50)   , IN Name Varchar(50)  , IN Email Varchar(255) , IN PNo Int(10) ) 
BEGIN 

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    ROLLBACK;
    RESIGNAL;
    END;

    start transaction;
    SELECT CURRENT_ROLE() into @role;
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
    SET @commonins = "INSERT INTO Login VALUES(";
    if(@user="root" or @role="role_admin" or @role= "role_moderator")
        then
        if(username in (select Username from Login))
        then 
            SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'Username Already Exists';
        end if;
        INSERT INTO Login VALUES(Username,PASSWORD(pass),"Moderator"); 
        INSERT INTO Moderator VALUES(username,Name,Email,PNo);
        SET @query3 = CONCAT("create user '",username,"'@'localhost' identified by '",pass,"'");
        SET @query4 = CONCAT("GRANT ","role_moderator"," to ",username,"@localhost");
        SET @query5 = CONCAT("SET DEFAULT ROLE ","role_moderator"," for ",userna,"@localhost");
        EXECUTE IMMEDIATE @query3;
        EXECUTE IMMEDIATE @query4;
        EXECUTE IMMEDIATE @query5;
    else 
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Not enough priviliges';
    end if;
    commit;
END//





CREATE OR REPLACE PROCEDURE createuseradmin (IN pass varchar(30),IN username Varchar(50)   , IN Email Varchar(255) , IN PNo Int(10) ) 
BEGIN 
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    ROLLBACK;
    RESIGNAL;
    END;

    start transaction;
    SELECT CURRENT_ROLE() into @role;
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
    SET @commonins = "INSERT INTO Login VALUES(";
    if(@user="root" or @role="role_admin" )
        then
        if(username in (select Username from Login))
        then 
            SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'Username Already Exists';
        end if;
        INSERT INTO Login VALUES(Username,PASSWORD(pass),"Admin"); 
        INSERT INTO Admin VALUES(username,Email,PNo);
        SET @query3 = CONCAT("create user '",username,"'@'localhost' identified by '",pass,"'");
        SET @query4 = CONCAT("GRANT ","role_admin"," to ",username,"@localhost");
        SET @query5 = CONCAT("SET DEFAULT ROLE ","role_admin"," for ",userna,"@localhost");
        EXECUTE IMMEDIATE @query3;
        EXECUTE IMMEDIATE @query4;
        EXECUTE IMMEDIATE @query5;
    else 
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Not enough priviliges';
    end if;
    commit;
END//




CREATE OR REPLACE PROCEDURE createusercr (IN pass varchar(30),IN userna Varchar(50)   , IN Name Varchar(50)  ,  IN Email Varchar(255)   , IN PNo Int(10) , IN CID int) 
BEGIN 
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    ROLLBACK;
    RESIGNAL;
    END;

    start transaction;
    SELECT CURRENT_ROLE() into @role;
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
    SET @commonins = "INSERT INTO Login VALUES(";
    if(@user="root" or @role="role_admin" or @role= "role_moderator")
        then
        if(userna in (select Username from Login))
        then 
            SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'Username Already Exists';
        end if;
        INSERT INTO Login VALUES(userna,PASSWORD(pass),"CR"); 
        INSERT INTO CR VALUES(userna,Name,Email,PNo,CID);
        SET @query3 = CONCAT("create user '",userna,"'@'localhost' identified by '",pass,"'");
        SET @query4 = CONCAT("GRANT ","role_cr"," to ",userna,"@localhost");
        SET @query5 = CONCAT("SET DEFAULT ROLE ","role_cr"," for ",userna,"@localhost");
        EXECUTE IMMEDIATE @query3;
        EXECUTE IMMEDIATE @query4;
        EXECUTE IMMEDIATE @query5;
    else 
        SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Not enough priviliges';
    end if;
    commit;
END//





CREATE OR REPLACE PROCEDURE addinternship (Field Varchar(50), Description TEXT , MaxStu Int, MinStu Int,MaxRounds int,PPO Bit(1),Duration integer,Stipend Numeric(12,2) )
BEGIN 

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    ROLLBACK;
    RESIGNAL;
    END;

    start transaction;
    SELECT CURRENT_ROLE() into @role;
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;

    Select CID from CR where Username=@user into @Q1;
    
    if(ifnull(@role,'admin')!="role_cr") then
            SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'NOT Meant for you';
        end if;
        INSERT INTO Postings(CID,Field,Description,MaxStu,MinStu,Approval,MaxRounds) VALUES(@Q1,Field,Description,MaxStu,MinStu,0,MaxRounds);
        
        SELECT LAST_INSERT_ID() into @PID;
        
        INSERT INTO Internships VALUES(@PID,PPO,Duration,Stipend);
        
    commit;
END//





CREATE OR REPLACE PROCEDURE addjobs (Field Varchar(50), Description TEXT , MaxStu Int, MinStu Int,MaxRounds int,MaxPay Numeric(12,2),MinPay Numeric(12,2), Shift enum("Morning","Evening","Both"))
BEGIN 

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    ROLLBACK;
    RESIGNAL;
    END;

    start transaction;
    SELECT CURRENT_ROLE() into @role;
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
    
    Select (Select CID from CR where Username=@user) into @Q1;

    if(ifnull(@role,'admin')!="role_cr") then
            SIGNAL SQLSTATE '50002' SET MESSAGE_TEXT = 'NOT ENOUGH PRIVILIGES';
        end if;
        INSERT INTO Postings(CID,Field,Description,MaxStu,MinStu,Approval,MaxRounds) VALUES(@Q1,Field,Description,MaxStu,MinStu,0,MaxRounds);
        SELECT LAST_INSERT_ID() into @PID;
        
        INSERT INTO Jobs VALUES(@PID,MaxPay,MinPay,Shift);

    commit;
END//


CREATE OR REPLACE PROCEDURE subscribe (IN CID int)
BEGIN 

    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
    INSERT INTO Subscriptions VALUES (CID,@user);
END//


CREATE OR REPLACE PROCEDURE unsubscribe (IN CID int)
BEGIN 

    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
    DELETE FROM Subscriptions WHERE CID = CID and username = @user;
END//

CREATE OR REPLACE PROCEDURE acceptjob(IN pi int)
BEGIN 

    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
    SELECT RollNo from Student where Username=@user into @roll;
    
    UPDATE offerdetails SET status="Accepted" WHERE PID=pi AND RollNo=@roll;
END//

CREATE OR REPLACE PROCEDURE declinejob(IN pi int)
BEGIN 

    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
    SELECT RollNo from Student where Username=@user into @roll;
    
    UPDATE offerdetails SET status="Declined" WHERE PID=pi AND RollNo=@roll;
END//


