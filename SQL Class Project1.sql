
USE MASTER;

CREATE DATABASE EMPLOYEE;

GO
USE EMPLOYEE;

CREATE TABLE EMPLOYEE (
EMP_ID INTEGER,
EMP_LNAME VARCHAR(15) NOT NULL,
EMP_FNAME VARCHAR (15) NOT NULL,
EMP_INIT CHAR(1),
EMP_HIRE_DATE DATE NOT NULL,
EMP_TYPE CHAR(1),
PRIMARY KEY(EMP_ID));

CREATE TABLE PILOT(
EMP_ID INTEGER PRIMARY KEY,
PIL_LICENSE CHAR(3) NOT NULL CONSTRAINT PIL_LICNESE_CHK CHECK (PIL_LICENSE IN ('ATP', 'COM')),
PIL_RATING VARCHAR (15) NOT NULL,
PIL_MED_TYPE INTEGER NOT NULL CHECK (PIL_MED_TYPE IN (1,2,3)),
FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEE);

CREATE TABLE MECHANIC(
EMP_ID INTEGER PRIMARY KEY,
MECH_CERT_DATE DATE NOT NULL,
FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE);

CREATE TABLE ACCOUNTANT(
EMP_ID INTEGER PRIMARY KEY,
ACC_CPA_DATE DATE NOT NULL,
FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE);

CREATE TABLE DEPENDENT (
EMP_ID INTEGER,
DEP_NUM INTEGER,
DEP_LNAME VARCHAR (15) NOT NULL,
DEP_FNAME VARCHAR (15) NOT NULL,
DEP_RELATION VARCHAR (15) NOT NULL,
PRIMARY KEY (EMP_ID, DEP_NUM),
FOREIGN KEY( EMP_ID) REFERENCES EMPLOYEE(EMP_ID));

BEGIN TRANSACTION
INSERT INTO EMPLOYEE VALUES (1001, 'SCOTT', 'JOHN', 'H','2016-08-08', 'M');
INSERT INTO EMPLOYEE VALUES (1002, 'JANE','MARY', NULL, '2015-01-11','A');
INSERT INTO EMPLOYEE VALUES (1003, 'DOE', 'JOHN', NULL,'2014-04-05', 'A');
INSERT INTO EMPLOYEE VALUES (1004, 'DOE', 'JANE', 'M' , '2012-02-05','M');
INSERT INTO EMPLOYEE VALUES (1005, 'HAWK', 'ETHAN', NULL,'2016-11-15', 'M');
INSERT INTO EMPLOYEE VALUES (1006, 'DIMON', 'JAMIE','C', '2010-09-12','E');
INSERT INTO EMPLOYEE VALUES (1007, 'McMAHAN', 'ANITA', NULL,'2013-08-09', 'A');
INSERT INTO EMPLOYEE VALUES (1008, 'WILLIAMS', 'LAURIE', 'K', '2012-05-07','P');
INSERT INTO EMPLOYEE VALUES (1009, 'PRUITT', 'JAMES', NULL,'2015-08-07', 'P');
INSERT INTO EMPLOYEE VALUES (1010, 'MCMASTER', 'TIM', 'A', '2014-02-09','P');

BEGIN TRANSACTION
INSERT INTO ACCOUNTANT VALUES (1002, '2017-04-04');
INSERT INTO ACCOUNTANT VALUES (1003, '2017-04-13');
INSERT INTO ACCOUNTANT VALUES (1007, '2016-08-12');

BEGIN TRANSACTION
INSERT INTO MECHANIC VALUES (1001, '2017-03-06');
INSERT INTO MECHANIC VALUES (1004, '2017-03-23');
INSERT INTO MECHANIC VALUES (1005, '2016-08-09');

BEGIN TRANSACTION
INSERT INTO PILOT VALUES (1008, 'ATP', 'CF1', '1');
INSERT INTO PILOT VALUES (1009, 'COM', 'CF2', '2');
INSERT INTO PILOT VALUES (1010, 'ATP', 'CF3', '1');

BEGIN TRANSACTION
INSERT INTO DEPENDENT VALUES (1003,1, 'DOE', 'SARAH', 'DAUGHTER');
INSERT INTO DEPENDENT VALUES (1003, 2, 'DOE', 'JIM', 'SON');
INSERT INTO DEPENDENT VALUES (1004,  1, 'SCOTT', 'SARAH', 'DAUGHTER');
INSERT INTO DEPENDENT VALUES (1005, 1, 'CRAMER', 'JIM', 'SON');



SELECT * FROM EMPLOYEE
SELECT * FROM DEPENDENT
SELECT * FROM PILOT
SELECT * FROM ACCOUNTANT
SELECT * FROM MECHANIC
3
SELECT E.EMP_ID, EMP_LNAME, EMP_FNAME, EMP_INIT,EMP_HIRE_DATE, EMP_TYPE,
ACC_CPA_DATE, MECH_CERT_DATE
FROM EMPLOYEE AS E LEFT JOIN PILOT AS P ON E.EMP_ID=P.EMP_ID
LEFT JOIN MECHANIC AS M ON E.EMP_ID =M.EMP_ID
LEFT JOIN ACCOUNTANT AS A ON E.EMP_ID= A.EMP_ID
ORDER BY 1;

4
SELECT EMP_TYPE, COUNT (*) AS 'EMPLOYEE COUNT'
FROM EMPLOYEE
GROUP BY EMP_TYPE
ORDER BY 'EMPLOYEE COUNT' DESC;

5
SELECT E.EMP_ID, EMP_LNAME, EMP_FNAME, DEP_LNAME, DEP_FNAME, DEP_RELATION
FROM EMPLOYEE AS E INNER JOIN DEPENDENT AS D ON E.EMP_ID= D.EMP_ID;

--6
SELECT E.EMP_ID, EMP_LNAME, EMP_FNAME, EMP_TYPE, DEP_LNAME, DEP_FNAME, DEP_RELATION
FROM EMPLOYEE AS E INNER JOIN DEPENDENT AS D ON E.EMP_ID= D.EMP_ID
INNER JOIN MECHANIC AS M ON E.EMP_ID= M.EMP_ID;