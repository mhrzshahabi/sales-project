-- drop materialized view RPRT_MV_MATERIAL_IO_SUMMARY ;

create materialized view RPRT_MV_MATERIAL_IO_SUMMARY 
refresh force on demand as
with 
    RPRT_DIM_DSM as  (
      select /*+ materialize*/ dd.date__ as dat,
             substr(dd.date__,1,6) dat_ym,
             substr(dd.date__,1,4) dat_y,
             'AL' as dat_his,
             vv.source_id source,
             vv.source_name,
             vv.material_id material,
             vv.material_name,
             vv.unit_name unit
      from ( select to_char(to_date('13980101', 'yyyymmdd', 'nls_calendar=persian') + level - 1, 'yyyymmdd', 'nls_calendar=persian') as date__
             from dual
             connect by to_date('13980101', 'yyyymmdd', 'nls_calendar=persian') + level <= current_date
           ) dd, (select * from report_material_source_bandarabas) vv
    ),
    
    MAT_INPUT_AGG as (
      select distinct a.dat, a.source, a.material,     
             sum (nvl(K.n_amount,0))      over (partition by  a.source, a.material, a.dat) IN_AMOUNT_DAY,
             sum (nvl(K.pkg_cnt,0))       over (partition by  a.source, a.material, a.dat) IN_PKG_DAY,
             sum (nvl(K.rmt_det_wanz,0))  over (partition by  a.source, a.material, a.dat) IN_WEIGHT_DAY,

             sum (nvl(K.n_amount,0))      over (partition by  a.source, a.material, a.dat_ym order by a.dat range between unbounded preceding and current row) IN_AMOUNT_MONTH,
             sum (nvl(K.pkg_cnt,0))       over (partition by  a.source, a.material, a.dat_ym order by a.dat range between unbounded preceding and current row) IN_PKG_MONTH,
             sum (nvl(K.rmt_det_wanz,0))  over (partition by  a.source, a.material, a.dat_ym order by a.dat range between unbounded preceding and current row) IN_WEIGHT_MONTH,
             
             sum (nvl(K.n_amount,0))      over (partition by  a.source, a.material, a.dat_y order by a.dat range between unbounded preceding and current row) IN_AMOUNT_YEAR,
             sum (nvl(K.pkg_cnt,0))       over (partition by  a.source, a.material, a.dat_y order by a.dat range between unbounded preceding and current row) IN_PKG_YEAR,
             sum (nvl(K.rmt_det_wanz,0))  over (partition by  a.source, a.material, a.dat_y order by a.dat range between unbounded preceding and current row) IN_WEIGHT_YEAR,

             sum (nvl(K.n_amount,0))      over (partition by  a.source, a.material order by a.dat range between unbounded preceding and current row) IN_AMOUNT_HIS,
             sum (nvl(K.pkg_cnt,0))       over (partition by  a.source, a.material order by a.dat range between unbounded preceding and current row) IN_PKG_HIS,
             sum (nvl(K.rmt_det_wanz,0))  over (partition by  a.source, a.material order by a.dat range between unbounded preceding and current row) IN_WEIGHT_HIS

      from RPRT_DIM_DSM a, RPRT_MV_FACT_REMITTANCE K
      where io_dir(+)='I' and a.dat = K.dat(+) and a.source= K.sz_source_id(+) and a.material= K.material(+)
    ),

    MAT_OUTPUT_AGG as (
      select distinct a.dat, a.source, a.material,     
             sum (nvl(K.n_amount,0))      over (partition by  a.source, a.material, a.dat) OUT_AMOUNT_DAY,
             sum (nvl(K.pkg_cnt,0))       over (partition by  a.source, a.material, a.dat) OUT_PKG_DAY,
             sum (nvl(K.rmt_det_wanz,0))  over (partition by  a.source, a.material, a.dat) OUT_WEIGHT_DAY,

             sum (nvl(K.n_amount,0))      over (partition by  a.source, a.material, a.dat_ym order by a.dat range between unbounded preceding and current row) OUT_AMOUNT_MONTH,
             sum (nvl(K.pkg_cnt,0))       over (partition by  a.source, a.material, a.dat_ym order by a.dat range between unbounded preceding and current row) OUT_PKG_MONTH,
             sum (nvl(K.rmt_det_wanz,0))  over (partition by  a.source, a.material, a.dat_ym order by a.dat range between unbounded preceding and current row) OUT_WEIGHT_MONTH,
                       
             sum (nvl(K.n_amount,0))      over (partition by  a.source, a.material, a.dat_y order by a.dat range between unbounded preceding and current row) OUT_AMOUNT_YEAR,
             sum (nvl(K.pkg_cnt,0))       over (partition by  a.source, a.material, a.dat_y order by a.dat range between unbounded preceding and current row) OUT_PKG_YEAR,
             sum (nvl(K.rmt_det_wanz,0))  over (partition by  a.source, a.material, a.dat_y order by a.dat range between unbounded preceding and current row) OUT_WEIGHT_YEAR,

             sum (nvl(K.n_amount,0))      over (partition by  a.source, a.material order by a.dat range between unbounded preceding and current row) OUT_AMOUNT_HIS,
             sum (nvl(K.pkg_cnt,0))       over (partition by  a.source, a.material order by a.dat range between unbounded preceding and current row) OUT_PKG_HIS,
             sum (nvl(K.rmt_det_wanz,0))  over (partition by  a.source, a.material order by a.dat range between unbounded preceding and current row) OUT_WEIGHT_HIS

      from RPRT_DIM_DSM a, RPRT_MV_FACT_REMITTANCE K 
      where io_dir(+)='O' and a.dat = K.dat(+) and a.source= K.sz_source_id(+) and a.material=K.material(+)
    ),
    MAT_IO_AGG as (
      select i.dat, i.source, i.material, 
         in_amount_day, in_pkg_day, in_weight_day, in_amount_month, in_pkg_month, in_weight_month, in_amount_year, in_pkg_year, in_weight_year,
         out_amount_day, out_pkg_day, out_weight_day, out_amount_month, out_pkg_month, out_weight_month, out_amount_year, out_pkg_year, out_weight_year,
         in_pkg_his - out_pkg_his       as REMAINED_PKG,
         in_amount_his - out_amount_his as REMAINED_AMOUNT,
         in_weight_his - out_weight_his as REMAINED_WEIGHT,
         -- case when (in_pkg_his - out_pkg_his) = 0 then 0-(in_weight_his - out_weight_his) else 0 end GROSS_TADIL,
         case when (in_pkg_his - out_pkg_his) = 0 then 
           (case when (in_pkg_his - out_pkg_his) = 0 then 0-(in_weight_his - out_weight_his) else 0 end) 
           - sum( case when (in_pkg_his - out_pkg_his) = 0 then 0-(in_weight_his - out_weight_his) else 0 end ) 
                over (order by i.dat rows between unbounded preceding and 1 preceding)            
         else 0 end TADIL           
      from mat_input_agg i, mat_output_agg o
      where i.dat=o.dat and i.source=o.source and i.material=o.material
    ),
    MAT_IO_AGG_TAD as (
      select j.*,
             sum(TADIL) over (partition by substr(j.dat,1,6)) TADIL_MONTH,
             sum(TADIL) over (partition by substr(j.dat,1,4)) TADIL_YEAR
      from MAT_IO_AGG j
    )

