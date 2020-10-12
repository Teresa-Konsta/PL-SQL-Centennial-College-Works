/* Tereza Konstari 301065539 
Assignment 2*/

DROP TABLE dd_donor CASCADE CONSTRAINTS;
DROP TABLE dd_project CASCADE CONSTRAINTS;
DROP TABLE dd_status CASCADE CONSTRAINTS;
DROP TABLE dd_pledge CASCADE CONSTRAINTS;
DROP TABLE dd_payment CASCADE CONSTRAINTS;
CREATE TABLE DD_Donor (
	idDonor number(4),
	Firstname varchar2(15),
	Lastname varchar2(30),
                  Typecode CHAR(1),
	Street varchar2(40),
	City varchar2(20),
	State char(2),
	Zip varchar2(9),
	Phone varchar2(10),
	Fax varchar2(10),
	Email varchar2(25),
                  News char(1),
	dtentered date DEFAULT SYSDATE,
	CONSTRAINT donor_id_pk PRIMARY KEY(idDonor) );
CREATE TABLE DD_Project (
                   idProj number(6),
                   Projname varchar2(60),
                   Projstartdate DATE,
                   Projenddate DATE,
                   Projfundgoal number(12,2),
                   ProjCoord varchar2(20),
                   CONSTRAINT project_id_pk PRIMARY KEY(idProj),
                   CONSTRAINT project_name_uk  UNIQUE (Projname)  );      
CREATE TABLE DD_Status (
                   idStatus number(2),
                   Statusdesc varchar2(15),
                   CONSTRAINT status_id_pk PRIMARY KEY(idStatus) );     
CREATE TABLE DD_Pledge (
                   idPledge number(5),
                   idDonor number(4),
                   Pledgedate DATE,
                   Pledgeamt number(8,2),
                   idProj number(5),
                   idStatus number(2),
                   Writeoff number(8,2),
                   paymonths number(3),
                   Campaign number(4),
                   Firstpledge char(1),
                   CONSTRAINT pledge_id_pk PRIMARY KEY(idPledge),
                   CONSTRAINT pledge_idDonor_fk FOREIGN KEY (idDonor)
                           REFERENCES dd_donor (idDonor), 
                   CONSTRAINT pledge_idProj_fk FOREIGN KEY (idProj)
                           REFERENCES dd_project (idProj),
                   CONSTRAINT pledge_idStatus_fk FOREIGN KEY (idStatus)
                           REFERENCES dd_status (idStatus));                   
CREATE TABLE DD_Payment (
                   idPay number(6),
                   idPledge number(5),
                   Payamt number(8,2),
                   Paydate DATE,
                   Paymethod char(2),
                   CONSTRAINT payment_id_pk PRIMARY KEY(idPay),
                   CONSTRAINT pay_idpledge_fk FOREIGN KEY (idPledge)
                           REFERENCES dd_pledge (idPledge) );                   
INSERT INTO dd_donor  
  VALUES (301, 'Mary', 'Treanor', 'I','243 main St.', 'Norfolk', 'VA','23510',NULL,NULL,'mtrea492@mdv.com','Y','01-SEP-2012');
INSERT INTO dd_donor  
  VALUES (302, 'Patrick', 'Lee', 'I','11 Hooper St.', 'Norfolk', 'VA','23510','7572115445',NULL,'pleeNorf@gmail.com','N','09-SEP-2012');
INSERT INTO dd_donor  
  VALUES (303, 'Terry', 'Venor', 'I','556 Loop Lane.', 'Chesapeake', 'VA','23320',NULL,NULL,'tervenr@drw.edu','Y','18-SEP-2012');
INSERT INTO dd_donor  
  VALUES (304, 'Sherry', 'Pane', 'I','Center Blvd.', 'Virginia Beach', 'VA','23455',NULL,NULL,'toppane@yahoo.com','Y','21-SEP-2012');
INSERT INTO dd_donor  
  VALUES (305, 'Thomas', 'Sheer', 'I','66 Train St.', 'Chesapeake', 'VA','23322','7579390022',NULL,'tls3488@sheer.com','Y','01-MAR-2013');
INSERT INTO dd_donor  
  VALUES (306, NULL, 'Coastal Developers', 'B','3667 Shore Dr.', 'Virginia Beach', 'VA','23450','8889220004',NULL,'coastVA@cdev.com','Y','30-SEP-2012');
INSERT INTO dd_donor  
  VALUES (307, NULL, 'VA Community Org', 'G','689 Bush Dr.', 'Norfolk', 'VA','23513','7578337467','7578337468','vacmorg@biz.com','Y','03-OCT-2012');
