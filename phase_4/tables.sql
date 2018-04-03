create database placement_cell;
use placement_cell;

Create TABLE Login (
    Username Varchar(50) Primary Key,
    PasswordHash BINARY(64) NOT NULL,
    Usertype enum("Student","Professor","Moderator","Admin","CR")
);

create TABLE Departments (
    Name VARCHAR(50) PRIMARY KEY
);

Create TABLE Student (
    Username Varchar(50)  Not NULL UNIQUE,
    FirstName Varchar(50) Not NULL,
    LastName Varchar(50)  Not NULL,
    RollNo Int Primary Key, 
    Email Varchar(255)    Not NULL UNIQUE,
    PCVId Varchar(500)    UNIQUE,
    PNo Int(10) 	  Not NULL UNIQUE,
    Gender enum('M','F')  NOT NULL,
    Dept Varchar(50)      NOT NULL,
    Programme  enum('BTECH','MTECH','PhD','MSc','BSc','BA','MA') NOT NULL,
    CGPA   Numeric(4,2)   NOT NULL,
    address varchar(200),
    Privpub BIT(5) default 00000 NOT NULL,
    Verified BIT(1) default 0 NOT NULL,
    Foreign Key (Username) REFERENCES Login(Username) ON DELETE CASCADE,
    Foreign Key (Dept) REFERENCES Departments(Name) ON DELETE CASCADE,
    Foreign Key (Dept) REFERENCES Departments(Name) ON UPDATE CASCADE
);


Create TABLE Professor (
    Username Varchar(50) Not Null UNIQUE,
    Name Varchar(50) 	 Not NULL,
    StaffId Int Primary Key, 
    Dept Varchar(50)     NOT NULL,
    Email Varchar(255) Not NULL UNIQUE,
    PNo    Int   Not NULL UNIQUE,
    Foreign Key (Username) REFERENCES Login(Username) ON DELETE CASCADE,
    Foreign Key (Dept) REFERENCES Departments(Name) ON DELETE CASCADE,
    Foreign Key (Dept) REFERENCES Departments(Name) ON UPDATE CASCADE
);


Create TABLE Moderator (
    Username Varchar(50) PRIMARY KEY,
    Name Varchar(50) Not NULL,
    Email Varchar(255) Not NULL UNIQUE,
    PNo    Int   Not NULL UNIQUE,
    Foreign Key (Username) REFERENCES Login(Username) ON DELETE CASCADE

);

Create TABLE Admin (
    Username Varchar(50) PRIMARY KEY,
    Email Varchar(255) Not NULL UNIQUE,
    PNo    Int Not NULL UNIQUE,
    Foreign Key (Username) REFERENCES Login(Username) ON DELETE CASCADE
);

Create TABLE Company (
    Id int AUTO_INCREMENT PRIMARY KEY,
    Name Varchar(50),
    Address Varchar(500),
    UNIQUE (Name,Address)
);

Create TABLE CR (
    Username Varchar(50) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email Varchar(255) NOT NULL UNIQUE,
    PNo    Int NOT NULL UNIQUE,
    CID int NOT NULL,
    Foreign Key (Username) REFERENCES Login(Username) ON DELETE CASCADE,
    Foreign Key (CID) REFERENCES Company(Id) ON DELETE CASCADE
);

Create table Courses (
    Code Varchar(10) PRIMARY KEY,
    Name Varchar(50),
    Credits int(1)
);

Create TABLE Taken (
    RollNo Int NOT NULL, 
    CourseCode Varchar(10) NOT NULL , 
    Sem Int NOT NULL,
    Grade enum("S","A","B","C","D","E"),
    Privpub BIT(1) default 0 NOT NULL,
    Verified BIT(1) default 1 NOT NULL,
    Primary Key (RollNo,CourseCode,Sem),
    Foreign Key (RollNo) REFERENCES Student(RollNo) ON DELETE CASCADE,
    Foreign Key (CourseCode) REFERENCES Courses(Code) ON DELETE NO ACTION,
    Foreign Key (CourseCode) REFERENCES Courses(Code) ON UPDATE CASCADE
);

Create Table JobFields (
    Name VARCHAR(50) PRIMARY KEY,
    Descr VARCHAR(50) NOT NULL
);

Create Table Postings (
    PID INT AUTO_INCREMENT PRIMARY KEY,
    CID INT NOT NULL,
    Field Varchar(50) NOT NULL,
    Description TEXT NOT NULL,
    MaxStu Int,
    MinStu Int,
    Approval BIT(1) NOT NULL default 0,
    MaxRounds int NOT NULL,
    Foreign key(CID) references Company(Id) ON DELETE CASCADE,
    Foreign key(Field) references JobFields(Name) ON DELETE CASCADE
);

