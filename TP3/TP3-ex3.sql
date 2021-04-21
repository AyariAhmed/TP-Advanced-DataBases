CREATE TABLE if not exists ord (qty INTEGER);

INSERT INTO ord VALUES(5);
INSERT INTO ord VALUES(NULL);
INSERT INTO ord VALUES(10);
INSERT INTO ord VALUES(8);
INSERT INTO ord VALUES(9);
INSERT INTO ord VALUES(13);

COMMIT;


create or replace function diffQty() returns int as $$
    DECLARE
        qtyCursor cursor for
            select qty from ord where qty is not null;
        qtPrec ord.qty%TYPE;
        qtCour ord.qty%TYPE;
        total real :=0;
        n int;
    BEGIN
        select count(*) into n from ord where qty is not null;
        if n<2
            then
            raise exception 'il y a uniquement % commandes!',n;
        end if;
        open qtyCursor;
        fetch qtyCursor into qtPrec;
        fetch qtyCursor into qtCour;
        while FOUND loop
            total := total + abs(qtCour - qtPrec);
            qtPrec := qtCour;
            fetch qtyCursor into qtCour;
        end loop;
        close qtyCursor;
        total := total / (n-1);
        return total;
    end
$$ LANGUAGE plpgsql;

select diffQty();