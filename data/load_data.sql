-- Create database named widlife_database

CREATE DATABASE wildlife_database
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- creating schema

CREATE SCHEMA wildlife_database
    AUTHORIZATION postgres;
	
-- setting search path to wilidlife database

set search_path to wildlife_database

-- Table: wildlife_database.country

-- DROP TABLE IF EXISTS wildlife_database.country;

CREATE TABLE IF NOT EXISTS wildlife_database.country
(
    c_id integer NOT NULL,
    name character varying COLLATE pg_catalog."default",
    total_z integer,
    total_np integer,
    total_ws integer,
    CONSTRAINT country_pkey PRIMARY KEY (c_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wildlife_database.country
    OWNER to postgres;


-- Table: wildlife_database.state

-- DROP TABLE IF EXISTS wildlife_database.state;

CREATE TABLE IF NOT EXISTS wildlife_database.state
(
    s_id integer NOT NULL,
    name character varying COLLATE pg_catalog."default",
    total_z integer,
    total_np integer,
    total_ws integer,
    c_id integer,
    CONSTRAINT state_pkey PRIMARY KEY (s_id),
    CONSTRAINT c_id FOREIGN KEY (c_id)
        REFERENCES wildlife_database.country (c_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wildlife_database.state
    OWNER to postgres;


-- Table: wildlife_database.zoo

-- DROP TABLE IF EXISTS wildlife_database.zoo;

CREATE TABLE IF NOT EXISTS wildlife_database.zoo
(
    z_id integer NOT NULL,
    name character varying COLLATE pg_catalog."default",
    s_id integer,
    area_covered double precision,
    CONSTRAINT zoo_pkey PRIMARY KEY (z_id),
    CONSTRAINT s_id FOREIGN KEY (s_id)
        REFERENCES wildlife_database.state (s_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wildlife_database.zoo
    OWNER to postgres;


-- Table: wildlife_database.national_park

-- DROP TABLE IF EXISTS wildlife_database.national_park;

CREATE TABLE IF NOT EXISTS wildlife_database.national_park
(
    np_id integer NOT NULL,
    name character varying COLLATE pg_catalog."default",
    s_id integer,
    area_covered double precision,
    CONSTRAINT national_park_pkey PRIMARY KEY (np_id),
    CONSTRAINT s_id FOREIGN KEY (s_id)
        REFERENCES wildlife_database.state (s_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wildlife_database.national_park
    OWNER to postgres;


-- Table: wildlife_database.wildlife_sanctuary

-- DROP TABLE IF EXISTS wildlife_database.wildlife_sanctuary;

CREATE TABLE IF NOT EXISTS wildlife_database.wildlife_sanctuary
(
    ws_id integer NOT NULL,
    name character varying COLLATE pg_catalog."default",
    s_id integer,
    area_covered double precision,
    CONSTRAINT wildlife_sanctuary_pkey PRIMARY KEY (ws_id),
    CONSTRAINT s_id FOREIGN KEY (s_id)
        REFERENCES wildlife_database.state (s_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wildlife_database.wildlife_sanctuary
    OWNER to postgres;


-- Table: wildlife_database.place

-- DROP TABLE IF EXISTS wildlife_database.place;

CREATE TABLE IF NOT EXISTS wildlife_database.place
(
    place_id integer NOT NULL,
    CONSTRAINT place_pkey PRIMARY KEY (place_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wildlife_database.place
    OWNER to postgres;


-- Table: wildlife_database.animal

-- DROP TABLE IF EXISTS wildlife_database.animal;

CREATE TABLE IF NOT EXISTS wildlife_database.animal
(
    animal_id integer NOT NULL,
    name character varying COLLATE pg_catalog."default",
    avg_lifespan double precision,
    animal_description character varying COLLATE pg_catalog."default",
    CONSTRAINT animal_pkey PRIMARY KEY (animal_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wildlife_database.animal
    OWNER to postgres;


-- Table: wildlife_database.animal_list

-- DROP TABLE IF EXISTS wildlife_database.animal_list;

CREATE TABLE IF NOT EXISTS wildlife_database.animal_list
(
    animal_id integer NOT NULL,
    place_id integer NOT NULL,
    current_no integer,
    past_no integer,
    CONSTRAINT animal_list_pkey PRIMARY KEY (animal_id, place_id),
    CONSTRAINT place_id FOREIGN KEY (place_id)
        REFERENCES wildlife_database.place (place_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wildlife_database.animal_list
    OWNER to postgres;


-- Table: wildlife_database.extinct_animal

-- DROP TABLE IF EXISTS wildlife_database.extinct_animal;

CREATE TABLE IF NOT EXISTS wildlife_database.extinct_animal
(
    animal_id integer NOT NULL,
    c_id integer NOT NULL,
    total_count integer,
    CONSTRAINT extinct_animal_pkey PRIMARY KEY (animal_id, c_id),
    CONSTRAINT animal_id FOREIGN KEY (animal_id)
        REFERENCES wildlife_database.animal (animal_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT c_id FOREIGN KEY (c_id)
        REFERENCES wildlife_database.country (c_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wildlife_database.extinct_animal
    OWNER to postgres;


-- Table: wildlife_database.tourist

-- DROP TABLE IF EXISTS wildlife_database.tourist;

CREATE TABLE IF NOT EXISTS wildlife_database.tourist
(
    place_id integer NOT NULL,
    visit_no integer NOT NULL,
    ratings double precision,
    animal_id integer,
    CONSTRAINT tourist_pkey PRIMARY KEY (place_id, visit_no),
    CONSTRAINT animal_id FOREIGN KEY (animal_id)
        REFERENCES wildlife_database.animal (animal_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT place_id FOREIGN KEY (place_id)
        REFERENCES wildlife_database.place (place_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wildlife_database.tourist
    OWNER to postgres;



-- Table: wildlife_database.photography_place

-- DROP TABLE IF EXISTS wildlife_database.photography_place;

CREATE TABLE IF NOT EXISTS wildlife_database.photography_place
(
    place_id integer NOT NULL,
    animal_id integer NOT NULL,
    CONSTRAINT photography_place_pkey PRIMARY KEY (place_id, animal_id),
    CONSTRAINT animal_id FOREIGN KEY (animal_id)
        REFERENCES wildlife_database.animal (animal_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT place_id FOREIGN KEY (place_id)
        REFERENCES wildlife_database.place (place_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wildlife_database.photography_place
    OWNER to postgres;

-- Table: wildlife_database.disease

-- DROP TABLE IF EXISTS wildlife_database.disease;

CREATE TABLE IF NOT EXISTS wildlife_database.disease
(
    d_id integer NOT NULL,
    disease_name character varying COLLATE pg_catalog."default",
    symptoms character varying COLLATE pg_catalog."default",
    measures character varying COLLATE pg_catalog."default",
    CONSTRAINT disease_pkey PRIMARY KEY (d_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wildlife_database.disease
    OWNER to postgres;


-- Table: wildlife_database.medical_history

-- DROP TABLE IF EXISTS wildlife_database.medical_history;

CREATE TABLE IF NOT EXISTS wildlife_database.medical_history
(
    mh_id integer NOT NULL,
    animal_id integer,
    place_id integer,
    unhealthy_count integer,
    healthy_count integer,
    d_id integer,
    CONSTRAINT medical_history_pkey PRIMARY KEY (mh_id),
    CONSTRAINT animal_id FOREIGN KEY (animal_id)
        REFERENCES wildlife_database.animal (animal_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT d_id FOREIGN KEY (d_id)
        REFERENCES wildlife_database.disease (d_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT place_id FOREIGN KEY (place_id)
        REFERENCES wildlife_database.place (place_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wildlife_database.medical_history
    OWNER to postgres;


-- Table: wildlife_database.migration_record

-- DROP TABLE IF EXISTS wildlife_database.migration_record;

CREATE TABLE IF NOT EXISTS wildlife_database.migration_record
(
    mr_id integer NOT NULL,
    source_id integer,
    destination_id integer,
    animal_id integer,
    animal_count integer,
    reason character varying COLLATE pg_catalog."default",
    CONSTRAINT migration_record_pkey PRIMARY KEY (mr_id),
    CONSTRAINT animal_id FOREIGN KEY (animal_id)
        REFERENCES wildlife_database.animal (animal_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT destination_id FOREIGN KEY (destination_id)
        REFERENCES wildlife_database.place (place_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT source_id FOREIGN KEY (source_id)
        REFERENCES wildlife_database.place (place_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wildlife_database.migration_record
    OWNER to postgres;


-- Table: wildlife_database.finance

-- DROP TABLE IF EXISTS wildlife_database.finance;

CREATE TABLE IF NOT EXISTS wildlife_database.finance
(
    place_id integer NOT NULL,
    funding integer,
    expenditure integer,
    current_amount integer,
    net_amount integer,
    CONSTRAINT finance_pkey PRIMARY KEY (place_id),
    CONSTRAINT place_id FOREIGN KEY (place_id)
        REFERENCES wildlife_database.place (place_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS wildlife_database.finance
    OWNER to postgres;

-- Triggers

-- zoo - creating function

create or replace function "wildlife_database"."zoo_insert"()
	returns trigger
	LANGUAGE 'plpgsql'
as $$
	declare
		chk integer;
		
	begin
		select place.place_id into chk
		from place
		where place.place_id=new.z_id;
		
		if(chk=new.z_id)
		then
			raise notice 'key already exists';
			return NULL;
		else
			insert into place
			values(new.z_id);
			return new;
		end if;
	end
$$

-- zoo - creating trigger

create trigger trig_zoo_insert
before insert
on wildlife_database.zoo
for each row
execute procedure wildlife_database.zoo_insert();

-- national park - creating function

create or replace function "wildlife_database"."np_insert"()
	returns trigger
	LANGUAGE 'plpgsql'
as $$
	declare
		chk integer;
		
	begin
		select place.place_id into chk
		from place
		where place.place_id=new.np_id;
		
		if(chk=new.np_id)
		then
			raise notice 'key already exists';
			return NULL;
		else
			insert into place
			values(new.np_id);
			return new;
		end if;
	end
$$

-- national park - creating trigger

create trigger trig_np_insert
before insert
on wildlife_database.national_park
for each row
execute procedure wildlife_database.np_insert();

-- wildlife sanctuary - creating function

create or replace function "wildlife_database"."ws_insert"()
	returns trigger
	LANGUAGE 'plpgsql'
as $$
	declare
		chk integer;
		
	begin
		select place.place_id into chk
		from place
		where place.place_id=new.ws_id;
		
		if(chk=new.ws_id)
		then
			raise notice 'key already exists';
			return NULL;
		else
			insert into place
			values(new.ws_id);
			return new;
		end if;
	end
$$

-- national park - creating trigger

create trigger trig_ws_insert
before insert
on wildlife_database.wildlife_sanctuary
for each row
execute procedure wildlife_database.ws_insert();

-- loading data from csv

COPY "country" FROM 'C:\Users\Public\data\country.csv' CSV HEADER;
COPY "state" FROM 'C:\Users\Public\data\state.csv' CSV HEADER;
COPY "zoo" FROM 'C:\Users\Public\data\zoo.csv' CSV HEADER;
COPY "national_park" FROM 'C:\Users\Public\data\national_park.csv' CSV HEADER;
COPY "wildlife_sanctuary" FROM 'C:\Users\Public\data\wildlife_sanctuary.csv' CSV HEADER;
COPY "animal" FROM 'C:\Users\Public\data\animal.csv' CSV HEADER;
COPY "animal_list" FROM 'C:\Users\Public\data\animal_list.csv' CSV HEADER;
COPY "extinct_animal" FROM 'C:\Users\Public\data\extinct_animal.csv' CSV HEADER;
COPY "tourist" FROM 'C:\Users\Public\data\tourist.csv' CSV HEADER;
COPY "photography_place" FROM 'C:\Users\Public\data\photography_place.csv' CSV HEADER;
COPY "disease" FROM 'C:\Users\Public\data\disease.csv' CSV HEADER;
COPY "medical_history" FROM 'C:\Users\Public\data\medical_history.csv' CSV HEADER;
COPY "migration_record" FROM 'C:\Users\Public\data\migration_record.csv' CSV HEADER;
COPY "finance" FROM 'C:\Users\Public\data\finance.csv' CSV HEADER;