select t.*,
       round(tadil_year/(case when out_weight_year>0 then out_weight_year else 1 end)*100, 2) TADIL_YEAR_PERCENT,
       sum (in_amount_day)    over (partition by t.dat, t.material) SUM_IN_AMOUNT_DAY, 
       sum (in_pkg_day)       over (partition by t.dat, t.material) SUM_IN_PKG_DAY, 
       sum (in_weight_day)    over (partition by t.dat, t.material) SUM_IN_WEIGHT_DAY, 
       sum (in_amount_month)  over (partition by t.dat, t.material) SUM_IN_AMOUNT_MONTH, 
       sum (in_pkg_month)     over (partition by t.dat, t.material) SUM_IN_PKG_MONTH, 
       sum (in_weight_month)  over (partition by t.dat, t.material) SUM_IN_WEIGHT_MONTH, 
       sum (in_amount_year)   over (partition by t.dat, t.material) SUM_IN_AMOUNT_YEAR, 
       sum (in_pkg_year)      over (partition by t.dat, t.material) SUM_IN_PKG_YEAR, 
       sum (in_weight_year)   over (partition by t.dat, t.material) SUM_IN_WEIGHT_YEAR, 
       sum (out_amount_day)   over (partition by t.dat, t.material) SUM_OUT_AMOUNT_DAY, 
       sum (out_pkg_day)      over (partition by t.dat, t.material) SUM_OUT_PKG_DAY, 
       sum (out_weight_day)   over (partition by t.dat, t.material) SUM_OUT_WEIGHT_DAY, 
       sum (out_amount_month) over (partition by t.dat, t.material) SUM_OUT_AMOUNT_MONTH, 
       sum (out_pkg_month)    over (partition by t.dat, t.material) SUM_OUT_PKG_MONTH, 
       sum (out_weight_month) over (partition by t.dat, t.material) SUM_OUT_WEIGHT_MONTH, 
       sum (out_amount_year)  over (partition by t.dat, t.material) SUM_OUT_AMOUNT_YEAR, 
       sum (out_pkg_year)     over (partition by t.dat, t.material) SUM_OUT_PKG_YEAR, 
       sum (out_weight_year)  over (partition by t.dat, t.material) SUM_OUT_WEIGHT_YEAR, 
       sum (remained_pkg)     over (partition by t.dat, t.material) SUM_REMAINED_PKG, 
       sum (remained_amount)  over (partition by t.dat, t.material) SUM_REMAINED_AMOUNT, 
       sum (remained_weight)  over (partition by t.dat, t.material) SUM_REMAINED_WEIGHT, 
       sum (tadil)            over (partition by t.dat, t.material) SUM_TADIL, 
       sum (tadil_month)      over (partition by t.dat, t.material) SUM_TADIL_MONTH, 
       sum (tadil_year)       over (partition by t.dat, t.material) SUM_TADIL_YEAR,       
       round( sum(tadil_year)over(partition by t.dat, t.material) / (case when out_weight_year>0 then out_weight_year else 1 end)*100, 2) SUM_TADIL_YEAR_PERCENT
from MAT_IO_AGG_TAD t
;
