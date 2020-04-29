/* GAL LEADER V1.0 */
/* Creation de la structure des données (tables, séquences, triggers,...) */
/* gal_leader_10_structure.sql */
/* PostgreSQL/PostGIS */
/* Conseil régional Nouvelle-Aquitaine - https://cartographie.nouvelle-aquitaine.fr/ */
/* Auteur : Tony VINCENT */


------------------------------------------------------------------------
-- Table: met_zon.m_zon_lt_gal_leader

-- DROP TABLE met_zon.m_zon_lt_gal_leader;
CREATE TABLE met_zon.m_zon_lt_gal_leader
(
  id serial,
  code_region character varying(80) NOT NULL,
  code_gal character varying(3),
  code_asp character varying(6),
  code_enrd character varying(6),
  nom_gal_leader character varying(255),
  nom_gal_leader_2 character varying(255), 
  structure_porteuse character varying(255), 
  commentaires text,
  color character varying(7),
  date_import date,
  date_maj date,
  CONSTRAINT m_zon_lt_gal_leader_pkey PRIMARY KEY (id),
  CONSTRAINT m_zon_lt_gal_leader_uniq UNIQUE (code_region)
);

--
COMMENT ON TABLE met_zon.m_zon_lt_gal_leader  IS 'Liste des territoires Groupe d''Action Locale LEADER';
--  
COMMENT ON COLUMN met_zon.m_zon_lt_gal_leader.id IS 'Identifiant';
COMMENT ON COLUMN met_zon.m_zon_lt_gal_leader.code_region IS 'Code région du Groupe d''Action Locale';
COMMENT ON COLUMN met_zon.m_zon_lt_gal_leader.code_gal IS 'Code du Groupe d''Action Locale';
COMMENT ON COLUMN met_zon.m_zon_lt_gal_leader.code_asp IS 'Code ASP du Groupe d''Action Locale';
COMMENT ON COLUMN met_zon.m_zon_lt_gal_leader.code_enrd IS 'Code ENRD (The European Network for Rural Development) du Groupe d''Action Locale';
COMMENT ON COLUMN met_zon.m_zon_lt_gal_leader.nom_gal_leader IS 'Nom du Groupe d''Action Locale LEADER';
COMMENT ON COLUMN met_zon.m_zon_lt_gal_leader.nom_gal_leader_2 IS 'Nom court du Groupe d''Action Locale LEADER';
COMMENT ON COLUMN met_zon.m_zon_lt_gal_leader.structure_porteuse IS 'Strucuture porteuse du GAL LEADER';
COMMENT ON COLUMN met_zon.m_zon_lt_gal_leader.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_zon.m_zon_lt_gal_leader.color IS 'Couleur du fond';
COMMENT ON COLUMN met_zon.m_zon_lt_gal_leader.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_zon.m_zon_lt_gal_leader.date_maj IS 'Date de mise à jour de la donnée';

-- On ajout les données
INSERT INTO met_zon.m_zon_lt_gal_leader (
	code_region, code_gal, code_asp, code_enrd, nom_gal_leader, date_import
)
SELECT DISTINCT cod_leader_1420_maj2, code_gal, code_asp, code_enrd, nom_leader_gal_1420_maj, now()
FROM z_maj."20200420_gal_leader_com19" where cod_leader_1420_maj2 is not NULL;

-- 


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
	code_region  character varying(80),
	nom_gal_leader character varying(255),
	nom_gal_leader_2 character varying(255), 
	cog_annee character varying(4),
	commentaires text,
	date_import date,
	date_maj date,
	CONSTRAINT t_appartenance_geo_com_gal_leader_pkey PRIMARY KEY (id),
	CONSTRAINT t_appartenance_geo_com_gal_leader_uniq UNIQUE (numcom),
	CONSTRAINT t_appartenance_geo_com_gal_leader_code_region_fkey FOREIGN KEY (code_region) REFERENCES met_zon.m_zon_lt_gal_leader(code_region)
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
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.code_region IS 'Code du Groupe d''Action Locale';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.nom_gal_leader IS 'Nom du Groupe d''Action Locale LEADER';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.nom_gal_leader_2 IS 'Nom court du Groupe d''Action Locale LEADER';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.cog_annee IS 'Année COG de référence';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.commentaires IS 'Commentaires';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_gal_leader.date_maj IS 'Date de mise à jour de la donnée';


