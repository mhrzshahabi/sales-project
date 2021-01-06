/*
grant create materialized view to saleslocal;
grant create materialized view to dev_sales;
*/

-- Indexes:
create index IDX_DBA_REMITTANCE_DET_INVID on TBL_WARH_REMITTANCE_DETAIL (f_inventory_id);
create index IDX_DBA_REMITTANCE_DESTOZINID on TBL_WARH_REMITTANCE_DETAIL (f_destination_tozine_id);
create index IDX_DBA_REMITTANCE_SRCTOZINID on TBL_WARH_REMITTANCE_DETAIL (f_source_tozine_id);
create index IDX_DBA_REMITTANCE_UNITID on TBL_WARH_REMITTANCE_DETAIL (f_unit_id);
create index IDX_DBA_WARHTOZIN_FADATE on TBL_WARH_TOZIN(DAT);

/*
-- MV Logs:
create materialized view log on tbl_warh_tozin with rowid;
create materialized view log on tbl_warh_remittance_detail with rowid;
*/

/* If DROP:
drop materialized view log on tbl_warh_tozin;
drop materialized view log on tbl_warh_remittance_detail;
*/


-- drop table RPRT_TB_FACT_LOGESTIC_TOZIN;
