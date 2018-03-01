create or replace role role_admin;
grant ALL PRIVILIGES ON placement_cell.* TO role_admin;

create or replace role role_moderator;
grant ALL PRIVILEGES ON placement_cell.* TO role_moderator;

create role role_student;
grant SELECT  ON placement_cell.publictaken TO role_student;
grant SELECT  ON placement_cell.publicstudent TO role_student;
grant SELECT  ON placement_cell.freeslots TO role_student;
grant SELECT  ON placement_cell.Courses TO role_student;
grant SELECT  ON placement_cell.Departments TO role_student;
grant SELECT  ON placement_cell.Jobs TO role_student;
grant SELECT  ON placement_cell.Internships TO role_student;
grant SELECT  ON placement_cell.Postings TO role_student;
grant SELECT  ON placement_cell.PostProcedure TO role_student;
grant SELECT  ON placement_cell.PostProfileBranch TO role_student;
grant EXECUTE ON PROCEDURE placement_cell.getshortlist TO role_student;
grant EXECUTE ON PROCEDURE placement_cell.studentpriv TO role_student;
grant EXECUTE ON PROCEDURE placement_cell.takenpriv TO role_student;

create role role_professor;
grant SELECT  ON placement_cell.publictaken TO role_professor;
grant SELECT  ON placement_cell.publicstudent TO role_professor;
grant SELECT  ON placement_cell.freeslots TO role_professor;
grant SELECT  ON placement_cell.Courses TO role_professor;
grant SELECT  ON placement_cell.Departments TO role_professor;
grant SELECT  ON placement_cell.Jobs TO role_professor;
grant SELECT  ON placement_cell.Internships TO role_professor;
grant SELECT  ON placement_cell.Postings TO role_professor;
grant SELECT  ON placement_cell.PostProcedure TO role_professor;
grant SELECT  ON placement_cell.PostProfileBranch TO role_professor;
grant SELECT  ON placement_cell.Professor TO role_professor;
grant SELECT  ON placement_cell.Student TO role_professor;
grant SELECT  ON placement_cell.Taken TO role_professor;

grant INSERT ON placement_cell.Student To role_professor;
grant EXECUTE ON PROCEDURE placement_cell.getshortlist to role_professor;

create role role_cr;
grant SELECT  ON placement_cell.publictaken TO role_cr;
grant SELECT  ON placement_cell.publicstudent TO role_cr;
grant SELECT  ON placement_cell.freeslots TO role_cr;
grant SELECT  ON placement_cell.Courses TO role_cr;
grant SELECT  ON placement_cell.Departments TO role_cr;
grant SELECT  ON placement_cell.Jobs TO role_cr;
grant SELECT  ON placement_cell.Internships TO role_cr;
grant SELECT  ON placement_cell.Postings TO role_cr;
grant SELECT  ON placement_cell.PostProcedure TO role_cr;

grant EXECUTE ON PROCEDURE placement_cell.addjobs TO role_cr;
grant EXECUTE ON PROCEDURE placement_cell.addinternship TO role_cr;
grant EXECUTE ON PROCEDURE placement_cell.getshortlist TO role_cr;