-- On importe la liste des communes
INSERT INTO ref_zonage.t_appartenance_geo_com_gal_leader (
	numcom, nomcom, nomcom_m, numdep, nomdep, numreg, nomreg, numepci, cog_annee
)
SELECT 
	insee_com, nom_com, nom_com_m, insee_dep, nom_dep, 
	insee_reg, nom_reg, code_epci, '2019' FROM ref_adminexpress.r_admexp_commune_fr
where insee_reg='75';

-- On met à jour l'appartenance des communes aux GALs
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader t1
SET 
	code_region = t2.cod_leader_1420_maj2,
	nom_gal_leader=t2.nom_leader_gal_1420_maj,
	cog_annee='2019',
	date_import='22/04/2020'
FROM z_maj."20200420_gal_leader_com19" t2
WHERE t1.numcom=cast(t2.numcom as text);


------------------------------------------------------------------------
-- Table: met_zon.m_zon_gal_leader_na_geo

-- DROP TABLE met_zon.m_zon_gal_leader_na_geo;
CREATE TABLE met_zon.m_zon_gal_leader_na_geo (
	id serial NOT NULL,
	code_region varchar(20) NOT NULL,
	code_gal varchar(3) NULL,
	code_asp varchar(6) NULL,
	code_enrd varchar(6) NULL,
	nom_gal_leader varchar(255) NULL,
	nom_gal_leader_2 varchar(255) NULL,
	structure_porteuse character varying(255),
	commentaires text NULL,
	color character varying(7),
	date_import date NULL,
	date_maj date NULL,
	geom geometry(MULTIPOLYGON, 2154) NULL,
	CONSTRAINT m_zon_gal_leader_na_geo_pkey PRIMARY KEY (id),
	CONSTRAINT m_zon_gal_leader_na_geo_uniq UNIQUE (code_region)
);

--
COMMENT ON TABLE met_zon.m_zon_gal_leader_na_geo  IS 'Zonage des Groupes d''Action Locale LEADER';
--  
COMMENT ON COLUMN met_zon.m_zon_gal_leader_na_geo.id IS 'Identifiant';
COMMENT ON COLUMN met_zon.m_zon_gal_leader_na_geo.code_region IS 'Code région du Groupe d''Action Locale';
COMMENT ON COLUMN met_zon.m_zon_gal_leader_na_geo.code_gal IS 'Code du Groupe d''Action Locale';
COMMENT ON COLUMN met_zon.m_zon_gal_leader_na_geo.code_asp IS 'Code ASP du Groupe d''Action Locale';
COMMENT ON COLUMN met_zon.m_zon_gal_leader_na_geo.code_enrd IS 'Code ENRD (The European Network for Rural Development) du Groupe d''Action Locale';
COMMENT ON COLUMN met_zon.m_zon_gal_leader_na_geo.nom_gal_leader IS 'Nom du Groupe d''Action Locale LEADER';
COMMENT ON COLUMN met_zon.m_zon_gal_leader_na_geo.nom_gal_leader_2 IS 'Nom court du Groupe d''Action Locale LEADER';
COMMENT ON COLUMN met_zon.m_zon_gal_leader_na_geo.structure_porteuse IS 'Structure porteuse du GAL LEADER';
COMMENT ON COLUMN met_zon.m_zon_gal_leader_na_geo.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_zon.m_zon_gal_leader_na_geo.color IS 'Couleur du fond';
COMMENT ON COLUMN met_zon.m_zon_gal_leader_na_geo.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_zon.m_zon_gal_leader_na_geo.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN met_zon.m_zon_gal_leader_na_geo.geom IS 'Géometrie';


