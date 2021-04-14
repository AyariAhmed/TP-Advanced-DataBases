/*create table if not exists salle(
  batiment varchar(1),
  numero_salle varchar(10),
  capacite integer check ( capacite >10 ) ,
  constraint PK_salle primary key (batiment,numero_salle)
);
create table if not exists departement(
    departement_id integer primary key ,
    nom_departement varchar(25) unique
);

create table if not exists enseignement(
    enseignement_id integer,
    departement_id integer,
    intitule varchar(60),
    description varchar(1000),
    constraint PK_enseignement primary key (enseignement_id, departement_id),
    constraint FK_enseignement_departement foreign key (departement_id) references departement(departement_id)
);

create table if not exists enseignant(
    enseignant_id integer primary key ,
    departement_id integer,
    nom varchar(25),
    prenom varchar(25),
    grade varchar(25) ,
    telephone varchar(10),
    fax varchar(10),
    email varchar(100),
    constraint FK_enseignant_departement foreign key (departement_id) references departement(departement_id),
    constraint CK_enseignant_grade check (grade in ('Vacataire', 'Moniteur', 'ATER', 'MCF', 'PROF'))
);


create table if not exists reservation(
    reservation_id integer primary key ,
    batiment varchar(1),
    numero_salle varchar(10) ,
    enseignement_id integer ,
    departement_id integer,
    enseignant_id integer ,
    date_resa date default CURRENT_DATE,
    heure_debut time default CURRENT_TIME,
    heure_fin time default '23:00:00',
    nombre_heures integer check ( nombre_heures >= 1 ),
    constraint FK_reservation_salle foreign key (batiment,numero_salle) references salle(batiment, numero_salle),
    constraint FK_reservation_enseignement foreign key (enseignement_id,departement_id) references enseignement(enseignement_id,departement_id),
    constraint FK_reservation_enseignant foreign key (enseignement_id) references enseignant(enseignant_id),
    constraint CK_reservation_duree check ( reservation.heure_fin >reservation.heure_debut )
);


CREATE TABLE Etudiant
(
    Etudiant_ID integer,
    Nom varchar(25) NOT NULL,
    Prenom Varchar(25) NOT NULL,
    Date_Naissance date NOT NULL,
    Adresse Varchar(50)  DEFAULT NULL,
    Ville Varchar(25)  DEFAULT NULL,
    Code_Postal Varchar(9) DEFAULT NULL,
    Telephone Varchar(10)  DEFAULT NULL,
    Fax Varchar(10)  DEFAULT NULL,
    Email Varchar(100) DEFAULT NULL,
    CONSTRAINT PK_Etudiant PRIMARY KEY (Etudiant_ID)
);
CREATE OR REPLACE VIEW Email_Etudiant
AS SELECT Nom, Prenom, Email FROM Etudiant;
*/

