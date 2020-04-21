/* GAL LEADER V1.0 */
/* Creation de la structure des données (tables, séquences, triggers,...) */
/* gal_leader_10_structure.sql */
/* PostgreSQL/PostGIS */
/* Conseil régional Nouvelle-Aquitaine - https://cartographie.nouvelle-aquitaine.fr/ */
/* Auteur : Tony VINCENT */


------------------------------------------------------------------------
-- Table: ref_zonage.t_appartenance_geo_com_gal_leader

-- DROP TABLE ref_zonage.t_appartenance_geo_com_gal_leader;
CREATE TABLE ref_zonage.t_appartenance_geo_com_gal_leader (
	id serial,
	numcom varchar(5) NOT NULL,
	nomcom varchar(50),
	nomcom_m varchar(50),
	numdep varchar(3),
	nomdep varchar(30),
	numreg varchar(2),
	nomreg varchar(35),
	numepci varchar(9),
	numgal_leader character varying(5),	
	nomgal_leader character varying(255),
	cog_annee character varying(4),
	commentaires text,
	date_import date,
	date_maj date,
	CONSTRAINT t_appartenance_geo_com_gal_leader_pkey PRIMARY KEY (id),
	CONSTRAINT t_appartenance_geo_com_gal_leader_uniq UNIQUE (numcom)
);

--
COMMENT ON TABLE ref_zonage.t_appartenance_geo_com_gal_leader IS 'Table d''appartenance des communes au GAL LEADER en Nouvelle-Aquitaine';

--
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.id IS 'Identifiant';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.numcom IS 'Code INSEE de la commune';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.nomcom IS 'Nom de la commune';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.numdep IS 'Numéro du département';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.nomdep IS 'Nom du département';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.numreg IS 'Numéro de la région';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.nomreg IS 'Nom de la régon';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.numepci IS 'Numéro de l''EPCI';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.numgal_leader IS 'Code du Groupe d''Action Locale';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.nomgal_leader IS 'Nom du Groupe d''Action Locale LEADER';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.cog_annee IS 'Année COG de référence';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.commentaires IS 'Commentaires';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.date_maj IS 'Date de mise à jour de la donnée';


--
INSERT INTO ref_zonage.t_appartenance_geo_com_gal_leader (
	numcom, nomcom, nomcom_m, numdep, nomdep, numreg, nomreg, numepci, cog_annee
)
SELECT 
	insee_com, nom_com, nom_com_m, insee_dep, nom_dep, 
	insee_reg, nom_reg, code_epci, '2019' FROM ref_adminexpress.r_admexp_commune_fr
where insee_reg='75';

------------------------------------------------------------------------
-- GAL Angoumois ( communes) ==> A faire CA Angouleme

-- EPCI : CC de La Rochefoucauld Porte du Périgord
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader 
SET numgal_leader='16Leader01',	nomgal_leader='Angoumois' 
WHERE numepci IN ('200068914');

-- EPCI : une partie de la CA du Grand Angoulême
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader 
SET numgal_leader='16Leader01',	nomgal_leader='Angoumois' 
WHERE numepci IN ('200068914');


------------------------------------------------------------------------
-- GAL Aunis (44 communes) ==> Ok

-- EPCI : CC d’Aunis Sud
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader 
SET numgal_leader='17Leader01',	nomgal_leader='Aunis' 
WHERE numepci IN ('200041614');

-- EPCI : CC d’Aunis Atlantique
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader 
SET numgal_leader='17Leader01',	nomgal_leader='Angoumois' 
WHERE numepci IN ('200041499');


------------------------------------------------------------------------
-- GAL Charente-Limousine (58 communes) ==> Ok

-- EPCI : CC Charente Limousine
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader 
SET numgal_leader='16Leader02',	nomgal_leader='Charente-Limousine' 
WHERE numepci IN ('200072049');


------------------------------------------------------------------------
-- GAL Civraisien (36 communes) ==> Ok

-- EPCI : CC du Civraisien-en-Poitou
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader 
SET numgal_leader='86Leader02',	nomgal_leader='Civraisien' 
WHERE numepci IN ('200070035');


------------------------------------------------------------------------
-- GAL Haute-Saintonge (129 communes) ==> Ok

-- EPCI : CC de la Haute Saintonge
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader 
SET numgal_leader='17Leader02',	nomgal_leader='Haute-Saintonge' 
WHERE numepci IN ('200041523');


------------------------------------------------------------------------
-- GAL Mellois (62 communes) ==> Ok

-- EPCI : CC du Cellois, Coeur du Poitou, Mellois et Val
de Boutonne
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader 
SET numgal_leader='79Leader02',	nomgal_leader='Mellois' 
WHERE numepci IN ('200069755');


------------------------------------------------------------------------
-- GAL Nord Deux-Sèvres (57 communes) ==> Ok

-- EPCI : Communauté d’Agglomération du Bocage
Bressuirais et Communauté de communes du Thouarsais
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader 
SET numgal_leader='79Leader03',	nomgal_leader='Nord Deux-Sèvres' 
WHERE numepci IN ('200040244', '247900798');


------------------------------------------------------------------------
-- GAL Nord Vienne (57 communes) ==> A refaire

-- EPCI : CC du Haut Poitou (en partie) + CA Grand Châtellerault (en partie) + CU du Grand Poitiers (en partie)

UPDATE ref_zonage.t_appartenance_geo_com_gal_leader 
SET numgal_leader='17Leader02',	nomgal_leader='Aunis' 
WHERE numepci IN ('', '', '');


------------------------------------------------------------------------
-- GAL Ouest Charente Pays du Cognac (57 communes) ==> Ok

-- EPCI : CC du Rouillacais + Grand Cognac Communauté d’agglomération
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader 
SET numgal_leader='17Leader02',	nomgal_leader='Aunis' 
WHERE numepci IN ('241600303', '200070514');