-- Insertion de la données géographique des GALs LEADER
INSERT INTO met_zon.m_zon_gal_leader_na_geo (
	code_region, code_gal, code_asp, code_enrd, nom_gal_leader, structure_porteuse, color,
	date_maj, geom
)
SELECT r1.code_region, r1.code_gal, r1.code_asp, r1.code_enrd, r1.nom_gal_leader, r1.structure_porteuse, r1.color, 
	now(), ST_Multi(ST_Union(r2.geom)) AS geom
FROM (
	SELECT t1.numcom, t1.code_region, t1.nom_gal_leader, t2.code_gal, t2.code_asp, t2.code_enrd, t2.structure_porteuse, t2.color
	FROM ref_zonage.t_appartenance_geo_com_gal_leader t1
	INNER JOIN met_zon.m_zon_lt_gal_leader t2
	ON t1.code_region = t2.code_region) r1
INNER JOIN ref_adminexpress.r_admexp_commune_fr r2
ON r1.numcom = r2.insee_com
GROUP BY r1.code_region, r1.nom_gal_leader, r1.code_gal, r1.code_asp, r1.code_enrd, r1.structure_porteuse, r1.color, now();





------------------------------------------------------------------------
------------------------------------------------------------------------
-- Mise à jour de l'appartenance des communes aux GALs à partir des EPCI

------------------------------------------------------------------------
-- GAL Angoumois ( communes) ==> A refaire

-- EPCI : CC de La Rochefoucauld Porte du Périgord
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader SET numgal_leader='16Leader01',	nomgal_leader='Angoumois' 
WHERE numepci IN ('200068914');

-- EPCI : une partie de la CA du Grand Angoulême
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader SET numgal_leader='16Leader01',	nomgal_leader='Angoumois' 
WHERE numepci IN ('200068914');


------------------------------------------------------------------------
-- GAL Nord Vienne (57 communes) ==> A refaire

-- EPCI : CC du Haut Poitou (en partie) + CA Grand Châtellerault (en partie) + CU du Grand Poitiers (en partie)

UPDATE ref_zonage.t_appartenance_geo_com_gal_leader 
SET numgal_leader='17Leader02',	nomgal_leader='Aunis' 
WHERE numepci IN ('', '', '');


------------------------------------------------------------------------
-- GAL Aunis (44 communes) ==> Ok

-- EPCI : CC d’Aunis Sud
-- EPCI : CC d’Aunis Atlantique
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader SET numgal_leader='17Leader01',	nomgal_leader='Aunis' 
WHERE numepci IN ('200041614', '200041499');

------------------------------------------------------------------------
-- GAL Charente-Limousine (58 communes) ==> Ok

-- EPCI : CC Charente Limousine
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader SET numgal_leader='16Leader02',	nomgal_leader='Charente-Limousine' 
WHERE numepci IN ('200072049');

------------------------------------------------------------------------
-- GAL Civraisien (36 communes) ==> Ok

-- EPCI : CC du Civraisien-en-Poitou
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader SET numgal_leader='86Leader02',	nomgal_leader='Civraisien' 
WHERE numepci IN ('200070035');

------------------------------------------------------------------------
-- GAL Haute-Saintonge (129 communes) ==> Ok

-- EPCI : CC de la Haute Saintonge
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader SET numgal_leader='17Leader02',	nomgal_leader='Haute-Saintonge' 
WHERE numepci IN ('200041523');

------------------------------------------------------------------------
-- GAL Mellois (62 communes) ==> Ok

-- EPCI : CC du Cellois, Coeur du Poitou, Mellois et Val de Boutonne
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader SET numgal_leader='79Leader02',	nomgal_leader='Mellois' 
WHERE numepci IN ('200069755');

------------------------------------------------------------------------
-- GAL Nord Deux-Sèvres (57 communes) ==> Ok

