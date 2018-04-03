    call createuserstudent("pass123","29ayush","Ayush","Mittal",111501035,"29ayush@gmail.com",NULL,90,"M","CSE","BTECH",9.12,NULL,00000)//





    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
    @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
    ROLLBACK;

    SET @errorq = CONCAT("SIGNAL SQLSTATE \'",@sqlstate,"\' SET MYSQL_ERRNO = ",@errno,",MESSAGE_TEXT = "\',@text,"\'");
    EXECUTE IMMEDIATE @errorq;
    END;


SET @errorq = CONCAT("SIGNAL SQLSTATE \'",@sqlstate,"\' SET MYSQL_ERRNO = ",@errno,",MESSAGE_TEXT = ",@text);
    EXECUTE IMMEDIATE @errorq;
