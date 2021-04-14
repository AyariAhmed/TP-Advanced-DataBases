/*CREATE TABLE if not exists EMP (
  EMPNO NUMERIC(4) PRIMARY KEY,
  ENAME VARCHAR(10),
  JOB VARCHAR(9),
  MGR NUMERIC(4),
  HIREDATE DATE,
  SAL NUMERIC(6,2),
  COMM NUMERIC(6,2),
  DEPTNO NUMERIC(2)
);*/
-- SET datestyle = dmy;
--
--
-- INSERT INTO EMP VALUES(7369, 'SMITH',  'CLERK', 	7902, '17/12/1980',	 800,	NULL,	20);
-- INSERT INTO EMP VALUES(7499, 'ALLEN',  'SALESMAN', 	7698, '20/02/1981',	1600,	 300,	30);
-- INSERT INTO EMP VALUES(7521, 'WARD',   'SALESMAN', 	7698, '22/02/1981',	1250,	 500,	30);
-- INSERT INTO EMP VALUES(7566, 'JONES',  'MANAGER', 	7839, '02/04/1981',	2975,	NULL,	20);
-- INSERT INTO EMP VALUES(7654, 'MARTIN', 'SALESMAN', 	7698, '28/09/1981',	1250,	1400,	30);
-- INSERT INTO EMP VALUES(7698, 'BLAKE',  'MANAGER', 	7839, '01/05/1981',	2850,	NULL,	30);
-- INSERT INTO EMP VALUES(7782, 'CLARK',  'MANAGER', 	7839, '09/06/1981',	2450,	NULL,	10);
-- INSERT INTO EMP VALUES(7839, 'KING',   'PRESIDENT', NULL, '17/11/1981',	5000,	NULL,	10);
-- INSERT INTO EMP VALUES(7844, 'TURNER', 'SALESMAN', 	7698, '08/09/1981',	1500,	   0,	30);
-- INSERT INTO EMP VALUES(7900, 'JAMES',  'CLERK', 	7698, '03/12/1981',	 950,	NULL,	30);
-- INSERT INTO EMP VALUES(7902, 'FORD',   'ANALYST', 	7566, '03/12/1981',	3000,	NULL,	20);
-- INSERT INTO EMP VALUES(7934, 'MILLER', 'CLERK', 	7782, '23/01/1982',	1300,	NULL,	10);
--
-- COMMIT;

-- select * from emp;

create or replace function propMgr() returns real as $$
DECLARE
    total integer;
    nbEmplManager integer;
    prop float;
Begin
    select count(*) into total from emp;
    select count(*) into nbEmplManager from emp where job LIKE 'MANAGER';
    prop := ((nbEmplManager * 100)/ total)  ::real;
    return prop;
    EXCEPTION
    WHEN division_by_zero THEN
      RAISE NOTICE 'Division by zero occured !';

end;

 $$ language plpgsql;

-- delete  from emp ;

select propMgr() as Proportion;
