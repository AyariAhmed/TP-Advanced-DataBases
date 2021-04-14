/*create or replace procedure cat() as $$
DECLARE
    tabName RECORD;
    var varchar;
BEGIN
    for tabName in
        select tablename
        from pg_tables where tableowner = 'ayari'
    loop
        raise notice 'tabName : %', tabName.tablename;
        end loop;
END;

$$ language plpgsql;
call cat();*/

-- create or replace function fcat() returns setof varchar as $$
create or replace function fcat() returns TABLE(tableName varchar ) as $$
BEGIN
    for tableName in select tablename from pg_tables where tableowner = 'ayari'
    loop
        return next;
--         return next tableName.tablename;
        end loop;
end;
$$ LANGUAGE plpgsql;
select fcat();