-- drop materialized view RPRT_MV_MATERIAL_SHIPMENT_SUMMARY;

create materialized view RPRT_MV_MATERIAL_SHIPMENT_SUMMARY
partition by hash (day_key)
refresh force on demand
as 
with 
     DIM_DATE as (
        select day_key, substr(day_key,1,6) month_key, substr(day_key,1,4) year_key, 'AL' as his_key
        from (select to_char(to_date('13980101', 'yyyymmdd', 'nls_calendar=persian')+level, 'yyyymmdd', 'nls_calendar=persian') as day_key
              from dual connect by to_date('13980101', 'yyyymmdd', 'nls_calendar=persian') + level <= sysdate) 
     ),

     FACT_ONWAY_REMITTANCE as (
        select l.dat, l.dat_ym, l.dat_y, 'AL' as dat_his, 
             l.tozine_id, l.sourceid, l.material, l.key_1, l.is_rail, l.pkg, l.wazn, 
             t.dat as arrived_dat, t.wazn as arrived_weight
        from RPRT_TB_FACT_LOGESTIC_TOZIN l, 
             (select sz_tozin_id, dat, wazn, sum(pkg_cnt) pkg_cnt 
              from RPRT_MV_FACT_REMITTANCE
              where io_dir='I' /*and z_source_id not in (2320,2340,2555) */ 
              group by sz_tozin_id, dat, wazn 
             ) t
        where l.tozine_id = t.sz_tozin_id(+)
              and tozine_id not like '3-%' and l.targetid in (2320,2340,2555)    
              and l.dat > '13990000'
     ),
     
     MATERIAL_SHIPMENT_HISTO_FLATTED as (
        select d.day_key, d.month_key, d.year_key, d.his_key,
               o.sourceid, o.material, o.key_1, o.is_rail, 
               nvl2(o.arrived_dat, case when o.arrived_dat <= o.dat then 1 else 0 end , 0) arrived,       
               decode(d.day_key, o.dat, 1, 0) agg_day,
               decode(d.month_key, o.dat_ym, 1, 0) agg_month,
               decode(d.year_key, o.dat_y, 1, 0) agg_year,
               decode(d.his_key, o.dat_his, 1, 0) agg_all,
               o.pkg,
               nvl2(o.arrived_dat, case when o.arrived_dat <= o.dat then o.arrived_weight else o.wazn end , o.wazn) weight
        from dim_date d,  fact_onway_remittance o
        where d.day_key >= o.dat
     ),

     MAT_SHIPMENT_DETAIL as (
        select /*+ parallel(4) */ 
               distinct day_key, SOURCEID, MATERIAL, KEY_1, IS_RAIL, ARRIVED,
                         
               sum(decode(AGG_ALL,1,PKG,0)) over (partition by DAY_KEY, SOURCEID, MATERIAL, IS_RAIL, KEY_1, ARRIVED ) PKG_HIS,
               sum(decode(AGG_YEAR,1,PKG,0)) over (partition by DAY_KEY, SOURCEID, MATERIAL, IS_RAIL, KEY_1, ARRIVED ) PKG_YEAR,
               sum(decode(AGG_MONTH,1,PKG,0)) over (partition by DAY_KEY, SOURCEID, MATERIAL, IS_RAIL, KEY_1, ARRIVED ) PKG_MONTH,
               sum(decode(AGG_DAY,1,PKG,0)) over (partition by DAY_KEY, SOURCEID, MATERIAL, IS_RAIL, KEY_1, ARRIVED ) PKG_DAY,

               sum(decode(AGG_ALL,1,weight,0)) over (partition by DAY_KEY, SOURCEID, MATERIAL, IS_RAIL, KEY_1, ARRIVED ) WGT_HIS,
               sum(decode(AGG_YEAR,1,weight,0)) over (partition by DAY_KEY, SOURCEID, MATERIAL, IS_RAIL, KEY_1, ARRIVED ) WGT_YEAR,
               sum(decode(AGG_MONTH,1,weight,0)) over (partition by DAY_KEY, SOURCEID, MATERIAL, IS_RAIL, KEY_1, ARRIVED ) WGT_MONTH,
               sum(decode(AGG_DAY,1,weight,0)) over (partition by DAY_KEY, SOURCEID, MATERIAL, IS_RAIL, KEY_1, ARRIVED ) WGT_DAY       
        from material_shipment_histo_flatted 
     ),

     MAT_SHIPMENT_SUMARY as (
        select t.day_key,
               nvl(t.sourceid, -1) sourceid,
               nvl(t.material, -1) material,
               nvl(t.is_rail, -1) is_rail,
               t.arrived,
               sum(t.pkg_HIS)   pkg_his,
               sum(t.pkg_year)  pkg_year,
               sum(t.pkg_month) pkg_month,
               sum(t.pkg_day)   pkg_day,
               sum(t.wgt_HIS)   wgt_his,
               sum(t.wgt_year)  wgt_year,
               sum(t.wgt_month) wgt_month,
               sum(t.wgt_day)   wgt_day
        from mat_shipment_detail t
        group by t.day_key, t.arrived, GROUPING SETS( (t.sourceid, t.material, t.is_rail), (t.is_rail))
    )

select 
   a.day_key,
   decode(a.arrived, 0,'OW', 1,'AR')||','||decode(nvl(a.is_rail, -1), 0,'RD', 1,'RL', -1,'ALW') pv_key,
   a.sourceid, a.material, a.is_rail, a.arrived,
   --       
   a.pkg_his, a.pkg_year, a.pkg_month, a.pkg_day,
   a.wgt_his, a.wgt_year, a.wgt_month, a.wgt_day,
   --
   b.pkg_his as allmat_pkg_his,  b.pkg_year as allmat_pkg_year,  b.pkg_month as allmat_pkg_month,  b.pkg_day as allmat_pkg_day,
   b.wgt_his as allmat_wgt_his,  b.wgt_year as allmat_wgt_year,  b.wgt_month as allmat_wgt_month,  b.wgt_day as allmat_wgt_day
from 
     (select distinct * from mat_shipment_sumary where sourceid<>-1 and material<>-1 and is_rail<> -1) a, 
     (select distinct * from mat_shipment_sumary where sourceid=-1 and material=-1 and is_rail<> -1) b
where a.day_key = b.day_key and a.arrived=b.arrived and a.is_rail=b.is_rail;


