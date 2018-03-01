delimiter //
CREATE TRIGGER max_round_in BEFORE INSERT ON PostProceduretry
  FOR EACH ROW
  BEGIN
	IF NEW.RoundNo > getmaxrounds(New.PID) THEN
	SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Max Rounds Constraint Failed";
	END IF; 
  END;//

CREATE OR REPLACE TRIGGER max_round_up_1 BEFORE UPDATE ON PostProceduretry
  FOR EACH ROW
  BEGIN
	IF NEW.RoundNo > getmaxrounds(New.PID) THEN
	SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = "Max Rounds Constraint Failed";
	END IF; 
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
CREATE TRIGGER job_offer_in AFTER INSERT ON PostsApplicants
  FOR EACH ROW
  BEGIN
	IF NEW.RoundNo = getmaxrounds(NEW.PID) AND NEW.Status = "Passed" THEN
	Select username FROM Student WHERE Rollno = NEW.RollNo into @a;
	SET @note = CONCAT("You have been selected for the Post PID :",NEW.PID);
	INSERT INTO Notifications (Username,notify) values (username,note);
	END IF; 
  END;//

CREATE TRIGGER job_offer_up AFTER UPDATE ON PostsApplicants
  FOR EACH ROW
  BEGIN
	IF NEW.RoundNo = getmaxrounds(NEW.PID) AND NEW.Status = "Passed" THEN
	Select username FROM Student WHERE Rollno = NEW.RollNo into @a;
	SET @note = CONCAT("You have been selected for the Post PID :",NEW.PID);
	INSERT INTO Notifications (Username,notify) values (username,note);
	END IF; 
  END;//


delimiter //
CREATE TRIGGER offer_expiry AFTER INSERT ON offerdetails
  FOR EACH ROW
  BEGIN
	DECLARE username varchar(255);
	DECLARE note varchar(255);
	IF NEW.RoundNo = (SELECT MaxRounds FROM Postings WHERE PID = NEW.PID) AND NEW.Status = "Passed" THEN
	SET username = (select username FROM Student WHERE Rollno = NEW.RollNo);
	SET note = CONCAT("You have been selected for Post",NEW);
	INSERT INTO Notifications (Username,notify) values (username,note);
	END IF; 
  END;//
