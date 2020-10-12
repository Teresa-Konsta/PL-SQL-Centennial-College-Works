/* Assignment 4
Tereza Konstari, 301065539*/


SET SERVEROUTPUT ON;

DROP TABLE Accounts CASCADE CONSTRAINTS;
DROP TABLE Pet_owner CASCADE CONSTRAINTS;
DROP TABLE Service_provider CASCADE CONSTRAINTS;
DROP TABLE Pet CASCADE CONSTRAINTS;
DROP TABLE Services CASCADE CONSTRAINTS;
DROP TABLE ServiceItem CASCADE CONSTRAINTS;
DROP TABLE Payment CASCADE CONSTRAINTS;
DROP SEQUENCE increment_id_seq;

CREATE TABLE Accounts(
account_id NUMBER(10) PRIMARY KEY,
first_name VARCHAR2(15),
last_name VARCHAR2(15),
login VARCHAR2(10) UNIQUE,
password VARCHAR2(10),
address VARCHAR2(30) UNIQUE,
city VARCHAR2(20),
province VARCHAR2(10),
phone NUMBER(10) UNIQUE,
email VARCHAR2(15) UNIQUE,
registration_date DATE
);

CREATE TABLE Pet_owner(
account_id NUMBER(10),
pet_type VARCHAR2(15) PRIMARY KEY,
CONSTRAINT FK_account_id
FOREIGN KEY (account_id)
REFERENCES Accounts(account_id)
);

CREATE TABLE Service_provider(
account_id NUMBER(10),
pet_type VARCHAR2(15),
service_type VARCHAR2(15),
availability CHAR(1),
PRIMARY KEY(pet_type, service_type),
CONSTRAINT FK_account_id2
FOREIGN KEY (account_id)
REFERENCES Accounts(account_id)
);

CREATE TABLE Pet(
pet_id NUMBER(10) PRIMARY KEY,
pet_type VARCHAR2(15),
service_type VARCHAR2(15),
breed VARCHAR2(15),
gender CHAR(1),
age NUMBER(2),
CONSTRAINT FK_pet_type
FOREIGN KEY (pet_type)
REFERENCES Pet_owner(pet_type), 
CONSTRAINT FK_pet_type2
FOREIGN KEY (pet_type,service_type)
REFERENCES Service_provider(pet_type,service_type)
);

CREATE TABLE Services(
service_id NUMBER(10) PRIMARY KEY,
service_type VARCHAR2(15),
service_price NUMBER(5,2),
service_location VARCHAR2(15)
);

CREATE TABLE ServiceItem(
item_id NUMBER(10) PRIMARY KEY,
service_id NUMBER(10),
order_id NUMBER(10),
date_from DATE,
date_to DATE,
customer# NUMBER(10),
CONSTRAINT FK_service_id
FOREIGN KEY (service_id)
REFERENCES Services(service_id)
);

CREATE TABLE Payment(
service_id NUMBER(10),
card_type VARCHAR2(10),
card# NUMBER(10),
cvv NUMBER(3),
exp_date DATE,
holder_name VARCHAR2(30),
amount NUMBER(5,2),
CONSTRAINT FK_service_id2
FOREIGN KEY (service_id)
REFERENCES Services(service_id)
);

/Sequence/
CREATE SEQUENCE increment_id_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;

INSERT INTO Accounts
VALUES(increment_id_seq.NEXTVAL, 'Smith', 'John', 'jsmth', 'secret123', '821 Progress Ave', 'Toronto', 'Ontario', 1234567, 'jsmth@mail.com', '7-Aug-2020');
INSERT INTO Accounts
VALUES(increment_id_seq.NEXTVAL, 'Brown', 'Joe', 'jdwn', 'secret456', '1300 Sheppard Avenue W', 'Scarborough', 'Ontario', 5671234, 'jdwn@mail.com', '8-Aug-2020');
INSERT INTO Accounts
VALUES(increment_id_seq.NEXTVAL, 'Green', 'Ann', 'agrn', 'secret789', '60 Carl Hall Road', 'North York', 'Ontario', 1267345, 'agrn@mail.com', '9-Aug-2020');

INSERT INTO Pet_owner
VALUES(1, 'cat');
INSERT INTO Pet_owner
VALUES(2, 'dog');

INSERT INTO Service_provider
VALUES(increment_id_seq.NEXTVAL, 'cat', 'petsitting');
INSERT INTO Service_provider
VALUES(increment_id_seq.NEXTVAL, 'dog', 'petcaring');

INSERT INTO Pet
VALUES(increment_id_seq.NEXTVAL, 'cat', 'petsitting', 'Persian', 'F', 3);
INSERT INTO Pet
VALUES(increment_id_seq.NEXTVAL, 'dog', 'Bishon', 'petcaring', 'M', 5);

INSERT INTO Services
VALUES(increment_id_seq.NEXTVAL, 'petsitting', 10.00, 'Toronto');
INSERT INTO Services
VALUES(increment_id_seq.NEXTVAL, 'petcaring', 15.00, 'Scarborough');

INSERT INTO ServiceItem
VALUES(increment_id_seq.NEXTVAL, increment_id_seq.NEXTVAL, increment_id_seq.NEXTVAL, '10-Aug-2020', '11-Aug-2020', increment_id_seq.NEXTVAL);
INSERT INTO ServiceItem
VALUES(increment_id_seq.NEXTVAL, increment_id_seq.NEXTVAL, increment_id_seq.NEXTVAL, '11-Aug-2020', '12-Aug-2020', increment_id_seq.NEXTVAL);

INSERT INTO Payment
VALUES(increment_id_seq.NEXTVAL, 'visa', 159357258456, '19-Jun-2024', 'Tereza Konstari', 10.00);
INSERT INTO Payment
VALUES(increment_id_seq.NEXTVAL,'mastercard', 951753852456, '21-Sep-2025', 'Zhanna Bielova', 15.00);

COMMIT;

/Indexes/
CREATE INDEX account_city_idx
ON Account (city);

CREATE INDEX pet_type_idx
ON Pet (pet_type);

CREATE INDEX service_type_idx
ON Service (service_type);

/Procedures/
CREATE OR REPLACE PROCEDURE AllServices
(service IN VARCHAR2,
service_type OUT VARCHAR2)
AS
BEGIN
SELECT *
FROM Services
WHERE service = service_type;
END;

CREATE OR REPLACE PROCEDURE AllPets
(pet IN VARCHAR2,
pet_type OUT VARCHAR2)
AS
BEGIN
SELECT *
FROM Pet
WHERE pet = pet_type;
END;

/Function -> total payment/
CREATE OR REPLACE FUNCTION CalculateTotalPayment
RETURN NUMBER IS
total_amount NUMBER(5,2) := 0;
BEGIN
 SELECT COUNT(amount)
 INTO total_amount
 FROM Payment;
 RETURN total_amount;
END;w

/Triggers/
CREATE OR REPLACE TRIGGER confirm_payment
AFTER INSERT ON Payment
FOR EACH ROW
DECLARE
payment NUMBER;
BEGIN
    payment := :NEW.amount;
    dbms_output.put_line('Payment amount' || payment || 'confirmed');
END;

CREATE OR REPLACE TRIGGER Welcoming_new_user
AFTER INSERT ON Accounts
FOR EACH ROW
DECLARE
new_user VARCHAR2;
BEGIN
 IF new_user = :NEW.acount_id THEN
 dbms_output.put_line('Your account has been created');
 END IF;
END;