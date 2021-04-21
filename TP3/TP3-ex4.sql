
create or replace function enameRang() returns setof tnuplet as $$
    DECLARE
        enameCursor cursor for
            select ename from emp order by empno;
        nom varchar;
        rang int :=1;
        n int :=1;
        result tnuplet;
        pas int;
    BEGIN
        open enameCursor;
        fetch enameCursor into nom;
        while FOUND loop
            result.text := nom;
            result.nombre := rang;
            return next result;
            n := n+1;
            pas := n-1;
            move forward pas from enameCursor;
            rang := rang + n;
            fetch enameCursor into nom;
        end loop;
        close enameCursor;
    end
$$ LANGUAGE plpgsql;
select enameRang();