INSERT INTO dd_donor  
  VALUES (308, 'Betty', 'Konklin', 'I','11 Shark Ln.', 'Virginia Beach', 'VA','23455','7574550087',NULL,'shark11@cox.net','N','04-OCT-2012');
INSERT INTO dd_donor  
  VALUES (309, 'Jim', 'Tapp', 'I','200 Pine Tree Blvd.', 'Chesapeake', 'VA','23320','',NULL,'','N','08-OCT-2012');
INSERT INTO dd_donor  
  VALUES (310, NULL, 'Unique Dezigns', 'B','Connect Circle Unit 12', 'Chesapeake', 'VA','23320','7574442121',NULL,'UDezigns@cox.net','Y','11-SEP-2012');
INSERT INTO dd_project
  VALUES (500,'Elders Assistance League', '01-SEP-2012','31-OCT-2012',15000,'Shawn Hasee');
INSERT INTO dd_project
  VALUES (501,'Community food pantry #21 freezer equipment', '01-OCT-2012','31-DEC-2012',65000,'Shawn Hasee');
INSERT INTO dd_project
  VALUES (502,'Lang Scholarship Fund', '01-JAN-2013','01-NOV-2013',100000,'Traci Brown');
INSERT INTO dd_project
  VALUES (503,'Animal shelter Vet Connect Program', '01-DEC-2012','30-MAR-2013',25000,'Traci Brown');
INSERT INTO dd_project
  VALUES (504,'Shelter Share Project 2013', '01-FEB-2013','31-JUL-2013',35000,'Traci Brown');
INSERT INTO dd_status
  VALUES (10,'Open');
INSERT INTO dd_status
  VALUES (20,'Complete');
INSERT INTO dd_status
  VALUES (30,'Overdue');
INSERT INTO dd_status
  VALUES (40,'Closed');
INSERT INTO dd_status
  VALUES (50,'Hold');
INSERT INTO dd_pledge
   VALUES (100,303,'18-SEP-2012',80,500,20,NULL,0,738,'Y');
INSERT INTO dd_pledge
   VALUES (101,304,'21-SEP-2012',35,500,20,NULL,0,738,'Y');
INSERT INTO dd_pledge
   VALUES (102,310,'01-OCT-2012',500,501,20,NULL,0,749,'Y');
INSERT INTO dd_pledge
   VALUES (103,307,'03-OCT-2012',2000,501,20,NULL,0,749,'N');
INSERT INTO dd_pledge
   VALUES (104,308,'04-OCT-2012',240,501,10,NULL,12,749,'Y');
INSERT INTO dd_pledge
   VALUES (105,309,'08-OCT-2012',120,501,10,NULL,12,749,'Y');
INSERT INTO dd_pledge
   VALUES (106,301,'12-OCT-2012',75,500,20,NULL,0,738,'N');
INSERT INTO dd_pledge
   VALUES (107,302,'15-OCT-2012',1200,501,10,NULL,24,749,'Y');
INSERT INTO dd_pledge
   VALUES (108,308,'20-JAN-2013',480,503,10,NULL,24,790,'N');
INSERT INTO dd_pledge
   VALUES (109,301,'01-FEB-2013',360,503,10,NULL,12,790,'N');
INSERT INTO dd_pledge
   VALUES (110,303,'01-MAR-2013',300,504,10,NULL,12,756,'N');
INSERT INTO dd_pledge
   VALUES (111,306,'01-MAR-2013',1500,504,20,NULL,0,756,'Y');
INSERT INTO dd_pledge
   VALUES (112,309,'16-MAR-2013',240,504,10,NULL,12,756,'N');
INSERT INTO dd_payment
   VALUES (1425,100,80,'18-SEP-2012','CC');
INSERT INTO dd_payment
   VALUES (1426,101,35,'21-SEP-2012','DC');
INSERT INTO dd_payment
   VALUES (1427,102,500,'01-OCT-2012','CH');
INSERT INTO dd_payment
   VALUES (1428,103,2000,'03-OCT-2012','CH');
INSERT INTO dd_payment
   VALUES (1429,106,75,'12-OCT-2012','CC');
INSERT INTO dd_payment
   VALUES (1430,104,20,'01-NOV-2012','CC');
INSERT INTO dd_payment
   VALUES (1431,105,10,'01-NOV-2012','CC');
INSERT INTO dd_payment
   VALUES (1432,107,50,'01-NOV-2012','CC');
INSERT INTO dd_payment
   VALUES (1433,104,20,'01-DEC-2012','CC');
INSERT INTO dd_payment
   VALUES (1434,105,10,'01-DEC-2012','CC');
INSERT INTO dd_payment
  VALUES (1435,107,50,'01-DEC-2012','CC');
INSERT INTO dd_payment
   VALUES (1436,104,20,'01-JAN-2013','CC');
