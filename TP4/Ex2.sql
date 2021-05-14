/*create table clibanque(
	idCli SERIAL,
	nomCli VARCHAR(50),
	idConjoint INT,
	constraint cliPK primary key(idCli),
	constraint cliFK foreign key(idConjoint) references clibanque(idCli)
)*/


-- insert into clibanque(nomcli, idconjoint) values ('ayari',null);
-- insert into clibanque(nomcli, idconjoint) values ('ayari',null);
-- insert into clibanque(nomcli) values ('a');
-- insert into clibanque(nomcli, idconjoint) values ('a',3);

create or replace function conjointNamer() returns TRIGGER as
$$
DECLARE
    nom clibanque.nomcli%type;
BEGIN
    if New.idconjoint is not null then
        select  nomcli into nom from clibanque where idcli = NEW.idconjoint;
        if nom <> NEW.nomcli then
            raise exception 'Non de conjoint différent';
        end if;
    end if;
    return NEW;
end;
$$ LANGUAGE plpgsql;

create trigger conjointNameCheck
    before insert or update
    on clibanque
    for each row
execute procedure conjointNamer();


INSERT INTO clibanque VALUES (1, 'Darmont', NULL);
INSERT INTO clibanque VALUES (2, 'Darmont', 1);
UPDATE clibanque SET idConjoint = 2 WHERE idcli = 1;
INSERT INTO clibanque VALUES (3, 'Bentayeb', NULL);
INSERT INTO clibanque VALUES (4, 'NotBentayeb', 3);
UPDATE clibanque SET idConjoint = 3 WHERE idcli = 1;
UPDATE clibanque SET nomcli = 'Darmon' WHERE idcli = 1;