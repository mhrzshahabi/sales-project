create or replace view VIEW_DAILY_REPORT2555 as
select rows_.dat,
       rows_.unit,
       rows_.source,
       rows_.material,
       rows_.source_name                                      as source_name,
       rows_.material_name                                    as material_name,
       nvl(owp_day_arrived_tozin_rail, 0)                     as owp_day_arrived_tozin_rail,
       nvl(owp_day_not_arrived_tozin_rail, 0)                 as owp_day_not_arrived_tozin_rail,
       nvl(owp_day_arrived_weight_rail, 0)                    as owp_day_arrived_weight_rail,
       nvl(owp_day_not_arrived_weight_rail, 0)                as owp_day_not_arrived_weight_rail,
       nvl(owp_day_arrived_tozin_road, 0)                     as owp_day_arrived_tozin_road,
       nvl(owp_day_not_arrived_tozin_road, 0)                 as owp_day_not_arrived_tozin_road,
       nvl(owp_day_arrived_weight_road, 0)                    as owp_day_arrived_weight_road,
       nvl(owp_day_not_arrived_weight_road, 0)                as owp_day_not_arrived_weight_road,
       nvl(owp_total_not_arrived_weight_rail, 0)              as owp_total_not_arrived_weight_rail,
       nvl(owp_total_not_arrived_tozin_rail, 0)               as owp_total_not_arrived_tozin_rail,
       nvl(owp_total_not_arrived_weight_road, 0)              as owp_total_not_arrived_weight_road,
       nvl(owp_total_not_arrived_tozin_road, 0)               as owp_total_not_arrived_tozin_road,
       nvl(owp_month_arrived_tozin_rail, 0)                   as owp_month_arrived_tozin_rail,
       nvl(owp_month_not_arrived_tozin_rail, 0)               as owp_month_not_arrived_tozin_rail,
       nvl(owp_month_arrived_weight_rail, 0)                  as owp_month_arrived_weight_rail,
       nvl(owp_month_not_arrived_weight_rail, 0)              as owp_month_not_arrived_weight_rail,
       nvl(owp_month_arrived_tozin_road, 0)                   as owp_month_arrived_tozin_road,
       nvl(owp_month_not_arrived_tozin_road, 0)               as owp_month_not_arrived_tozin_road,
       nvl(owp_month_arrived_weight_road, 0)                  as owp_month_arrived_weight_road,
       nvl(owp_month_not_arrived_weight_road, 0)              as owp_month_not_arrived_weight_road,
       nvl(owp_year_arrived_tozin_rail, 0)                    as owp_year_arrived_tozin_rail,
       nvl(owp_year_not_arrived_tozin_rail, 0)                as owp_year_not_arrived_tozin_rail,
       nvl(owp_year_arrived_weight_rail, 0)                   as owp_year_arrived_weight_rail,
       nvl(owp_year_not_arrived_weight_rail, 0)               as owp_year_not_arrived_weight_rail,
       nvl(owp_year_arrived_tozin_road, 0)                    as owp_year_arrived_tozin_road,
       nvl(owp_year_not_arrived_tozin_road, 0)                as owp_year_not_arrived_tozin_road,
       nvl(owp_year_arrived_weight_road, 0)                   as owp_year_arrived_weight_road,
       nvl(owp_year_not_arrived_weight_road, 0)               as owp_year_not_arrived_weight_road,
       nvl(owp_day_arrived_tozin_rail_all_material, 0)        as owp_day_arrived_tozin_rail_all_material,
       nvl(owp_day_not_arrived_tozin_rail_all_material, 0)    as owp_day_not_arrived_tozin_rail_all_material,
       nvl(owp_day_arrived_weight_rail_all_material, 0)       as owp_day_arrived_weight_rail_all_material,
       nvl(owp_day_not_arrived_weight_rail_all_material, 0)   as owp_day_not_arrived_weight_rail_all_material,
       nvl(owp_total_not_arrived_weight_rail_all_material, 0) as owp_total_not_arrived_weight_rail_all_material,
       nvl(owp_total_not_arrived_tozin_rail_all_material, 0)  as owp_total_not_arrived_tozin_rail_all_material,
       nvl(owp_month_arrived_tozin_rail_all_material, 0)      as owp_month_arrived_tozin_rail_all_material,
       nvl(owp_month_not_arrived_tozin_rail_all_material, 0)  as owp_month_not_arrived_tozin_rail_all_material,
       nvl(owp_month_arrived_weight_rail_all_material, 0)     as owp_month_arrived_weight_rail_all_material,
       nvl(owp_month_not_arrived_weight_rail_all_material, 0) as owp_month_not_arrived_weight_rail_all_material,
       nvl(owp_year_arrived_tozin_rail_all_material, 0)       as owp_year_arrived_tozin_rail_all_material,
       nvl(owp_year_not_arrived_tozin_rail_all_material, 0)   as owp_year_not_arrived_tozin_rail_all_material,
       nvl(owp_year_arrived_weight_rail_all_material, 0)      as owp_year_arrived_weight_rail_all_material,
       nvl(owp_year_not_arrived_weight_rail_all_material, 0)  as owp_year_not_arrived_weight_rail_all_material,
       nvl(owp_day_arrived_tozin_road_all_material, 0)        as owp_day_arrived_tozin_road_all_material,
       nvl(owp_day_not_arrived_tozin_road_all_material, 0)    as owp_day_not_arrived_tozin_road_all_material,
       nvl(owp_day_arrived_weight_road_all_material, 0)       as owp_day_arrived_weight_road_all_material,
       nvl(owp_day_not_arrived_weight_road_all_material, 0)   as owp_day_not_arrived_weight_road_all_material,
       nvl(owp_total_not_arrived_weight_road_all_material, 0) as owp_total_not_arrived_weight_road_all_material,
       nvl(owp_total_not_arrived_tozin_road_all_material, 0)  as owp_total_not_arrived_tozin_road_all_material,
       nvl(owp_month_arrived_tozin_road_all_material, 0)      as owp_month_arrived_tozin_road_all_material,
       nvl(owp_month_not_arrived_tozin_road_all_material, 0)  as owp_month_not_arrived_tozin_road_all_material,
       nvl(owp_month_arrived_weight_road_all_material, 0)     as owp_month_arrived_weight_road_all_material,
       nvl(owp_month_not_arrived_weight_road_all_material, 0) as owp_month_not_arrived_weight_road_all_material,
       nvl(owp_year_arrived_tozin_road_all_material, 0)       as owp_year_arrived_tozin_road_all_material,
       nvl(owp_year_not_arrived_tozin_road_all_material, 0)   as owp_year_not_arrived_tozin_road_all_material,
       nvl(owp_year_arrived_weight_road_all_material, 0)      as owp_year_arrived_weight_road_all_material,
       nvl(owp_year_not_arrived_weight_road_all_material, 0)  as owp_year_not_arrived_weight_road_all_material,
       nvl(owp_day_arrived_tozin_all_material, 0)             as owp_day_arrived_tozin_all_material,
       nvl(owp_day_not_arrived_tozin_all_material, 0)         as owp_day_not_arrived_tozin_all_material,
       nvl(owp_day_arrived_weight_all_material, 0)            as owp_day_arrived_weight_all_material,
       nvl(owp_day_not_arrived_weight_all_material, 0)        as owp_day_not_arrived_weight_all_material,
       nvl(owp_total_not_arrived_weight_all_material, 0)      as owp_total_not_arrived_weight_all_material,
       nvl(owp_total_not_arrived_tozin_all_material, 0)       as owp_total_not_arrived_tozin_all_material,
       nvl(owp_month_arrived_tozin_all_material, 0)           as owp_month_arrived_tozin_all_material,
       nvl(owp_month_not_arrived_tozin_all_material, 0)       as owp_month_not_arrived_tozin_all_material,
       nvl(owp_month_arrived_weight_all_material, 0)          as owp_month_arrived_weight_all_material,
       nvl(owp_month_not_arrived_weight_all_material, 0)      as owp_month_not_arrived_weight_all_material,
       nvl(owp_year_arrived_tozin_all_material, 0)            as owp_year_arrived_tozin_all_material,
       nvl(owp_year_not_arrived_tozin_all_material, 0)        as owp_year_not_arrived_tozin_all_material,
       nvl(owp_year_arrived_weight_all_material, 0)           as owp_year_arrived_weight_all_material,
       nvl(owp_year_not_arrived_weight_all_material, 0)       as owp_year_not_arrived_weight_all_material,
       nvl(owp_total_not_arrived_weight, 0)                   as owp_total_not_arrived_weight,
       nvl(owp_total_not_arrived_tozin, 0)                    as owp_total_not_arrived_tozin,
       nvl(IN_PKG_DAY, 0)                                     as IN_PKG_DAY,
       nvl(IN_PKG_MONTH, 0)                                   as IN_PKG_MONTH,
       nvl(IN_PKG_YEAR, 0)                                    as IN_PKG_YEAR,
       nvl(IN_AMOUNT_DAY, 0)                                  as IN_AMOUNT_DAY,
       nvl(IN_AMOUNT_MONTH, 0)                                as IN_AMOUNT_MONTH,
       nvl(IN_AMOUNT_YEAR, 0)                                 as IN_AMOUNT_YEAR,
       nvl(OUT_PKG_DAY, 0)                                    as OUT_PKG_DAY,
       nvl(OUT_PKG_MONTH, 0)                                  as OUT_PKG_MONTH,
       nvl(OUT_PKG_YEAR, 0)                                   as OUT_PKG_YEAR,
       nvl(OUT_AMOUNT_DAY, 0)                                 as OUT_AMOUNT_DAY,
       nvl(OUT_AMOUNT_MONTH, 0)                               as OUT_AMOUNT_MONTH,
       nvl(OUT_AMOUNT_YEAR, 0)                                as OUT_AMOUNT_YEAR,
       nvl(IN_WEIGHT_DAY, 0)                                  as INCOME_WEIGHT_DAY,
       nvl(IN_WEIGHT_MONTH, 0)                                as INCOME_WEIGHT_MONTH,
       nvl(IN_WEIGHT_YEAR, 0)                                 as INCOME_WEIGHT_YEAR,
       nvl(OUT_WEIGHT_DAY, 0)                                 as OUT_WEIGHT_DAY,
       nvl(OUT_WEIGHT_MONTH, 0)                               as OUT_WEIGHT_MONTH,
       nvl(OUT_WEIGHT_YEAR, 0)                                as OUT_WEIGHT_YEAR,
       nvl(REMAINED_AMOUNT, 0)                                as REMAINED_AMOUNT,
       nvl(REMAINED_WEIGHT, 0)                                as REMAINED_WEIGHT,
       nvl(REMAINED_PKG, 0)                                   as REMAINED_PKG,
       nvl(TADIL, 0)                                          as TADIL,
       nvl(TADIL_MONTH, 0)                                    as TADIL_MONTH,
       nvl(TADIL_YEAR, 0)                                     as TADIL_YEAR,
       ''                                                        materialp,
       ''                                                        materialpname,
       nvl(tadil_year_percent, 0)                             as tadil_year_percent,
       nvl(sum_IN_PKG_DAY, 0)                                 as sum_IN_PKG_DAY,
       nvl(sum_IN_PKG_MONTH, 0)                               as sum_IN_PKG_MONTH,
       nvl(sum_IN_PKG_YEAR, 0)                                as sum_IN_PKG_YEAR,
       nvl(sum_IN_AMOUNT_DAY, 0)                              as sum_IN_AMOUNT_DAY,
       nvl(sum_IN_AMOUNT_MONTH, 0)                            as sum_IN_AMOUNT_MONTH,
       nvl(sum_IN_AMOUNT_YEAR, 0)                             as sum_IN_AMOUNT_YEAR,
       nvl(sum_OUT_PKG_DAY, 0)                                as sum_OUT_PKG_DAY,
       nvl(sum_OUT_PKG_MONTH, 0)                              as sum_OUT_PKG_MONTH,
       nvl(sum_OUT_PKG_YEAR, 0)                               as sum_OUT_PKG_YEAR,
       nvl(sum_OUT_AMOUNT_DAY, 0)                             as sum_OUT_AMOUNT_DAY,
       nvl(sum_OUT_AMOUNT_MONTH, 0)                           as sum_OUT_AMOUNT_MONTH,
       nvl(sum_OUT_AMOUNT_YEAR, 0)                            as sum_OUT_AMOUNT_YEAR,
       nvl(sum_REMAINED_PKG, 0)                               as sum_REMAINED_PKG,
       nvl(sum_REMAINED_AMOUNT, 0)                            as sum_REMAINED_AMOUNT,
       nvl(sum_IN_WEIGHT_DAY, 0)                              as sum_INCOME_WEIGHT_DAY,
       nvl(sum_IN_WEIGHT_MONTH, 0)                            as sum_INCOME_WEIGHT_MONTH,
       nvl(sum_IN_WEIGHT_YEAR, 0)                             as sum_INCOME_WEIGHT_YEAR,
       nvl(sum_OUT_WEIGHT_DAY, 0)                             as sum_OUT_WEIGHT_DAY,
       nvl(sum_OUT_WEIGHT_MONTH, 0)                           as sum_OUT_WEIGHT_MONTH,
       nvl(sum_OUT_WEIGHT_YEAR, 0)                            as sum_OUT_WEIGHT_YEAR,
       nvl(sum_REMAINED_WEIGHT, 0)                            as sum_REMAINED_WEIGHT,
       nvl(sum_tadil, 0)                                      as sum_tadil,
       nvl(sum_TADIL_MONTH, 0)                                as sum_TADIL_MONTH,
       nvl(sum_TADIL_YEAR, 0)                                 as sum_TADIL_YEAR,
       nvl(sum_tadil_year_percent, 0)                         as sum_tadil_year_percent
from VIEW_DAT_SOURCE_MATERIAL rows_
         left join RPRT_V_MATERIAL_SHIPMENT_STATS ow
                   on (rows_.dat = ow.day_key and rows_.SOURCE = ow.sourceid and rows_.MATERIAL = ow.material)
         left join RPRT_MV_MATERIAL_IO_SUMMARY mio
                   on (rows_.dat = mio.dat and rows_.SOURCE = mio.source and rows_.MATERIAL = mio.material);