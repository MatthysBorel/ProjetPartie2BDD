PRAGMA foreign_keys = ON;

create table Departements (
    code_departement TEXT,
    nom_departement TEXT,
    code_region INTEGER,
    zone_climatique Zoneclimatique,
    constraint pk_departements primary key (code_departement),
    constraint fk_region foreign key (code_region) references Regions(code_region)
    constraint ck_zone check (zone_climatique IN ('H1','H2','H3'))
);

create table Regions (
    code_region INTEGER,
    nom_region TEXT,
    constraint pk_regions primary key (code_region)
);

create table Mesures (
    code_departement TEXT,
    date_mesure DATE,
    temperature_min_mesure FLOAT,
    temperature_max_mesure FLOAT,
    temperature_moy_mesure FLOAT,
    constraint pk_mesures primary key (code_departement, date_mesure),
    constraint fk_mesures foreign key (code_departement) references Departements(code_departement)
);


--CREATE TYPE TypePoste AS ENUM ('COMBLES PERDUES', 'ITI', 'ITE','RAMPANTS','SARKING','TOITURE TERRASSE','PANCHER BAS');
--CREATE TYPE TypeIsolant AS ENUM ('AUTRES', 'LAINE VEGETALE', 'LAINE MINERALE',);
--CREATE TYPE TypeChaudiere AS ENUM ('STANDARD', 'AIR-EAU', 'A CONDENSATIO','AUTRES','AIR-AIR','GEOTHERMIE','HPE');
--CREATE TYPE TypeGenerateur AS ENUM ('AUTRES', 'BOIS', 'ELECTRICITE','FIOUL','GAZ');
--CREATE TYPE TypeEnergie AS ENUM ('AUTRES', 'CHAUDIERE', 'INSERT','PAC','POELE','RADIATEUR');
--CREATE TYPE TypePanneaux AS ENUM ('MONOCRISTALLIN', 'POLYCRISTALLIN');
--TODO Q4 Ajouter les créations des nouvelles tables

create table Travaux (
    id_travail INTEGER,
    code_region INTEGER,
    code_departement INTEGER,
    cout_total_ht FLOAT,
    cout_induit_ht FLOAT,
    annee INTEGER,
    type_logement TEXT,
    ann_const_log INTEGER,
    constraint pk_id_travail primary key (id_travail),
    constraint fk_region foreign key (code_region) references Regions(code_region),
    constraint fk_region foreign key (code_departement) references Departements(code_departement)
);

create table Isolation (
    id_travail INTEGER,
    poste TEXT DEFAULT NULL,
    isolant TEXT,
    epaisseur INTEGER,
    surface FLOAT,
    constraint pk_id_travail primary key (id_travail),
    constraint fk_region foreign key (id_travail) references Travaux(id_travail)
    constraint ck_poste check(poste IN ('COMBLES PERDUES', 'ITI', 'ITE','RAMPANTS','SARKING','TOITURE TERRASSE','PANCHER BAS','AA') )
    constraint ck_isolant check(isolant IN ('AUTRES', 'LAINE VEGETALE', 'LAINE MINERALE') )
);


create table Chauffage (
    id_travail INTEGER,
    energie_av_tra TEXT,
    energie_inst TEXT,
    generateur TEXT,
    type_chaudiere TEXT,
    constraint pk_id_travail primary key (id_travail),
    constraint fk_region foreign key (id_travail) references Travaux(id_travail)
    constraint ck_energie_av_tra check(energie_av_tra IN ('AUTRES', 'BOIS', 'ELECTRICITE','FIOUL','GAZ'))
    constraint ck_energie_inst check(energie_inst IN ('AUTRES', 'BOIS', 'ELECTRICITE','FIOUL','GAZ'))
    constraint ck_generateur check(generateur IN ('AUTRES', 'CHAUDIERE', 'INSERT','PAC','POELE','RADIATEUR') )
    constraint ck_type_ch check(type_chaudiere IN ('STANDARD', 'AIR-EAU', 'A CONDENSATIO','AUTRES','AIR-AIR','GEOTHERMIE','HPE') )
    
);

create table Photovoltaique (
    id_travail INTEGER,
    Puissance_inst INTEGER,
    type_pannaux TypePanneaux,
    constraint pk_id_travail primary key (id_travail),
    constraint fk_region foreign key (id_travail) references Travaux(id_travail)
    constraint ck_type_pannaux check(type_pannaux IN ('MONOCRISTALLIN', 'POLYCRISTALLIN') )
);


