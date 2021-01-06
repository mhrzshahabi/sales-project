/*
grant create materialized view to saleslocal;
grant create materialized view to dev_sales;
*/

-- Indexes:
DECLARE i INTEGER
BEGIN

SELECT COUNT(*) INTO i FROM user_indexes WHERE index_name = 'IDX_DBA_REMITTANCE_DET_INVID'
IF i = 0 THEN
    EXECUTE IMMEDIATE 'create index IDX_DBA_REMITTANCE_DET_INVID on TBL_WARH_REMITTANCE_DETAIL (f_inventory_id)'
END IF

SELECT COUNT(*) INTO i FROM user_indexes WHERE index_name = 'IDX_DBA_REMITTANCE_DESTOZINID'
IF i = 0 THEN
    EXECUTE IMMEDIATE 'create index IDX_DBA_REMITTANCE_DESTOZINID on TBL_WARH_REMITTANCE_DETAIL (f_destination_tozine_id)'
END IF

SELECT COUNT(*) INTO i FROM user_indexes WHERE index_name = 'IDX_DBA_REMITTANCE_SRCTOZINID'
IF i = 0 THEN
    EXECUTE IMMEDIATE 'create index IDX_DBA_REMITTANCE_SRCTOZINID on TBL_WARH_REMITTANCE_DETAIL (f_source_tozine_id)'
END IF

SELECT COUNT(*) INTO i FROM user_indexes WHERE index_name = 'IDX_DBA_REMITTANCE_UNITID'
IF i = 0 THEN
    EXECUTE IMMEDIATE 'create index IDX_DBA_REMITTANCE_UNITID on TBL_WARH_REMITTANCE_DETAIL (f_unit_id)'
END IF

SELECT COUNT(*) INTO i FROM user_indexes WHERE index_name = 'IDX_DBA_WARHTOZIN_FADATE'
IF i = 0 THEN
    EXECUTE IMMEDIATE 'create index IDX_DBA_WARHTOZIN_FADATE on TBL_WARH_TOZIN(DAT)'
END IF
END
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