INSERT INTO dd_payment
   VALUES (1437,105,10,'01-JAN-2013','CC');
INSERT INTO dd_payment
   VALUES (1438,107,50,'01-JAN-2013','CC');
INSERT INTO dd_payment
   VALUES (1439,104,20,'01-FEB-2013','CC');
INSERT INTO dd_payment
   VALUES (1440,105,10,'01-FEB-2013','CC');
INSERT INTO dd_payment
   VALUES (1441,107,50,'01-FEB-2013','CC');
INSERT INTO dd_payment
   VALUES (1442,108,20,'01-FEB-2013','CC');
INSERT INTO dd_payment
   VALUES (1443,109,30,'01-FEB-2013','CC');
INSERT INTO dd_payment
   VALUES (1444,104,20,'01-MAR-2013','CC');
INSERT INTO dd_payment
   VALUES (1445,105,10,'01-MAR-2013','CC');
INSERT INTO dd_payment
   VALUES (1446,107,50,'01-MAR-2013','CC');
INSERT INTO dd_payment
   VALUES (1447,108,20,'01-MAR-2013','CC');
INSERT INTO dd_payment
   VALUES (1448,109,30,'01-MAR-2013','CC');
INSERT INTO dd_payment
   VALUES (1449,110,25,'01-MAR-2013','CC');
INSERT INTO dd_payment
   VALUES (1450,111,1500,'01-MAR-2013','CH');
INSERT INTO dd_payment
   VALUES (1451,104,20,'01-APR-2013','CC');
INSERT INTO dd_payment
   VALUES (1452,105,10,'01-APR-2013','CC');
INSERT INTO dd_payment
   VALUES (1453,107,50,'01-APR-2013','CC');
INSERT INTO dd_payment
   VALUES (1454,108,20,'01-APR-2013','CC');
INSERT INTO dd_payment
   VALUES (1455,109,30,'01-APR-2013','CC');
INSERT INTO dd_payment
   VALUES (1456,110,25,'01-APR-2013','CC');
INSERT INTO dd_payment
   VALUES (1457,112,20,'01-APR-2013','CC');
INSERT INTO dd_payment
   VALUES (1458,104,20,'01-MAY-2013','CC');
INSERT INTO dd_payment
   VALUES (1459,105,10,'01-MAY-2013','CC');
INSERT INTO dd_payment
   VALUES (1460,107,50,'01-MAY-2013','CC');
INSERT INTO dd_payment
   VALUES (1461,108,20,'01-MAY-2013','CC');
INSERT INTO dd_payment
   VALUES (1462,109,30,'01-MAY-2013','CC');
INSERT INTO dd_payment
   VALUES (1463,110,25,'01-MAY-2013','CC');
INSERT INTO dd_payment
   VALUES (1464,112,20,'01-MAY-2013','CC');
COMMIT;

/*Assignment 3-9: Retrieving Pledge Totals
Create a PL/SQL block that retrieves and displays information for a specific project based on
Project ID. Display the following on a single row of output: project ID, project name, number of
pledges made, total dollars pledged, and the average pledge amount.*/

DECLARE
    proj_id dd_project.idproj%TYPE;
    proj_name dd_project.projname%TYPE;
    pledge_count dd_pledge.pledgeamt%TYPE;
    pledge_sum dd_pledge.pledgeamt%TYPE;
    pledge_average dd_pledge.pledgeamt%TYPE;
BEGIN
    SELECT dd_project.idproj, dd_project.projname, COUNT(dd_pledge.pledgeamt), SUM(dd_pledge.pledgeamt), AVG(dd_pledge.pledgeamt)
    INTO proj_id, proj_name, pledge_count, pledge_sum, pledge_average
    FROM dd_pledge, dd_project
    WHERE dd_project.idProj = dd_pledge.idProj AND dd_project.idProj = &proj_id
    GROUP BY dd_project.idproj, dd_project.projname;
    DBMS_OUTPUT.PUT_LINE('Project ID:' || proj_id || 'Project Name:' || proj_name || 'Number of pledges made:' || pledge_count || 'Total dollars pledged:' || pledge_sum|| 'Average pledge amount:' || pledge_average );
END;

/*Assignment 3-10: Adding a Project
Create a PL/SQL block to handle adding a new project. Create and use a sequence named
DD_PROJID_SEQ to handle generating and populating the project ID. The first number issued
by this sequence should be 530, and no caching should be used. Use a record variable to
handle the data to be added. Data for the new row should be the following: project name = HK
Animal Shelter Extension, start = 1/1/2013, end = 5/31/2013, and fundraising goal = $65,000.
Any columns not addressed in the data list are currently unknown.*/