-- INSERT INTO Departement VALUES ('1','IRT');
-- INSERT INTO Departement VALUES ('2','IGL');
-- INSERT INTO Departement VALUES ('3','ILA');
--
-- INSERT INTO Etudiant VALUES ('1','ben foulen', 'foulen','1979/02/18','50,
-- Rue des alouettes','TUNIS','75021','0143567890',NULL,'foulen@gmail.com');
--
-- INSERT INTO Etudiant VALUES ('2','tounsi', 'ahmed','1980/08/23','10, Avenue
-- des marguerites','bardo','40000','0678567801',NULL,'pat@yahoo.fr');
-- INSERT INTO Etudiant VALUES ('3','tounsi', 'Jamal','1978/05/12','25,
-- Boulevard des
-- fleurs','TUNIS','75022','0145678956','0145678956','odent@free.fr');
-- INSERT INTO Etudiant VALUES ('4','benmard', 'ahmed','1979/07/15','56,
-- Boulevard des
-- fleurs','TUNIS','75022','0678905645',NULL,'deby@hotmail.com');
-- INSERT INTO Etudiant VALUES ('5','foulana', 'tounsia','1979/08/15','45,
-- Avenue des abeilles','ariana','75022',NULL,NULL,NULL);
-- INSERT INTO Enseignant
-- VALUES('1','1','ousteith','ouahed','MCF','4185','4091','ousteith@gmail.com'
-- );
-- INSERT INTO Enseignant
-- VALUES('2','1','ousteitha','wahida','PROF',NULL,NULL,'wahida@gmail.com');
-- INSERT INTO Enseignant
-- VALUES('8','1','ousteithaa','wahidaa','PROF',NULL,NULL,'wahida@gmail.com');
--
-- INSERT INTO salle VALUES('B','020','15');
-- INSERT INTO salle VALUES('B','022','15');
-- INSERT INTO salle VALUES('A','301','45');
-- INSERT INTO salle VALUES('C','Amphi 8','500');
-- INSERT INTO salle VALUES ('C','Amphi 4','200');
--
-- INSERT INTO Enseignement VALUES ('1','1','Bases de Données
-- Relationnelles','Niveau Licence (L3) : Modélisation E/A et UML, Modèle
-- relationnel, Algèbre Relationnelle, Calcul relationel, SQL, dépendances
-- fonctionnelles et formes normales');
-- INSERT INTO Enseignement VALUES ('2','1','Langage C++','Niveau Master 1');
-- INSERT INTO Enseignement VALUES ('3','1','Mise à Niveau Bases de
-- Données','Niveau Master 2 - Programme Licence et Master 1 en Bases de
-- Données');
--
-- INSERT INTO Reservation VALUES
-- ('1','B','022','1','1','1','2008/10/15','08:30:00','11:45:00','3');
-- INSERT INTO Reservation VALUES
-- ('2','B','022','1','1','2','2008/11/04','08:30:00','11:45:00','3');
-- INSERT INTO Reservation VALUES
-- ('3','B','022','1','1','2','2008/11/07','08:30:00','11:45:00','3');
-- INSERT INTO Reservation VALUES
-- ('4','B','020','1','1','1','2008/10/15','08:30:00','11:45:00','3');

select nom , prenom from etudiant;
select nom , prenom , ville from etudiant where LOWER(ville) LIKE 'tunis';
select nom , prenom , ville from etudiant where LOWER(ville) LIKE 'sfax';

select nom , prenom from etudiant where nom LIKE 't%';
select nom , prenom from etudiant where nom LIKE 'f%';

select nom , prenom from enseignant where nom LIKE '%a_';

select nom , prenom from enseignant e inner join departement d on d.departement_id = e.departement_id
order by d.nom_departement , nom , prenom ;

select count(*) "Enseignant avec grade 'Moniteur'" from enseignant
where grade = 'Moniteur';

select count(*) "fax null" from etudiant where fax is null;

select intitule from enseignement where intitule LIKE '%SQL%' or intitule LIKE '%Licence%';

select avg(capacite) "Capacite Moyenne" , max(capacite) "Capacite Max"
from salle;

select numero_salle from salle where capacite < (select avg(capacite) from salle);

select nom , prenom  from etudiant
order by ville;

-- PART 4

create table if not exists inscription(
    etudiant integer,
    enseignement integer,
    date_inscrip date default CURRENT_DATE,
    constraint PK_inscription primary key (etudiant,enseignement),
    constraint FK_inscription_etudiant foreign key (etudiant) references etudiant(etudiant_id),
    constraint FK_inscription_enseignement foreign key (enseignement) references enseignement(enseignement_id)
);

alter table enseignement
add constraint unique_ensei_id unique (enseignement_id);

create table if not exists note(
    etudiant integer,
    enseignement integer,
    note float,
    constraint PK_note primary key (etudiant,enseignement),
    constraint FK_note_etudiant foreign key (etudiant) references etudiant(etudiant_id),
    constraint FK_note_enseignement foreign key (enseignement) references enseignement(enseignement_id)
);

-- PART 5

CREATE FUNCTION trigger_function()
   RETURNS TRIGGER
   LANGUAGE PLPGSQL
AS $$
DECLARE
    counte integer;
BEGIN
    select count(*) into counte from inscription where inscription.etudiant = NEW.etudiant and inscription.enseignement = NEW.enseignement;
    if(counte = 0) THEN
        insert into inscription values (NEW.etudiant,NEW.enseignement);
    end if;
    return NEW;

END;
$$;


create trigger note_trig before insert on note for each row execute procedure trigger_function();

insert into note values (1,2,17.75);
select * from inscription;