-- EPCI : Communauté d’Agglomération du Bocage Bressuirais 
-- EPCI : Communauté de communes du Thouarsais
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader SET numgal_leader='79Leader03',	nomgal_leader='Nord Deux-Sèvres' 
WHERE numepci IN ('200040244', '247900798');

------------------------------------------------------------------------
-- GAL Ouest Charente Pays du Cognac (57 communes) ==> Ok

-- EPCI : CC du Rouillacais
-- EPCI : Grand Cognac Communauté d’agglomération
UPDATE ref_zonage.t_appartenance_geo_com_gal_leader SET numgal_leader='17Leader02',	nomgal_leader='Aunis' 
WHERE numepci IN ('241600303', '200070514');


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
-- Table: met_gen.m_gen_feader_gal_leader_typo

-- DROP TABLE met_gen.m_gen_feader_gal_leader_typo;
CREATE TABLE met_gen.m_gen_feader_gal_leader_typo 
(
    id serial NOT NULL, 
    code_region character varying(80) NOT NULL,
    typo_tourisme boolean DEFAULT false, 
    typo_cult_patrimoine boolean DEFAULT false, 
    typo_sante boolean DEFAULT false, 
    typo_numerique_tic boolean DEFAULT false, 
    typo_agri_cc_alimentaire boolean DEFAULT false, 
    typo_enf_jeunesse boolean DEFAULT false, 
    typo_sports_loisirs boolean DEFAULT false, 
    typo_env_cli_trans_energetique boolean DEFAULT false, 
    typo_lien_ville_campagne boolean DEFAULT false, 
    typo_bois_foret boolean DEFAULT false, 
    typo_mobilite boolean DEFAULT false, 
    typo_dev_eco boolean DEFAULT false, 
    typo_log_habitat boolean DEFAULT false, 
    typo_accueil_serv_pop boolean DEFAULT false,
    progamme  character varying(9) NOT NULL,
    commentaire text,
    valide_data boolean NOT NULL DEFAULT(false),
	date_import date,
	date_maj date,
    CONSTRAINT m_gen_feader_gal_leader_typo_pkey PRIMARY KEY (id),
    CONSTRAINT m_gen_feader_gal_leader_typo_puniq UNIQUE (code_region)
);

--
GRANT ALL ON TABLE met_gen.m_gen_feader_gal_leader_typo TO "pre-sig-usr";
GRANT ALL ON TABLE met_gen.m_gen_feader_gal_leader_typo TO "pre-sig-ro";

COMMENT ON TABLE met_gen.m_gen_feader_gal_leader_typo
    IS 'Typologie d''investissement des GAL LEADER en Nouvelle-Aquitaine';

COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.id IS 'Identifiant';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.code_region IS 'Code région du Groupe d''Action Locale';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.typo_tourisme IS 'Typologie : Tourisme';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.typo_cult_patrimoine IS 'Typologie : Culture patrimoine';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.typo_sante IS 'Typologie : Santé';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.typo_numerique_tic IS 'Typologie : Numérique/TIC';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.typo_agri_cc_alimentaire IS 'Typologie : Agriculture circuit court alimentaire';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.typo_enf_jeunesse IS 'Typologie : Enfance jeunesse';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.typo_sports_loisirs IS 'Typologie : Sports/loisirs';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.typo_env_cli_trans_energetique IS 'Typologie : Environnement climat transition énergétique';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.typo_lien_ville_campagne IS 'Typologie : Lien ville-campagne';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.typo_bois_foret IS 'Typologie : Bois/forêt';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.typo_mobilite IS 'Typologie : Mobilité';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.typo_dev_eco IS 'Typologie : Développement économique ressources locales ESS';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.typo_log_habitat IS 'Typologie :  Logement habitat urbanisme rural';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.typo_accueil_serv_pop IS 'Typologie : Accueil services à la population';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.commentaire IS 'Commentaire';
COMMENT ON COLUMN met_gen.m_gen_feader_gal_leader_typo.valide_data IS 'Indique si la donnée attributaire est validée';

