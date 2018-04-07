delimiter //
CREATE OR REPLACE TRIGGER pppr BEFORE INSERT ON PostProcedure
  FOR EACH ROW
  BEGIN

    select default_role from mysql.user where user=(SELECT SUBSTRING_INDEX( (SELECT USER()), '@', 1) ) into @a;

    if(ifnull(@a,0)!='role_cr') then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Enough Privleges or use proper channel";
    end if; 
    
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
    select CID from CR where username=@user into @CID;
    SELECT CID from Postings where PID=NEW.PID into @iCID;
    
    if(ifnull(@iCID,'#')!=ifnull(@iCID,'#1')) then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "You are not a represenative for this company";
    end if;

	IF NEW.RoundNo > getmaxrounds(New.PID) THEN
	    SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Max Rounds Constraint Failed";
	END IF; 
  END;//


CREATE OR REPLACE TRIGGER ppup BEFORE UPDATE ON PostProcedure
  FOR EACH ROW
  BEGIN

    select default_role from mysql.user where user=(SELECT SUBSTRING_INDEX( (SELECT USER()), '@', 1) ) into @a;

    if(ifnull(@a,0)!='role_cr') then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Enough Privleges or use proper channel";
    end if; 
    
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
    select CID from CR where username=@user into @CID;
    SELECT CID from Postings where PID=NEW.PID into @iCID;
    
    if(ifnull(@iCID,'#')!=ifnull(@iCID,'#1')) then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "You are not a represenative for this company";
    end if;

    IF NEW.RoundNo > getmaxrounds(New.PID) THEN
	SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Max Rounds Constraint Failed";
	END IF; 

  END;//































delimiter //
CREATE OR REPLACE TRIGGER ppbr BEFORE INSERT ON PostProfileBranch
  FOR EACH ROW
  BEGIN

    select default_role from mysql.user where user=(SELECT SUBSTRING_INDEX( (SELECT USER()), '@', 1) ) into @a;

    if(ifnull(@a,0)!='role_cr') then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Enough Privleges or use proper channel";
    end if; 
    
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
    select CID from CR where username=@user into @CID;
    SELECT CID from Postings where PID=NEW.PID into @iCID;
    
    if(ifnull(@iCID,'#')!=ifnull(@iCID,'#1')) then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "You are not a represenative for this company";
    end if;

  END;//

delimiter //
CREATE OR REPLACE TRIGGER ppbup BEFORE UPDATE ON PostProfileBranch
  FOR EACH ROW
  BEGIN

    select default_role from mysql.user where user=(SELECT SUBSTRING_INDEX( (SELECT USER()), '@', 1) ) into @a;

    if(ifnull(@a,0)!='role_cr') then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Enough Privleges or use proper channel";
    end if; 
    
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
    select CID from CR where username=@user into @CID;
    SELECT CID from Postings where PID=NEW.PID into @iCID;
    
    if(ifnull(@iCID,'#')!=ifnull(@iCID,'#1')) then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "You are not a represenative for this company";
    end if;

  END;//

















delimiter //
CREATE OR REPLACE TRIGGER ppcr BEFORE INSERT ON PostProfileCourse
  FOR EACH ROW
  BEGIN

    select default_role from mysql.user where user=(SELECT SUBSTRING_INDEX( (SELECT USER()), '@', 1) ) into @a;

    if(ifnull(@a,0)!='role_cr') then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Enough Privleges or use proper channel";
    end if; 
    
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
    select CID from CR where username=@user into @CID;
    SELECT CID from Postings where PID=NEW.PID into @iCID;
    
    if(ifnull(@iCID,'#')!=ifnull(@iCID,'#1')) then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "You are not a represenative for this company";
    end if;

  END;//

CREATE OR REPLACE TRIGGER ppcup BEFORE UPDATE ON PostProfileCourse
  FOR EACH ROW
  BEGIN

    select default_role from mysql.user where user=(SELECT SUBSTRING_INDEX( (SELECT USER()), '@', 1) ) into @a;

    if(ifnull(@a,0)!='role_cr') then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Enough Privleges or use proper channel";
    end if; 
    
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
    select CID from CR where username=@user into @CID;
    SELECT CID from Postings where PID=NEW.PID into @iCID;
    
    if(ifnull(@iCID,'#')!=ifnull(@iCID,'#1')) then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "You are not a represenative for this company";
    end if;

  END;//






















delimiter //
CREATE OR REPLACE TRIGGER postingsupdate BEFORE UPDATE ON Postings
  FOR EACH ROW
  BEGIN
    
    select default_role from mysql.user where user=(SELECT SUBSTRING_INDEX( (SELECT USER()), '@', 1) ) into @role;
    
    if(ifnull(@a,0)!='role_moderator' && ifnull(@a,0)!='role_admin' && ifnull(@a,0)!='role_cr' ) then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Enough Privleges or use proper channel";
    end if; 
    
    if(ifnull(@a,0)='role_cr') then
    begin    
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;

    Select CID from CR where Username=@user into @Q1;
    
    SET NEW.Approval = 0;
    if(ifnull(@Q1,'a')!=NEW.CID) then
    SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Matching Username";
    end if;
    end;
    end if;
 
  END;//




