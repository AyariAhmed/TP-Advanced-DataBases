/*CREATE TABLE parts (
    partno VARCHAR(4) PRIMARY KEY,
	description VARCHAR(15) NOT NULL,
	qonhand NUMERIC(5) DEFAULT 0 CONSTRAINT ChkOnHandQty CHECK (qonhand >= 0),
	qonorder NUMERIC(5) DEFAULT 0,
	CONSTRAINT ChkOnOrderQty CHECK (qonhand = 0 OR qonorder <= qonhand*2)
);

INSERT INTO parts VALUES ('P207','Gear',75,20);
INSERT INTO parts VALUES ('P209','Cam',0,10);
INSERT INTO parts VALUES ('P221','Big Bolt',650,200);
INSERT INTO parts VALUES ('P222','Small Bolt',1250,0);
INSERT INTO parts VALUES ('P231','Big Nut',0,200);
INSERT INTO parts VALUES ('P232','Small Nut',1100,0);
INSERT INTO parts VALUES ('P250','Big Gear',5,3);
INSERT INTO parts VALUES ('P285','WheelBelt',350,0);
INSERT INTO parts VALUES ('P295','Belt',0,25);

COMMIT;*/

-- select * from parts;


create or replace function nbParts()
returns integer as $$
DECLARE n integer;

BEGIN
    select  count(*) into n from parts;
    if n > 6
    then
        raise exception 'Exception : number_parts=% > 6' , n;
        end if;
    return n;
END;

$$  LANGUAGE plpgsql;


select nbParts();



