------------------------------------------------------------
--        Script Postgre 
------------------------------------------------------------



------------------------------------------------------------
-- Table: quantite
------------------------------------------------------------
CREATE TABLE public.quantite(
	qua_id   SERIAL NOT NULL ,
	qua_rest NUMERIC (25,0)  NOT NULL ,
	qua_jet  NUMERIC (25,0)  NOT NULL ,
	qua_vend NUMERIC (25,0)  NOT NULL ,
	CONSTRAINT prk_constraint_quantite PRIMARY KEY (qua_id)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: aliment
------------------------------------------------------------
CREATE TABLE public.aliment(
	ali_id SERIAL NOT NULL ,
	ali_fr VARCHAR (30) NOT NULL ,
	ali_lg VARCHAR (30) NOT NULL ,
	cat_id INT  NOT NULL ,
	CONSTRAINT prk_constraint_aliment PRIMARY KEY (ali_id)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: categorie
------------------------------------------------------------
CREATE TABLE public.categorie(
	cat_id  SERIAL NOT NULL ,
	cat_nom VARCHAR (25) NOT NULL ,
	CONSTRAINT prk_constraint_categorie PRIMARY KEY (cat_id)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: client
------------------------------------------------------------
CREATE TABLE public.client(
	cli_id   SERIAL NOT NULL ,
	cli_add  VARCHAR (100)  ,
	cli_code NUMERIC (5,0)   ,
	com_id   INT  NOT NULL ,
	CONSTRAINT prk_constraint_client PRIMARY KEY (cli_id)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: vente
------------------------------------------------------------
CREATE TABLE public.vente(
	ven_id   SERIAL NOT NULL ,
	ven_date DATE  NOT NULL ,
	ven_heur TIMETZ  NOT NULL ,
	CONSTRAINT prk_constraint_vente PRIMARY KEY (ven_id)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: commune
------------------------------------------------------------
CREATE TABLE public.commune(
	com_id   SERIAL NOT NULL ,
	com_nom  VARCHAR (30) NOT NULL ,
	com_code NUMERIC (5,0)  NOT NULL ,
	CONSTRAINT prk_constraint_commune PRIMARY KEY (com_id)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: a_v_q_c
------------------------------------------------------------
CREATE TABLE public.a_v_q_c(
	ven_id INT  NOT NULL ,
	cli_id INT  NOT NULL ,
	ali_id INT  NOT NULL ,
	qua_id INT  NOT NULL ,
	CONSTRAINT prk_constraint_a_v_q_c PRIMARY KEY (ven_id,cli_id,ali_id,qua_id)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: ven_com
------------------------------------------------------------
CREATE TABLE public.ven_com(
	ven_id INT  NOT NULL ,
	com_id INT  NOT NULL ,
	CONSTRAINT prk_constraint_ven_com PRIMARY KEY (ven_id,com_id)
)WITHOUT OIDS;


CREATE INDEX quantite_qua_rest_idx ON quantite (qua_rest);
CREATE INDEX aliment_ali_fr_idx ON aliment (ali_fr);
CREATE INDEX aliment_ali_lg_idx ON aliment (ali_lg);
CREATE INDEX commune_com_code_idx ON commune (com_code);

ALTER TABLE public.aliment ADD CONSTRAINT FK_aliment_cat_id FOREIGN KEY (cat_id) REFERENCES public.categorie(cat_id);
ALTER TABLE public.client ADD CONSTRAINT FK_client_com_id FOREIGN KEY (com_id) REFERENCES public.commune(com_id);
ALTER TABLE public.a_v_q_c ADD CONSTRAINT FK_a_v_q_c_ven_id FOREIGN KEY (ven_id) REFERENCES public.vente(ven_id);
ALTER TABLE public.a_v_q_c ADD CONSTRAINT FK_a_v_q_c_cli_id FOREIGN KEY (cli_id) REFERENCES public.client(cli_id);
ALTER TABLE public.a_v_q_c ADD CONSTRAINT FK_a_v_q_c_ali_id FOREIGN KEY (ali_id) REFERENCES public.aliment(ali_id);
ALTER TABLE public.a_v_q_c ADD CONSTRAINT FK_a_v_q_c_qua_id FOREIGN KEY (qua_id) REFERENCES public.quantite(qua_id);
ALTER TABLE public.ven_com ADD CONSTRAINT FK_ven_com_ven_id FOREIGN KEY (ven_id) REFERENCES public.vente(ven_id);
ALTER TABLE public.ven_com ADD CONSTRAINT FK_ven_com_com_id FOREIGN KEY (com_id) REFERENCES public.commune(com_id);
