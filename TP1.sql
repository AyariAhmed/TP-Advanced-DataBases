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

create table if not exists salle(
  batiment varchar(1),
  numero_salle varchar(10),
  capacite integer check ( capacite >10 ) ,
  constraint PK_salle primary key (batiment,numero_salle)
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

create table if not exists departement(
    departement_id integer primary key ,
    nom_departement varchar(25) unique
);










