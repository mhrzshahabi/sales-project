-- DROP MATERIALIZED VIEW RPRT_MV_FACT_REMITTANCE;

CREATE MATERIALIZED VIEW RPRT_MV_FACT_REMITTANCE
PARTITION BY hash (dat)
REFRESH COMPLETE ON DEMAND
as
select
       z.dat,
       substr(z.dat,1,4) dat_y,       
       substr(z.dat,1,6) dat_ym,       
       nvl2(r.f_destination_tozine_id, 'I', 'O') IO_DIR,
       sz.sourceid sz_source_id,
       to_number(z.gdscode) material,     
       z.wazn wazn,
       r.n_amount  n_amount,
       decode(to_number(z.gdscode), 97, r.n_amount, 1) pkg_cnt,
       TO_CHAR(sz.sourceid)||';'||trim(z.gdscode) key_1,
       sz.tozine_id sz_tozin_id,
       z.wazn/count(*) over(partition by z.id) rmt_det_wanz
from tbl_warh_tozin z, tbl_warh_remittance_detail r, tbl_warh_remittance_detail sr, tbl_warh_tozin sz
where nvl(r.f_destination_tozine_id, r.f_source_tozine_id)=z.id
      and (r.f_inventory_id = sr.f_inventory_id(+) and sr.f_destination_tozine_id(+) is not null and sr.f_source_tozine_id = sz.id)
;