Create Table Jobs (
	JID int PRIMARY KEY,
	MaxPay Numeric(12,2),
	MinPay Numeric(12,2) NOT NULL,
	Shift  enum("Morning","Evening","Both") NOT NULL,
	foreign key(JID) references Postings(PID) ON DELETE CASCADE
);


Create Table Internships (
	IID int PRIMARY KEY,
	PPO Bit(1) NOT NULL,
	Duration integer NOT NULL,
	Stipend Numeric(12,2) default NULL,
	foreign key(IID) references Postings(PID) ON DELETE CASCADE
);



Create Table PostProfileBranch (
	PID  int,
	Department Varchar(50) NOT NULL, 
	MinGPA Numeric(4,2),
	FOREIGN KEY(PID) references Postings(PID)  ON DELETE CASCADE,	
	Foreign Key (Department) REFERENCES Departments(Name) ON DELETE CASCADE,
	Foreign Key (Department) REFERENCES Departments(Name) ON UPDATE CASCADE
);


Create Table SlotsAvailable
(
	slotId int,
    Room int NOT NULL,
	`Date` Date NOT NULL,
	`Time` Time NOT NULL,
	Primary KEY(slotId),
    UNIQUE(Room,`Date`,`Time`)
);


Create Table PostProfileCourse (
	PID  int,
    CourseCode Varchar(10) NOT NULL , 
    Sem int,
    MinGrade enum("S","A","B","C","D","E"),
    PRIMARY KEY(PID,CourseCode),
	FOREIGN KEY(PID) references Postings(PID)  ON DELETE CASCADE,
    Foreign Key (CourseCode) REFERENCES Courses(Code) ON DELETE NO ACTION,
    Foreign Key (CourseCode) REFERENCES Courses(Code) ON UPDATE CASCADE
);


Create Table PostProcedure (
	PID int ,
	slotId int UNIQUE NOT NULL,
	RoundNo int NOT NULL,
	ExamType varchar(10) NOT NULL,
	ResultDecl Bit(1) NOT NULL default 0,
	PRIMARY KEY (PID,RoundNo), 
	Foreign key(PID) references Postings(PID) ON DELETE CASCADE,
	Foreign key(slotId) references SlotsAvailable(slotId) ON DELETE CASCADE
);


Create Table PostsApplicants
(
	PID int ,
	RollNo int,
	RoundNo int,
	Status enum("PInterview","PDecision","Rejected","Hanged","Passed") DEFAULT NULL,
	PRIMARY KEY (PID,RollNo,RoundNo),
	foreign key(PID) references Postings(PID) ON DELETE CASCADE,
	foreign key(RollNo) references Student(RollNo) ON DELETE CASCADE,
	foreign key(PID,RoundNo) references PostProcedure(PID,RoundNo) ON DELETE CASCADE
);



Create Table offerdetails 
(
	PID int NOT NULL ,
	RollNo int NOT NULL ,
	Salary Numeric(12,2) NOT NULL,
	Status enum("Accepted","Declined","Pending") Default "Pending" NOT NULL,
	`Date` Date NOT NULL, 
	`Time` Time NOT NULL,
	Primary Key (PID,RollNo),
	FOREIGN KEY(PID) references Postings(PID)  ON DELETE CASCADE,
	FOREIGN KEY(RollNo) references Student(RollNo)  ON DELETE CASCADE
);
 
Create Table Subscriptions (
CID int,
Username Varchar(50),
PRIMARY KEY(CID,Username),
FOREIGN KEY(CID) references Company(Id)  ON DELETE CASCADE,
FOREIGN KEY(Username) references Login(Username)  ON DELETE CASCADE
);

Create Table Notifications (
Id int AUTO_INCREMENT PRIMARY KEY,
Username Varchar(50) NOT NULL ,
notify TEXT NOT NULL,
Category Varchar(50) NOT NULL,
FOREIGN KEY(Username) references Login(Username)  ON DELETE CASCADE
);



Create Table Blacklist (
	Name Varchar(50),
	Address Varchar(500),
	Primary Key(Name,Address)
);

 

--PrivPub MSB to LSB -- Email,PVCId,PNo,CGPA,Address
/*Views - Student jobs, Company students trigger for event*/
/* View Placed */
/*VIEW FOR FREE SLOTS*/

/* VIEW
Create Table JobsAvailable
(
    JID int PRIMARY KEY,
    MaxPay Numeric(12,2),
    MinPay Numeric(12,2),
    Shift  enum("Morning","Evening","Both"),
    foreign key(JID) references Postings(PID) ON DELETE CASCADE
);

Create Table Internships
(
    IID int PRIMARY KEY,
    PPO Bit(1),
    Duration integer,
    Stipend Numeric(12,2),
    foreign key(IID) references Postings(PID) ON DELETE CASCADE
);
*/