delimiter //
CREATE OR REPLACE TRIGGER postaftesupdate AFTER UPDATE ON Postings
  FOR EACH ROW
  BEGIN
    
    IF(NEW.Approval=0) then
    SET @note = CONCAT("Post Details Updated PID: ",NEW.PID);
    Insert Into Notifications VALUES ("#role_moderator",@note);
    end if;
  END;//













delimiter //
CREATE OR REPLACE TRIGGER blacklist_in BEFORE INSERT ON Company
  FOR EACH ROW
  BEGIN
	DECLARE msg varchar(255);
	IF (NEW.Name,New.Address) in (SELECT * FROM Blacklist WHERE Address = NEW.Address AND Name = NEW.Name) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Company is Blacklisted';
	END IF; 
  END;//

delimiter //
CREATE OR REPLACE TRIGGER blacklist_up BEFORE UPDATE ON Company
  FOR EACH ROW
  BEGIN
	DECLARE msg varchar(255);
	IF (NEW.Name,New.Address) in (SELECT * FROM Blacklist WHERE Address = NEW.Address AND Name = NEW.Name) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Company is Blacklisted';
	END IF; 
  END;//









delimiter //
CREATE OR REPLACE TRIGGER takeninsert BEFORE INSERT ON Taken
  FOR EACH ROW
  BEGIN

    select default_role from mysql.user where user=(SELECT SUBSTRING_INDEX( (SELECT USER()), '@', 1) ) into @a;

    if(ifnull(@a,0)!='role_student') then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Enough Privleges or use proper channel";
    end if; 
    
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
    select RollNo from Student where username=@user into @roll;
    
    if(ifnull(@roll,'#')!=New.RollNo) then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Use your own roll No ";
    end if;

	IF (NEW.Verified = 1) then
        SET NEW.Verified = 0;
	END IF; 
    
    SET @note = CONCAT(@user,'Updated his courses taken please review');
	INSERT INTO Notifications (Username,notify) values ("#role_professor",@note);
    
    
  END;//





delimiter //
CREATE OR REPLACE TRIGGER takenupdate BEFORE UPDATE ON Taken
  FOR EACH ROW
  BEGIN

    select default_role from mysql.user where user=(SELECT SUBSTRING_INDEX( (SELECT USER()), '@', 1) ) into @a;

    if(ifnull(@a,0)!='role_student' && ifnull(@a,0)!='role_professor' ) then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Enough Privleges or use proper channel";
    end if; 
    
    if(ifnull(@a,0)='role_student' ) then
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
    select RollNo from Student where username=@user into @roll;
    
    if(ifnull(@roll,'#')!=New.RollNo) then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Use your own roll No ";
    end if;

    SET NEW.Verified = 0;

    SET @note = CONCAT(@user,'Updated his courses taken please review');
	INSERT INTO Notifications (Username,notify) values ("#role_professor",@note);
    
    
    end if;

    
  END;//








delimiter //
CREATE OR REPLACE TRIGGER offerinsertvalid BEFORE INSERT ON offerdetails
  FOR EACH ROW
  BEGIN

    select default_role from mysql.user where user=(SELECT SUBSTRING_INDEX( (SELECT USER()), '@', 1) ) into @a;

    if(ifnull(@a,0)!='role_cr') then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Enough Privleges or use proper channel";
    end if; 
    
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
    select CID from CR where username=@user into @CID;
    SELECT CID from Postings where PID=NEW.PID into @iCID;
    
    if(ifnull(@iCID,'#')!=ifnull(@iCID,'#1')) then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "You are not a represenative for this company";
    end if;

  END;//




delimiter //
CREATE OR REPLACE TRIGGER  offer_expiry AFTER INSERT ON offerdetails
  FOR EACH ROW
  BEGIN
	SET @username = (select username FROM Student WHERE Rollno = NEW.RollNo);
	SET @note = CONCAT("You were selected for Post Make Sure to accept before date (check dash)",NEW.PID);
	INSERT INTO Notifications (Username,notify) values (@username,@note);

  END;//



delimiter //
CREATE OR REPLACE TRIGGER  offerupdate BEFORE UPDATE ON offerdetails
  FOR EACH ROW
  BEGIN
    select default_role from mysql.user where user=(SELECT SUBSTRING_INDEX( (SELECT USER()), '@', 1) ) into @a;

    if(ifnull(@a,0)='role_cr' and ifnull(@a,0)='role_student')  then 
    SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Enough Privleges or use proper channel";
    end if;

    if(ifnull(@a,0)='role_cr') then   
        if(NEW.PID!=OLD.PID) then
            SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Invalid Update";
        end if;    
    
        SELECT USER() into @temp;
        SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
        select CID from CR where username=@user into @CID;
        SELECT CID from Postings where PID=NEW.PID into @iCID;
    
        if(ifnull(@iCID,'#')!=ifnull(@iCID,'#1')) then   
            SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "You are not a represenative for this company";
        end if; 
    end if;
    

  END;//





