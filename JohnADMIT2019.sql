CREATE TABLE MM_STUDENT 
    (SID NUMBER(8,0) CONSTRAINT PK_MMSTUDENT_SID PRIMARY KEY
                     CONSTRAINT NN_MMSTUDENT_SID NOT NULL,
     SName VARCHAR(50) DEFAULT 'UNKNOWN'
                     CONSTRAINT NL_MMSTUDENT_SName NULL,
     Gender CHAR(1)  CONSTRAINT CK_MMSTUDENT_Gender_MFN
                        check( Gender IN('M','F','N'))
                     CONSTRAINT NN_MMSTUDENT_Gender NOT NULL,
     EDate DATE DEFAULT SYSDATE
                     CONSTRAINT NN_MMSTUDENT_EDate NOT NULL);
                     
                     
                                       

CREATE OR REPLACE PROCEDURE PR_UPDATE_MARK1
 (P_SID NUMBER, P_CID CHAR, P_MARK NUMBER)
 AS 
 BEGIN 
    UPDATE MM_GRADE 
    SET MARK = P_MARK
    WHERE SID = P_SID AND
          CID = P_CID;
END PR_UPDATE_MARK1;




CREATE OR REPLACE PROCEDURE PR_UPDATE_MARK2
 (P_SNAME VARCHAR2, P_CNAME VARCHAR2, P_MARK NUMBER)
 AS
    V_SID NUMBER(8,0);
    V_CID CHAR(8);
 BEGIN
    SELECT SID 
    INTO V_SID
    FROM MM_STUDENT
    WHERE SNAME = P_SNAME;
    
    SELECT CID
    INTO V_CID
    FROM MM_COURSE 
    WHERE CNAME = P_CNAME;

UPDATE MM_GRADE
SET MARK = P_MARK
WHERE SID = V_SID AND
      CID = V_CID;
      
END PR_UPDATE_MARK2;
/
SHOW ERRORS;
 

                    
SELECT * FROM MM_STUDENT;
                    
DROP TABLE MM_STUDENT;






SET pagesize 99
set linesize 132
select * 
from transaction
where portfolio_number > 535;
Select Porfolio_number,
       to char(Transaction_date, 'YYYY-MON-DD HH24:MI:SS' ) Transaction_date,

Column price_per_share format $9,999.99 heading "Price|per|share" justify right
       
COLUMN Portfolio_Number format A9 heading "portfolio number"

COLUMN Broker_Number Format A7 heading "Broker|Number"

COLUMN Exchange_Code Format A8 heading "Exchange|Code"

COLUMN Quantity Format A8 heading "Quantity" Justify right


To char(price_per_share, '$9,999.99') price_per_share,

to char(Transaction_date, 'YYYY-MON-DD HH24:MI:SS' ) Transaction_date,






LAB1b

CREATE OR REPLACE PACKAGE PKG_STUDENT
AS
PROCEDURE PRG_PR_UPDATE_MARK
    (P_SID NUMBER, P_CID CHAR, P_MARK NUMBER)
FUNCTION PKG_FN_GET_SNAME 
    (P_SID NUMBER);
RETURN VARCHAR2;
END PKG_STUDENT;
/
SHOW ERRORS;


CREATE OR REPLACE PACKAGE BODY PKG_STUDENT
AS
 FUNCTION PKG_FN_GET_SNAME
  (P_SID NUMBER)
  RETURN VARCHAR2
  IS
   V_SNAME VARCHAR2(50);
 BEGIN 
    SELECT SNAME
    INTO S_NAME
    FROM STUDENT
    WHERE SID = P_SID;
    RETURN V_SNAME
END PKG_FN_GET_SBAME;
END PKG_STUDENT;
/
SHOW ERRORS;


PROCEDURE PRG_PR_UPDATE_MARK
    (P_SID NUMBER, P_CID CHAR, P_MARK NUMBER)
    IS 
    BEGIN 
        UPDATE MM_GRADE
        SET MARK = P_MARK
        WHERE CID = P_CID AND SID = P_SID
    END PKG_PR_UPDATE_MARK;
END PKG_STUDENT;
/
SHOW ERRORSS;



CREATE IR REPLACE PACKAGE PKG_STUDENT
AS
FUNCTION PKG_FN_GET_EDATE
(P_SID Number)
RETURN DATE;
FUNCTION PKG_FN_GET_EDATE
(P_SNAME VARCHAR2)
RETURN DATE;
END PKG_STUDENT;
/ 
SHOW ERRORS;




CREATE OR REPLACE PACKAGE BODY PKG_STUDENT
IS
FUNCTION PKG_FN_GET_EDATE
(P_SID NUMBER)
RETURN DATE;
IS
V_EDATE DATE
BEGIN 
SELECT EDATE
INTO V_EDATE
FROM MM_STUDENT
WHERE SID=P_SID
END PKG_FN_GET_EDATE;
FUNCTION PKG_FN_GET_EDATE
(P_SNAME VARCHAR2)
RETURN DATE
IS
V_EDATE DATE;
BEGIN
SELECT EDATE
INTO V_EDATE
FROM MM_STUDENT
WHERE SNAME= P_SNAME;
RETURN V_EDATE;
END PKG_FN_GET_EDATE;
END PKG_STUDENT;
/
SHOW ERRORS;





CREATE OR RELPACE PROCEDURE PR_POPULATE_NEW_TABLE
IS
V_CID CHAR(8)
V_SID NUMBER(8,0)
V_MARK NUMBER (5,2)
CURSOR C_GRADES IS SELECT CID, SID, MARK
                   FROM MM_GRADE
                   WHERE MARK < 50 OR
                         MARK >= 80;
