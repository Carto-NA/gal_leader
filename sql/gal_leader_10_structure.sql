/* GAL LEADER V1.0 */
/* Creation de la structure des données (tables, séquences, triggers,...) */
/* gal_leader_10_structure.sql */
/* PostgreSQL/PostGIS */
/* Conseil régional Nouvelle-Aquitaine - https://cartographie.nouvelle-aquitaine.fr/ */
/* Auteur : Tony VINCENT */


------------------------------------------------------------------------
-- Table: met_zon.m_zon_compo_gal_leader_na

-- DROP TABLE met_zon.m_zon_compo_gal_leader_na;
CREATE TABLE met_zon.m_zon_compo_gal_leader_na
(
	id serial NOT NULL,
	numcom character varying(5),
	nomcom character varying(150),
	siren character varying(9),
	numdep character varying(2),
	code_gal_leader character varying(5),	
	nom_gal_leader character varying(255),
	cog_annee character varying(4),
	commentaires text,
	date_import date,
	date_maj date,
    CONSTRAINT m_zon_compo_gal_leader_na_pkey PRIMARY KEY (id),
    CONSTRAINT m_zon_compo_gal_leader_na_uniq UNIQUE (numcom)
);

--
COMMENT ON TABLE met_zon.m_zon_compo_gal_leader_na IS 'Table d''appartenance des communes au GAL LEADER en Nouvelle-Aquitaine';

--
COMMENT ON COLUMN met_zon.m_zon_compo_gal_leader_na.id IS 'Identifiant';
COMMENT ON COLUMN met_zon.m_zon_compo_gal_leader_na.numcom IS 'Code INSEE de la commune';
COMMENT ON COLUMN met_zon.m_zon_compo_gal_leader_na.nomcom IS 'Nom de la commune';
COMMENT ON COLUMN met_zon.m_zon_compo_gal_leader_na.siren IS 'Numéro SIREN de la commune';
COMMENT ON COLUMN met_zon.m_zon_compo_gal_leader_na.numdep IS 'Numéro département du projet';
COMMENT ON COLUMN met_zon.m_zon_compo_gal_leader_na.code_gal_leader IS 'Code du Groupe d''Action Locale';
COMMENT ON COLUMN met_zon.m_zon_compo_gal_leader_na.nom_gal_leader IS 'Nom du Groupe d''Action Locale LEADER';
COMMENT ON COLUMN met_zon.m_zon_compo_gal_leader_na.cog_annee IS 'Année COG de référence';
COMMENT ON COLUMN met_zon.m_zon_compo_gal_leader_na.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_zon.m_zon_compo_gal_leader_na.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_zon.m_zon_compo_gal_leader_na.date_maj IS 'Date de mise à jour de la donnée';


-- Ajout de données
INSERT INTO met_zon.m_zon_compo_gal_leader_na (
	numcom, nomcom, siren, numdep, 
	code_gal_leader, nom_gal_leader, 
	cog_annee,
	date_import
)
SELECT 
	numcom, nomcom, siren, coddep_com,
	cod_leader_1420initial, nom_leader_gal_1420initial,
	CASE WHEN a=1 THEN 'un'
            WHEN a=2 THEN 'deux'
            ELSE 'autres'
       END
	cog, 
	--cod_leader_1420_maj, nom_leader_gal_1420_maj,
	'21/04/2020'
FROM z_maj."20200420_compo_gal_leader_com19";
