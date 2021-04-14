create or replace procedure aug1000(in dep int) as $$
DECLARE
    empl emp%ROWTYPE;
    maxSal emp.sal%TYPE;
    nouvSal emp.sal%TYPE;
BEGIN
    select max(sal) into maxSal from emp;
    for empl in select * from emp where emp.deptno = dep and sal > 1500
    loop
        nouvSal := empl.sal +1000;
        if nouvSal > empl.sal THEN
            raise exception '% ne peut plus gagner plus!',empl.ename;
        end if;
        update emp set sal=nouvSal where empl.empno = empno;
    end loop;

end;

$$ LANGUAGE plpgsql;


call aug1000(20);

/*CREATE OR REPLACE FUNCTION faug1000(noDept INT) RETURNS VOID AS $$
DECLARE
nuplet emp%ROWTYPE;
salMax emp.sal%TYPE;
nouvSal emp.sal%TYPE;
BEGIN
SELECT MAX(sal) INTO salMAX FROM emp;
FOR nuplet IN
SELECT * FROM emp WHERE deptno = NoDept AND sal > 1500
LOOP
nouvSal := nuplet.sal + 1000;
IF nouvSal >= salMax THEN
RAISE EXCEPTION '% ne peut pas gagner plus que le président!',
nuplet.ename;
END IF;
UPDATE emp SET sal = nouvSal WHERE empno = nuplet.empno;
END LOOP;
END
$$ LANGUAGE plpgsql;
SELECT faug1000(20);*/