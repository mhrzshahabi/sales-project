create or replace view RPRT_V_MATERIAL_SHIPMENT_STATS as 
select 
    day_key,
    sourceid,
    material,    

    -- DAY  
    nvl(ril_arv_PKG_DAY,0)        owp_day_arrived_tozin_rail,
    nvl(ril_ow_PKG_DAY,0)         owp_day_not_arrived_tozin_rail,
    nvl(ril_arv_WGT_DAY,0)        owp_day_arrived_weight_rail,
    nvl(ril_ow_WGT_DAY,0)         owp_day_not_arrived_weight_rail,
    nvl(rd_arv_PKG_DAY,0)         owp_day_arrived_tozin_road,
    nvl(rd_ow_PKG_DAY,0)          owp_day_not_arrived_tozin_road,
    nvl(rd_arv_WGT_DAY,0)         owp_day_arrived_weight_road,
    nvl(rd_ow_WGT_DAY,0)          owp_day_not_arrived_weight_road,
    -- MONTH
    nvl(ril_arv_PKG_MONTH,0)      owp_month_arrived_tozin_rail,
    nvl(ril_ow_PKG_MONTH,0)       owp_month_not_arrived_tozin_rail,
    nvl(ril_arv_WGT_MONTH,0)      owp_month_arrived_weight_rail,
    nvl(ril_ow_WGT_MONTH,0)       owp_month_not_arrived_weight_rail,
    nvl(rd_arv_PKG_MONTH,0)       owp_month_arrived_tozin_road,
    nvl(rd_ow_PKG_MONTH,0)        owp_month_not_arrived_tozin_road,
    nvl(rd_arv_WGT_MONTH,0)       owp_month_arrived_weight_road,
    nvl(rd_ow_WGT_MONTH,0)        owp_month_not_arrived_weight_road,
    -- YEAR
    nvl(ril_arv_PKG_YEAR,0)       owp_year_arrived_tozin_rail,
    nvl(ril_ow_PKG_YEAR,0)        owp_year_not_arrived_tozin_rail,
    nvl(ril_arv_WGT_YEAR,0)       owp_year_arrived_weight_rail,
    nvl(ril_ow_WGT_YEAR,0)        owp_year_not_arrived_weight_rail,
    nvl(rd_arv_PKG_YEAR,0)        owp_year_arrived_tozin_road,
    nvl(rd_ow_PKG_YEAR,0)         owp_year_not_arrived_tozin_road,
    nvl(rd_arv_WGT_YEAR,0)        owp_year_arrived_weight_road,
    nvl(rd_ow_WGT_YEAR,0)         owp_year_not_arrived_weight_road,

    -- OnWay_Hist
    nvl(ril_ow_PKG_HIS,0)         owp_total_not_arrived_tozin_rail,
    nvl(ril_ow_WGT_HIS,0)         owp_total_not_arrived_weight_rail,
    nvl(rd_ow_PKG_HIS,0)          owp_total_not_arrived_tozin_road,
    nvl(rd_ow_WGT_HIS,0)          owp_total_not_arrived_weight_road,

    nvl(ril_ow_PKG_HIS,0)+nvl(rd_ow_PKG_HIS,0) owp_total_not_arrived_tozin,
    nvl(ril_ow_WGT_HIS,0)+nvl(rd_ow_WGT_HIS,0) owp_total_not_arrived_weight,

    /*
    -- OnWay_Hist_AnySource (مجموع سرویس، کامیون،کانتینر) (به تفکیک  محصولات، بدون تفکیک مبدا)
    nvl(ril_ow_ALLSRC_PKG_HIS,0)  owp_total_not_arrived_tozin_rail_all_material,
    nvl(ril_ow_ALLSRC_WGT_HIS,0)  owp_total_not_arrived_weight_rail_all_material,
    nvl(rd_ow_ALLSRC_PKG_HIS,0)   owp_total_not_arrived_tozin_road_all_material,
    nvl(rd_ow_ALLSRC_WGT_HIS,0)   owp_total_not_arrived_weight_road_all_material,
    nvl(ril_ow_ALLSRC_PKG_HIS,0)+nvl(rd_ow_ALLSRC_PKG_HIS,0) owp_total_not_arrived_tozin_all_material,
    nvl(ril_ow_ALLSRC_WGT_HIS,0)+nvl(rd_ow_ALLSRC_WGT_HIS,0) owp_total_not_arrived_weight_all_material,
    --*/
    
    -- OnWay_Hist_AnySource (مجموع سرویس، کامیون،کانتینر)
    nvl(ril_ow_ALM_PKG_HIS,0)  owp_total_not_arrived_tozin_rail_all_material,
    nvl(ril_ow_ALM_WGT_HIS,0)  owp_total_not_arrived_weight_rail_all_material,
    nvl(rd_ow_ALM_PKG_HIS,0)   owp_total_not_arrived_tozin_road_all_material,
    nvl(rd_ow_ALM_WGT_HIS,0)   owp_total_not_arrived_weight_road_all_material,
    nvl(ril_ow_ALM_PKG_HIS,0)+nvl(rd_ow_ALM_PKG_HIS,0) owp_total_not_arrived_tozin_all_material,
    nvl(ril_ow_ALM_WGT_HIS,0)+nvl(rd_ow_ALM_WGT_HIS,0) owp_total_not_arrived_weight_all_material,    

    -- ALM_DAY مجموع کانتینتر/کامیون
    nvl(ril_arv_ALM_PKG_DAY,0)    owp_day_arrived_tozin_rail_all_material,
    nvl(ril_arv_ALM_WGT_DAY,0)    owp_day_arrived_weight_rail_all_material,
    nvl(ril_ow_ALM_PKG_DAY,0)     owp_day_not_arrived_tozin_rail_all_material,
    nvl(ril_ow_ALM_WGT_DAY,0)     owp_day_not_arrived_weight_rail_all_material,
    nvl(rd_arv_ALM_PKG_DAY,0)     owp_day_arrived_tozin_road_all_material,
    nvl(rd_arv_ALM_WGT_DAY,0)     owp_day_arrived_weight_road_all_material,
    nvl(rd_ow_ALM_PKG_DAY,0)      owp_day_not_arrived_tozin_road_all_material,
    nvl(rd_ow_ALM_WGT_DAY,0)      owp_day_not_arrived_weight_road_all_material,
    -- ALM_MONTH مجموع کانتینتر/کامیون
    nvl(ril_arv_ALM_PKG_MONTH,0)  owp_month_arrived_tozin_rail_all_material,
    nvl(ril_arv_ALM_WGT_MONTH,0)  owp_month_arrived_weight_rail_all_material,
    nvl(ril_ow_ALM_PKG_MONTH,0)   owp_month_not_arrived_tozin_rail_all_material,
    nvl(ril_ow_ALM_WGT_MONTH,0)   owp_month_not_arrived_weight_rail_all_material,
    nvl(rd_arv_ALM_PKG_MONTH,0)   owp_month_arrived_tozin_road_all_material,
    nvl(rd_arv_ALM_WGT_MONTH,0)   owp_month_arrived_weight_road_all_material,
    nvl(rd_ow_ALM_PKG_MONTH,0)    owp_month_not_arrived_tozin_road_all_material,
    nvl(rd_ow_ALM_WGT_MONTH,0)    owp_month_not_arrived_weight_road_all_material,
    -- ALM_YEAR مجموع کانتینتر/کامیون
    nvl(ril_arv_ALM_PKG_YEAR,0)   owp_year_arrived_tozin_rail_all_material,
    nvl(ril_arv_ALM_WGT_YEAR,0)   owp_year_arrived_weight_rail_all_material,
    nvl(ril_ow_ALM_PKG_YEAR,0)    owp_year_not_arrived_tozin_rail_all_material,
    nvl(ril_ow_ALM_WGT_YEAR,0)    owp_year_not_arrived_weight_rail_all_material,
    nvl(rd_arv_ALM_PKG_YEAR,0)    owp_year_arrived_tozin_road_all_material,
    nvl(rd_arv_ALM_WGT_YEAR,0)    owp_year_arrived_weight_road_all_material,
    nvl(rd_ow_ALM_PKG_YEAR,0)     owp_year_not_arrived_tozin_road_all_material,
    nvl(rd_ow_ALM_WGT_YEAR,0)     owp_year_not_arrived_weight_road_all_material,
    -- ALL_YEAR مجموع سرویسها
    nvl(ril_ow_ALM_PKG_DAY,0)+nvl(rd_ow_ALM_PKG_DAY,0)    owp_day_not_arrived_tozin_all_material,
    nvl(ril_ow_ALM_WGT_DAY,0)+nvl(rd_ow_ALM_WGT_DAY,0)    owp_day_not_arrived_weight_all_material,
    nvl(ril_arv_ALM_PKG_DAY,0)+nvl(rd_arv_ALM_PKG_DAY,0)   owp_day_arrived_tozin_all_material,
    nvl(ril_arv_ALM_WGT_DAY,0)+nvl(rd_arv_ALM_WGT_DAY,0)   owp_day_arrived_weight_all_material,
    -- 
    nvl(ril_ow_ALM_PKG_MONTH,0)+nvl(rd_ow_ALM_PKG_MONTH,0)     owp_month_not_arrived_tozin_all_material,
    nvl(ril_ow_ALM_WGT_MONTH,0)+nvl(rd_ow_ALM_WGT_MONTH,0)     owp_month_not_arrived_weight_all_material,
    nvl(ril_arv_ALM_PKG_MONTH,0)+nvl(rd_arv_ALM_PKG_MONTH,0)   owp_month_arrived_tozin_all_material,
    nvl(ril_arv_ALM_WGT_MONTH,0)+nvl(rd_arv_ALM_WGT_MONTH,0)   owp_month_arrived_weight_all_material,
    -- 
    nvl(ril_ow_ALM_PKG_YEAR,0)+nvl(rd_ow_ALM_PKG_YEAR,0)      owp_year_not_arrived_tozin_all_material,
    nvl(ril_ow_ALM_WGT_YEAR,0)+nvl(rd_ow_ALM_WGT_YEAR,0)      owp_year_not_arrived_weight_all_material,
    nvl(ril_arv_ALM_PKG_YEAR,0)+nvl(rd_arv_ALM_PKG_YEAR,0)    owp_year_arrived_tozin_all_material,
    nvl(ril_arv_ALM_WGT_YEAR,0)+nvl(rd_arv_ALM_WGT_YEAR,0)    owp_year_arrived_weight_all_material