CREATE SEQUENCE DD_PROJID_SEQ
    START WITH 530
    INCREMENT BY 1
    NOCACHE;

DECLARE
    proj_name dd_project.projname%TYPE := 'HK Animal Shelter Extension';
    proj_startdate dd_project.projstartdate%TYPE := '1-JAN-2013';
    proj_enddate dd_project.projenddate%TYPE := '31-MAY-2013';
    proj_fundgoal dd_project.projfundgoal%TYPE := 65000;
BEGIN
    INSERT INTO dd_project (idproj, projname, projstartdate, projenddate, projfundgoal)
    VALUES (DD_PROJID_SEQ.NEXTVAL, proj_name, proj_startdate, proj_enddate, proj_fundgoal);
    COMMIT;
END;

/*Assignment 3-11: Retrieving and Displaying Pledge Data
Create a PL/SQL block to retrieve and display data for all pledges made in a specified month.
One row of output should be displayed for each pledge. Include the following in each row
of output:
• Pledge ID, donor ID, and pledge amount
• If the pledge is being paid in a lump sum, display “Lump Sum.”
• If the pledge is being paid in monthly payments, display “Monthly - #” (with the #
representing the number of months for payment).
• The list should be sorted to display all lump sum pledges first.*/

DECLARE
    rec_pledges dd_pledge%ROWTYPE;
    startdate dd_pledge.Pledgedate%TYPE := '01-Jan-2012';
    enddate dd_pledge.Pledgedate%TYPE := '31-Jan-2012';
BEGIN
    FOR rec_pledges IN (
    SELECT idPledge, idDonor, pledgeamt,
        CASE
            WHEN paymonths = 0 THEN 'Lump Sum'
            ELSE 'Monthly - ' || paymonths
        END AS monthly_payment
        FROM dd_pledge
    WHERE Pledgedate >= startdate AND Pledgedate <= enddate
    ORDER BY paymonths)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Pledge ID: ' || rec_pledges.idpledge || ' Donor ID: ' || rec_pledges.iddonor || ' Pledge amount: ' || to_char(rec_pledges.pledgeamt,'$9999.99') ||
                            ' Monthly Payments: ' || rec_pledges.monthly_payment);
    END LOOP;
END;

/*Assignment 3-12: Retrieving a Specific Pledge
Create a PL/SQL block to retrieve and display information for a specific pledge. Display the
pledge ID, donor ID, pledge amount, total paid so far, and the difference between the pledged
amount and total paid amount.*/

DECLARE
    rec_pledges dd_pledge%ROWTYPE;
    pledge_total dd_pledge.pledgeamt%TYPE;
    pledge_amount dd_pledge.pledgeamt%TYPE;
    pledge_months NUMBER(10);
BEGIN
    SELECT *
        INTO rec_pledges
        FROM dd_pledge
        WHERE idPledge = &idPledge;
        
     pledge_months := rec_pledges.paymonths;
    
    IF rec_pledges.paymonths = 0 THEN pledge_total := rec_pledges.Pledgeamt;
    ELSE pledge_total :=  pledge_months * (rec_pledges.Pledgeamt / rec_pledges.paymonths);
    END IF;
    
     pledge_amount := rec_pledges.Pledgeamt - pledge_total;
     
    DBMS_OUTPUT.PUT_LINE('Pledge ID: ' || rec_pledges.idpledge || ' Donor ID: ' || rec_pledges.iddonor || ' Pledge amount: ' || to_char(rec_pledges.pledgeamt,'$9999.99') ||
                            ' Difference between the pledged amount and total paid amount: ' || pledge_amount);
END;

/*Assignment 3-13: Modifying Data
Create a PL/SQL block to modify the fundraising goal amount for a specific project. In addition,
display the following information for the project being modified: project name, start date,
previous fundraising goal amount, and new fundraising goal amount.*/

DECLARE
    proj_id dd_project.idproj%TYPE;
    proj_name dd_project.projname%TYPE;
    start_date dd_project.projstartdate%TYPE;
    fundraising_goal_amount dd_project.projfundgoal%TYPE;
    new_fundraising_goal dd_project.projfundgoal%TYPE := 20000;
BEGIN
    SELECT idProj, projname, projstartdate, projfundgoal
    INTO proj_id, proj_name, start_date, fundraising_goal_amount
    FROM dd_project
    WHERE dd_project.idProj = &proj_id;
        
    UPDATE dd_project
    SET projfundgoal = new_fundraising_goal;
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Project ID: ' || proj_id || ' Project name: ' || proj_name || ' Start date: ' || start_date ||
                            ' Previous fundraising goal amount: ' || fundraising_goal_amount || ' New fundraising goal amount: ' || new_fundraising_goal);
END;