delimiter //
CREATE OR REPLACE TRIGGER job_offer_in AFTER INSERT ON PostsApplicants
  FOR EACH ROW
  BEGIN
	IF (NEW.Status = "Passed") THEN
	Select username FROM Student WHERE Rollno = NEW.RollNo into @a;
	SET @note = CONCAT("You have been selected for the Post PID :",NEW.PID," Round No.",New.RoundNo);
	INSERT INTO Notifications (Username,notify) values (@a,@note);
	END IF; 
  END;//

CREATE OR REPLACE TRIGGER job_offer_up AFTER UPDATE ON PostsApplicants
  FOR EACH ROW
  BEGIN
    IF NEW.Status = "Passed" THEN
	Select username FROM Student WHERE Rollno = NEW.RollNo into @a;
	SET @note = CONCAT("You have been selected for the Post PID :",NEW.PID," Round No.",New.RoundNo);
	INSERT INTO Notifications (Username,notify) values (@a,@note);
	END IF; 
  END;//




CREATE OR REPLACE TRIGGER ppaup BEFORE INSERT ON PostsApplicants
  FOR EACH ROW
  BEGIN

    select default_role from mysql.user where user=(SELECT SUBSTRING_INDEX( (SELECT USER()), '@', 1) ) into @a;

    if(ifnull(@a,0)!='role_cr') then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Enough Privleges or use proper channel";
    end if; 
    
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;    
    select CID from CR where username=@user into @CID;
    SELECT CID from Postings where PID=NEW.PID into @iCID;
    
    if(ifnull(@iCID,'#')!=ifnull(@iCID,'#1')) then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "You are not a represenative for this company";
    end if;

  END;//


delimiter //
CREATE OR REPLACE TRIGGER internshipupdate BEFORE UPDATE ON Internships
  FOR EACH ROW
  BEGIN
  
    select default_role from mysql.user where user=(SELECT SUBSTRING_INDEX( (SELECT USER()), '@', 1) ) into @role;
    
    if(ifnull(@a,0)!='role_cr' ) then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Enough Privleges or use proper channel";
    end if; 
    
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;

    Select CID from CR where Username=@user into @Q1;
    Select CID from Postings where JID=NEW.IID into @Q2;

    
    if(ifnull(@Q1,'a')!=ifnull(@Q2,0)) then
    SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Matching Username";
    end if;
    
    UPDATE Postings SET Approval=0 where PID=NEW.IID;
  END;// 


delimiter //
CREATE OR REPLACE TRIGGER internnotifyup AFTER UPDATE ON Internships
  FOR EACH ROW
  BEGIN
  	SELECT USER() into @temp;
  	SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
	SET @note = CONCAT("Intership details updated of IID",NEW.IID);
	INSERT INTO Notifications (Username,notify) values ("#role_moderator",@note);
  END;//

delimiter //
CREATE OR REPLACE TRIGGER internnotifyio AFTER INSERT ON Internships
  FOR EACH ROW
  BEGIN
  	SELECT USER() into @temp;
  	SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
	SET @note = CONCAT("Intership details inserted of IID",NEW.IID);
	INSERT INTO Notifications (Username,notify) values ("#role_moderator",@note);
  END;//


delimiter //
CREATE OR REPLACE TRIGGER jobnotifyup AFTER UPDATE ON Jobs
  FOR EACH ROW
  BEGIN
  	SELECT USER() into @temp;
  	SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
	SET @note = CONCAT("Jobs details updated of JID",NEW.JID);
	INSERT INTO Notifications (Username,notify) values ("#role_moderator",@note);
  END;//

delimiter //
CREATE OR REPLACE TRIGGER jobnotifyio AFTER INSERT ON Jobs
  FOR EACH ROW
  BEGIN
  	SELECT USER() into @temp;
  	SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;
	SET @note = CONCAT("Jobs details inserted of JID",NEW.JID);
	INSERT INTO Notifications (Username,notify) values ("#role_moderator",@note);
  END;

delimiter //
CREATE OR REPLACE TRIGGER jobsupdate BEFORE UPDATE ON Jobs
  FOR EACH ROW
  BEGIN

    
    select default_role from mysql.user where user=(SELECT SUBSTRING_INDEX( (SELECT USER()), '@', 1) ) into @role;
    
    if(ifnull(@a,0)!='role_cr' ) then   
        SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Enough Privleges or use proper channel";
    end if; 
    
    if(ifnull(@a,0)='role_cr') then
    begin    
    SELECT USER() into @temp;
    SELECT SUBSTRING_INDEX(@temp, '@', 1) into @user;

    Select CID from CR where Username=@user into @Q1;
    Select CID from Postings where JID=NEW.JID into @Q2;

    
    if(ifnull(@Q1,'a')!=ifnull(@Q2,0)) then
    SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Not Matching Username";
    end if;
    
    UPDATE Postings SET Approval=0 where PID=NEW.JID;
    end;
    end if;
  END;//



