TRUNCATE TABLE COMPANY;
TRUNCATE TABLE NUM_EMPLOYEES_RANGE;
TRUNCATE TABLE ROLE;
TRUNCATE TABLE USER;
TRUNCATE TABLE USER_COMPANY_ROLE;
TRUNCATE TABLE USER_INVITE;

INSERT INTO ROLE(LONG_NAME,SHORT_NAME) VALUES ('Administrator', 'ROLE_ADMIN');


drop schema commonsuser cascade;
create schema commonsuser;
INSERT INTO ROLE(ID,LONG_NAME,SHORT_NAME) VALUES (nextval('role_id_seq'),'Administrator','ROLE_ADMIN');
INSERT INTO ROLE(ID,LONG_NAME,SHORT_NAME) VALUES (nextval('role_id_seq'),'Employee','ROLE_EMPLOYEE');