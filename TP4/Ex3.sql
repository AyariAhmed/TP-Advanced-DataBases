-- CREATE TABLE stats(
--     typeMaj CHAR(6) PRIMARY KEY,
--     nbMaj BIGINT,
--     timestampModif TIMESTAMP
-- );
--
-- INSERT INTO stats VALUES('INSERT', 0, NULL);
-- INSERT INTO stats VALUES('UPDATE', 0, NULL);
-- INSERT INTO stats VALUES('DELETE', 0, NULL);
--
-- COMMIT;

create or replace function sysCount() returns TRIGGER as $$
BEGIN
    if tg_op = 'DELETE' then
        update stats set nbmaj=nbmaj+1, timestampmodif=now() where typemaj='DELETE';
    end if;
    if tg_op = 'INSERT' then
        update stats set nbmaj=nbmaj+1, timestampmodif=now() where typemaj='INSERT';
    end if;
    if tg_op = 'UPDATE' then
        update stats set nbmaj=nbmaj+1, timestampmodif=now() where typemaj='UPDATE';
    end if;
    return NEW;
end;
$$ LANGUAGE plpgsql;

-- drop trigger sysCountCheker on emp;

create trigger sysCountCheker
after insert or update or delete on emp
for each row
execute procedure sysCount();

UPDATE emp SET sal = sal *1.05;
select * from stats;

-- for each statement : une seule incrementation
-- for each row : nombre d'incrementation egale au nombre de ligne dans la table