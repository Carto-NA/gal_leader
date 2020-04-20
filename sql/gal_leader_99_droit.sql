/* GAL LEADER V1.0 */
/* Creation des droits sur l'ensemble des objets */
/* gal_leader_99_droit.sql */
/* PostgreSQL/PostGIS */
/* Conseil régional Nouvelle-Aquitaine - https://cartographie.nouvelle-aquitaine.fr/ */
/* Auteur : Tony VINCENT */

------------------------------------------------------------------------ 
-- Grant : Droits des éléments
------------------------------------------------------------------------

-- Tables : met_zon.m_zon_compo_gal_leader_na
GRANT ALL ON TABLE met_zon.m_zon_compo_gal_leader_na TO "pre-sig-usr";
GRANT SELECT ON TABLE met_zon.m_zon_compo_gal_leader_na TO "pre-sig-ro";
