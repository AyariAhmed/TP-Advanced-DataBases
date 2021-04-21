create or replace function top5() returns setof tNuplet as $$
    declare
        dataCursor cursor for
            select product_name,list_price from demo_product_info order by list_price DESC;
        nuplet tnuplet;
        i int := 0;
    begin
        open dataCursor;
        loop
            fetch dataCursor into nuplet;
            i:= i+1;
            exit when not FOUND or i>5;
            return next nuplet;
        end loop;
        close dataCursor;
    end;
$$ LANGUAGE plpgsql;

select top5();