from (
   select t.day_key, t.PV_KEY, t.sourceid, t.material,
          t.pkg_his, t.pkg_year, t.pkg_month, t.pkg_day,
          t.wgt_his, t.wgt_year, t.wgt_month, t.wgt_day,

          t.allmat_pkg_his, t.allmat_pkg_year, t.allmat_pkg_month, t.allmat_pkg_day,
          t.allmat_wgt_his, t.allmat_wgt_year, t.allmat_wgt_month, t.allmat_wgt_day
   from RPRT_MV_MATERIAL_SHIPMENT_SUMMARY t
)
pivot (
     sum(pkg_day) pkg_day,
     sum(pkg_month) pkg_month,
     sum(pkg_year) pkg_year,
     sum(pkg_his) pkg_his,
     sum(wgt_day) wgt_day,
     sum(wgt_month) wgt_month,
     sum(wgt_year) wgt_year,
     sum(wgt_his) wgt_his,

     sum(allmat_pkg_day) alm_pkg_day,
     sum(allmat_pkg_month) alm_pkg_month,
     sum(allmat_pkg_year) alm_pkg_year,
     sum(allmat_pkg_his) alm_pkg_his,
     sum(allmat_wgt_day) alm_wgt_day,
     sum(allmat_wgt_month) alm_wgt_month,
     sum(allmat_wgt_year) alm_wgt_year,
     sum(allmat_wgt_his) alm_wgt_his
     
     for PV_KEY in (
         'AR,RD' as rd_arv,
         'AR,RL' as ril_arv,
         'OW,RD' as rd_ow,
         'OW,RL' as ril_ow
         ) 
) k;