BEGIN
OPEN C_GRADES;
FETCH C_GRADES INO V_CID, V_SID, V_MARK;
WHILE C_GRADE%FOUND LOOP
    IF V_MARK < 50 THEN 
    INSERT INTO MM_HELP
    (CID,SID,MARK)
    VALUES
    (V_CID,V_SID,V_MARK);
    ELSE INTO MM_HONOUR
        (CID,SID,MARK)
        VALUES
        (V_CID,V_SID,V_MARK)
    END IF;
    FETCH C_GRADES INTO V_CID,V_SID,V_MARK;
END LOOP;
END PR_POPULATE_NEW_TABLES






CREATE OR REPLACE FUNCTION FN_SHOW_COURSE_NAMES AND MARKS
(P_SID NUMBER)
RETURN VARCHAR2
AS 
V_CNAME VARCHAR2(50);
V_MARK NUMBER(5,2);
V_OUTPUT VARCHAR2(1500);
CURSOR C_NAME IS SELECT C.CNAME, G.MARK
                 FROM MM_COURSE C, MM_GRADE G 
                 WHERE G.SID = P.SID AND
                        G.CID = C.CID;
BEGIN
OPEN C_NAME;
FETCH C_CNAME INTO V_NAME, V_MARK;
IF C_CNAME%NOTFOUND THEN
    V_OUTPUT := 'THE STUDENT'||'TO_CHAR'
ELSE
    WHILE C_CNAME%FOUND LOOP
        V_OUTPUT := V_OUTPUT || V_CNAME || '##' ||
        FETCH C_CNAME INTO V_CNAME, MARK
        END LOOP;
END IF;
CLOSE C_NAMES;
RETURN V_OUTPUT;
END FN_SHOW_COURSE_NAMES_AND_MARKS
/
SHOW ERRORS;







CREATE OR REPLACE FUNCTION FN_GET_EDATE1
(P_SNAME VARCHAR2)
RETURN DATE
AS 
V_EDATE DATE;
BEGIN
    SELECT EDATE INTO V_EDATE
    FROM MM_STUDENT
    WHERE SNAME = P_SNAME;
    RETURN V_EDATE;
END FN_GET_EDATE1;
/
SHOW ERRORS;







CREATE OR REPLACE FUNCTION FN_GET_EDATE2
(P_SNAME VARCHAR2)
RETURN DATE
AS 
V_EDATE DATE;
V_COUNT NUMBER(10);
BEGIN
    SELECT NVL(COUNT(SID),0)
    INTO V_COUNT
    FROM MM_STUDENT
    WHERE LOWER(SNAME) = LOWER(P_SNAME);
IF V_COUNT = 1 THEN
    SELECT EDATE
    INTO V_EDATE
    FROM MM_STUDENT
    RETURN V_EDATE;
    WHERE SNAME = P_SNAME;
ELSEIF V_COUNT = 0 THEN
    V_EDATE := TO_DATE('31-12-9999','DD-MM-YYYY') ;
ELSE 
    V_EDATE := TO_DATE('01-01-0001','DD-MM-YYYY') ;
END IF;
RETURN V_EDATE;
END FN_GET_EDATE2;
/
SHOW ERRORS;






CREATE OR REPLACE FUNCTION FN_GET_EDATE3
(P_SNAME VARCHAR2)
RETURN DATE
AS 
V_EDATE DATE;
BEGIN 
    SELECT EDATE
    INTO V_EDATE
    FROM MM_STUDENT
    WHERE LOWER(SNAME) = LOWER(P_SNAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN TO_DATE('31-12-9999','DD-MM-YYYY');
    WHEN TOO_MANY_ROWS THEN
        RETURN TO_DATE('01-01-0001','DD-MM-YYYY');
    WHEN OTHERS THEN 
        RETURN TO_DATE('04-03-0403','DD-MM-YYYY');
RETURN V_EDATE;
    
SHOW ERRORS;








PROCEDURE PR_UPDATE_MARK1
    (P_SID NUMBER, P_CID CHAR, P_MARK NUMBER)
    IS 
    BEGIN 
        UPDATE MM_GRADE
        SET MARK = P_MARK
        WHERE CID = P_CID AND SID = P_SID
END PR_UPDATE_MARK;
/
SHOW ERRORS;




create or PROCEDURE PR_UPDATE_MARK2
    (P_SID NUMBER, P_CID CHAR, P_MARK NUMBER)
    IS 
        v_mark number(5,2);
        e_invalid_mark exception;
    BEGIN 
        if p_mark between 0 and 100 then
        select mark
        into v_mark
        from mm_grade
        WHERE CID = P_CID AND 
        upper(SID) = upper(P_SID);
        update mm_grade 
        set mark = p_mark
        where sid = p_sid 
        and upper(cid) = upper(p_cid)
        else
            raise e_invalid_mark;
exception 
    when no_data_found then 
        raise_application_error(-20700,'no mark exists');
    when e_invalid_mark then 
        raise_application_error(-20855,'mark mas be between 0 and 100');
    when others then
        raise_application_error(-20123,'contact tech support');
END PR_UPDATE_MARK2;
/
SHOW ERRORS;




insert into mm_grade
    (sid, cid, mark)
values 
    (12345, 'bc4536', 99);
    
    
    
create or replace trigger tr_biur_mmgrade_bcs_courses_bad
before insert or update of cid
on mm_grade
for each row
begin
    if upper(substring(:new. cid,1,3)) = 'BCS' then
        raise_application_error(-20099,'bcs courses are not current');
    end if;
end tr_biur_mmgrade_bcs_courses_bad;
/
show errors;







