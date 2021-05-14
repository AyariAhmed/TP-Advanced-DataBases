-- CREATE TABLE DEMO_CUSTOMERS (
--     CUSTOMER_ID NUMERIC PRIMARY KEY,
--     CUST_FIRST_NAME VARCHAR,
-- 	CUST_LAST_NAME VARCHAR,
-- 	CUST_STREET_ADDRESS1 VARCHAR,
-- 	CUST_STREET_ADDRESS2 VARCHAR,
-- 	CUST_CITY VARCHAR,
-- 	CUST_STATE VARCHAR,
-- 	CUST_POSTAL_CODE VARCHAR,
-- 	PHONE_NUMBER1 VARCHAR,
-- 	PHONE_NUMBER2 VARCHAR,
-- 	CREDIT_LIMIT NUMERIC(8,2),
-- 	CUST_EMAIL VARCHAR
-- );
--
-- INSERT INTO DEMO_CUSTOMERS VALUES (	1,'John','Dulles','45020 Aviation Drive','','Sterling','VA','20166','703-555-2143','','1000',''	);
-- INSERT INTO DEMO_CUSTOMERS VALUES (	2,'William','Hartsfield','6000 North Terminal Parkway','','Atlanta','GA','30320','404-555-3285','','1000',''	);
-- INSERT INTO DEMO_CUSTOMERS VALUES (	3,'Edward','Logan','1 Harborside Drive','','East Boston','MA','02128','617-555-3295','','1000',''	);
-- INSERT INTO DEMO_CUSTOMERS VALUES (	4,'Edward ''Butch''','OHare','10000 West OHare','','Chicago','IL','60666','773-555-7693','','1000',''	);
-- INSERT INTO DEMO_CUSTOMERS VALUES (	5,'Fiorello','LaGuardia','Hangar Center','Third Floor','Flushing','NY','11371','212-555-3923','','1000',''	);
-- INSERT INTO DEMO_CUSTOMERS VALUES (	6,'Albert','Lambert','10701 Lambert International Blvd.','','St. Louis','MO','63145','314-555-4022','','1000',''	);
-- INSERT INTO DEMO_CUSTOMERS VALUES (	7,'Eugene','Bradley','Schoephoester Road','','Windsor Locks','CT','06096','860-555-1835','','1000',''	);
--
-- COMMIT;

-- CREATE TABLE CUSTNAMES AS
-- SELECT CUSTOMER_ID, CUST_FIRST_NAME, CUST_LAST_NAME FROM DEMO_CUSTOMERS;

create or replace function custnamesUpdater() returns TRIGGER as
$$
BEGIN
    case tg_op
        when 'INSERT' then insert into custnames values (NEW.customer_id, NEW.cust_first_name, NEW.cust_last_name);
        when 'DELETE' then delete from custnames where custnames.customer_id = OLD.customer_id;
        when 'UPDATE' then update custnames
                           set cust_first_name=NEW.cust_first_name,
                               customer_id = NEW.customer_id,
                               cust_last_name=NEW.cust_last_name
                           where customer_id = old.customer_id;
        end case;

    return NEW;
end ;
$$ LANGUAGE plpgsql;

create trigger custnamesTrig
    after insert or update or delete
    on demo_customers
    for each row
execute procedure custnamesUpdater();

INSERT INTO demo_customers VALUES(8, 'Darmont', 'Jérôme', NULL, NULL, NULL,
NULL, NULL, NULL, NULL, NULL, NULL);
UPDATE demo_customers SET customer_id = 9, cust_first_name = 'Albertine'
WHERE customer_id = 6;
DELETE FROM demo_customers WHERE customer_id = 4;
SELECT * FROM custnames;