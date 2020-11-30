package com.nicico.sales.model.entities.base;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;

import javax.persistence.*;
import java.io.Serializable;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect("select * from view_daily_report2555")
@IdClass(DailyReportBandarAbas.DailyReportBandAbasId.class)
public class DailyReportBandarAbas {
    @Id
    @Column(name = "dat")
    private String date;
    @Id
    @Column(name = "source")
    private Long source;
    @Id
    @Column(name = "material")
    private Long material;
    @Column(name = "materialp")
    private Long materialp;
    @Column(name = "source_name")
    private String sourceName;
    @Column(name = "material_name")
    private String materialName;
    @Column(name = "unit")
    private String unit;
    @Column(name = "tadil_year_percent")
    private Double tadilYearPrecent;
    @Column(name = "materialpname")
    private String materialPName;
    @Column(name = "IN_PKG_DAY")
    private Long inPkgDay;
    @Column(name = "IN_PKG_MONTH")
    private Long inPkgMonth;
    @Column(name = "IN_PKG_YEAR")
    private Long inPkgYear;
    @Column(name = "IN_AMOUNT_DAY")
    private Long inAmountDay;
    @Column(name = "IN_AMOUNT_MONTH")
    private Long inAmountMonth;
    @Column(name = "IN_AMOUNT_YEAR")
    private Long inAmountYear;
    @Column(name = "OUT_PKG_DAY")
    private Long outPkgDay;
    @Column(name = "OUT_PKG_MONTH")
    private Long outPkgMonth;
    @Column(name = "OUT_PKG_YEAR")
    private Long outPkgYear;
    @Column(name = "OUT_AMOUNT_DAY")
    private Long outAmountDay;
    @Column(name = "OUT_AMOUNT_MONTH")
    private Long outAmountMonth;
    @Column(name = "OUT_AMOUNT_YEAR")
    private Long outAmountYear;
    @Column(name = "REMAINED_PKG")
    private Long remainedPkg;
    @Column(name = "REMAINED_AMOUNT")
    private Long remainedAmount;
    @Column(name = "INCOME_WEIGHT_DAY")
    private Long incomeWeightDay;
    @Column(name = "INCOME_WEIGHT_MONTH")
    private Long incomeWeightMonth;
    @Column(name = "INCOME_WEIGHT_YEAR")
    private Long incomeWeightYear;
    @Column(name = "OUT_WEIGHT_DAY")
    private Long outWeightDay;
    @Column(name = "OUT_WEIGHT_MONTH")
    private Long outWeightMonth;
    @Column(name = "OUT_WEIGHT_YEAR")
    private Long outWeightYear;
    @Column(name = "REMAINED_WEIGHT")
    private Long remainedWeight;
    @Column(name = "tadil")
    private Long tadil;
    @Column(name = "TADIL_YEAR")
    private Long tadilYear;
    @Column(name = "TADIL_MONTH")
    private Long tadilMonth;
    @Column(name = "sum_tadil_year_percent")
    private Double sumTadilYearPrecent;
    @Column(name = "sum_IN_PKG_DAY")
    private Long sumInPkgDay;
    @Column(name = "sum_IN_PKG_MONTH")
    private Long sumInPkgMonth;
    @Column(name = "sum_IN_PKG_YEAR")
    private Long sumInPkgYear;
    @Column(name = "sum_IN_AMOUNT_DAY")
    private Long sumInAmountDay;
    @Column(name = "sum_IN_AMOUNT_MONTH")
    private Long sumInAmountMonth;
    @Column(name = "sum_IN_AMOUNT_YEAR")
    private Long sumInAmountYear;
    @Column(name = "sum_OUT_PKG_DAY")
    private Long sumOutPkgDay;
    @Column(name = "sum_OUT_PKG_MONTH")
    private Long sumOutPkgMonth;
    @Column(name = "sum_OUT_PKG_YEAR")
    private Long sumOutPkgYear;
    @Column(name = "sum_OUT_AMOUNT_DAY")
    private Long sumOutAmountDay;
    @Column(name = "sum_OUT_AMOUNT_MONTH")
    private Long sumOutAmountMonth;
    @Column(name = "sum_OUT_AMOUNT_YEAR")
    private Long sumOutAmountYear;
    @Column(name = "sum_REMAINED_PKG")
    private Long sumRemainedPkg;
    @Column(name = "sum_REMAINED_AMOUNT")
    private Long sumRemainedAmount;
    @Column(name = "sum_INCOME_WEIGHT_DAY")
    private Long sumIncomeWeightDay;
    @Column(name = "sum_INCOME_WEIGHT_MONTH")
    private Long sumIncomeWeightMonth;
    @Column(name = "sum_INCOME_WEIGHT_YEAR")
    private Long sumIncomeWeightYear;
    @Column(name = "sum_OUT_WEIGHT_DAY")
    private Long sumOutWeightDay;
    @Column(name = "sum_OUT_WEIGHT_MONTH")
    private Long sumOutWeightMonth;
    @Column(name = "sum_OUT_WEIGHT_YEAR")
    private Long sumOutWeightYear;
    @Column(name = "sum_REMAINED_WEIGHT")
    private Long sumRemainedWeight;
    @Column(name = "sum_tadil")
    private Long sumTadil;
    @Column(name = "sum_TADIL_YEAR")
    private Long sumTadilYear;
    @Column(name = "sum_TADIL_MONTH")
    private Long sumTadilMonth;
    @Column(name = "owp_day_arrived_tozin_rail")
    private long owpDayArrivedTozinRail;
    @Column(name = "owp_day_not_arrived_tozin_rail")
    private long owpDayNotArrivedTozinRail;
    @Column(name = "owp_day_arrived_weight_rail")
    private long owpDayArrivedWeightRail;
    @Column(name = "owp_day_not_arrived_weight_rail")
    private long owpDayNotArrivedWeightRail;
    @Column(name = "owp_day_arrived_tozin_road")
    private long owpDayArrivedTozinRoad;
    @Column(name = "owp_day_not_arrived_tozin_road")
    private long owpDayNotArrivedTozinRoad;
    @Column(name = "owp_day_arrived_weight_road")
    private long owpDayArrivedWeightRoad;
    @Column(name = "owp_day_not_arrived_weight_road")
    private long owpDayNotArrivedWeightRoad;
    @Column(name = "owp_total_not_arrived_weight_rail")
    private long owpTotalNotArrivedWeightRail;
    @Column(name = "owp_total_not_arrived_tozin_rail")
    private long owpTotalNotArrivedTozinRail;
    @Column(name = "owp_total_not_arrived_weight_road")
    private long owpTotalNotArrivedWeightRoad;
    @Column(name = "owp_total_not_arrived_tozin_road")
    private long owpTotalNotArrivedTozinRoad;
    @Column(name = "owp_month_arrived_tozin_rail")
    private long owpMonthArrivedTozinRail;
    @Column(name = "owp_month_not_arrived_tozin_rail")
    private long owpMonthNotArrivedTozinRail;
    @Column(name = "owp_month_arrived_weight_rail")
    private long owpMonthArrivedWeightRail;
    @Column(name = "owp_month_not_arrived_weight_rail")
    private long owpMonthNotArrivedWeightRail;
    @Column(name = "owp_month_arrived_tozin_road")
    private long owpMonthArrivedTozinRoad;
    @Column(name = "owp_month_not_arrived_tozin_road")
    private long owpMonthNotArrivedTozinRoad;
    @Column(name = "owp_month_arrived_weight_road")
    private long owpMonthArrivedWeightRoad;
    @Column(name = "owp_month_not_arrived_weight_road")
    private long owpMonthNotArrivedWeightRoad;
    @Column(name = "owp_year_arrived_tozin_rail")
    private long owpYearArrivedTozinRail;
    @Column(name = "owp_year_not_arrived_tozin_rail")
    private long owpYearNotArrivedTozinRail;
    @Column(name = "owp_year_arrived_weight_rail")
    private long owpYearArrivedWeightRail;
    @Column(name = "owp_year_not_arrived_weight_rail")
    private long owpYearNotArrivedWeightRail;
    @Column(name = "owp_year_arrived_tozin_road")
    private long owpYearArrivedTozinRoad;
    @Column(name = "owp_year_not_arrived_tozin_road")
    private long owpYearNotArrivedTozinRoad;
    @Column(name = "owp_year_arrived_weight_road")
    private long owpYearArrivedWeightRoad;
    @Column(name = "owp_year_not_arrived_weight_road")
    private long owpYearNotArrivedWeightRoad;
    @Column(name = "owp_day_arrived_tozin_rail_all_material")
    private long owpDayArrivedTozinRailAllMaterial;
    @Column(name = "owp_day_not_arrived_tozin_rail_all_material")
    private long owpDayNotArrivedTozinRailAllMaterial;
    @Column(name = "owp_day_arrived_weight_rail_all_material")
    private long owpDayArrivedWeightRailAllMaterial;
    @Column(name = "owp_day_not_arrived_weight_rail_all_material")
    private long owpDayNotArrivedWeightRailAllMaterial;
    @Column(name = "owp_total_not_arrived_weight_rail_all_material")
    private long owpTotalNotArrivedWeightRailAllMaterial;
    @Column(name = "owp_total_not_arrived_tozin_rail_all_material")
    private long owpTotalNotArrivedTozinRailAllMaterial;
    @Column(name = "owp_month_arrived_tozin_rail_all_material")
    private long owpMonthArrivedTozinRailAllMaterial;
    @Column(name = "owp_month_not_arrived_tozin_rail_all_material")
    private long owpMonthNotArrivedTozinRailAllMaterial;
    @Column(name = "owp_month_arrived_weight_rail_all_material")
    private long owpMonthArrivedWeightRailAllMaterial;
    @Column(name = "owp_month_not_arrived_weight_rail_all_material")
    private long owpMonthNotArrivedWeightRailAllMaterial;
    @Column(name = "owp_year_arrived_tozin_rail_all_material")
    private long owpYearArrivedTozinRailAllMaterial;
    @Column(name = "owp_year_not_arrived_tozin_rail_all_material")
    private long owpYearNotArrivedTozinRailAllMaterial;
    @Column(name = "owp_year_arrived_weight_rail_all_material")
    private long owpYearArrivedWeightRailAllMaterial;
    @Column(name = "owp_year_not_arrived_weight_rail_all_material")
    private long owpYearNotArrivedWeightRailAllMaterial;
    @Column(name = "owp_day_arrived_tozin_road_all_material")
    private long owpDayArrivedTozinRoadAllMaterial;
    @Column(name = "owp_day_not_arrived_tozin_road_all_material")
    private long owpDayNotArrivedTozinRoadAllMaterial;
    @Column(name = "owp_day_arrived_weight_road_all_material")
    private long owpDayArrivedWeightRoadAllMaterial;
    @Column(name = "owp_day_not_arrived_weight_road_all_material")
    private long owpDayNotArrivedWeightRoadAllMaterial;
    @Column(name = "owp_total_not_arrived_weight_road_all_material")
    private long owpTotalNotArrivedWeightRoadAllMaterial;
    @Column(name = "owp_total_not_arrived_tozin_road_all_material")
    private long owpTotalNotArrivedTozinRoadAllMaterial;
    @Column(name = "owp_month_arrived_tozin_road_all_material")
    private long owpMonthArrivedTozinRoadAllMaterial;
    @Column(name = "owp_month_not_arrived_tozin_road_all_material")
    private long owpMonthNotArrivedTozinRoadAllMaterial;
    @Column(name = "owp_month_arrived_weight_road_all_material")
    private long owpMonthArrivedWeightRoadAllMaterial;
    @Column(name = "owp_month_not_arrived_weight_road_all_material")
    private long owpMonthNotArrivedWeightRoadAllMaterial;
    @Column(name = "owp_year_arrived_tozin_road_all_material")
    private long owpYearArrivedTozinRoadAllMaterial;
    @Column(name = "owp_year_not_arrived_tozin_road_all_material")
    private long owpYearNotArrivedTozinRoadAllMaterial;
    @Column(name = "owp_year_arrived_weight_road_all_material")
    private long owpYearArrivedWeightRoadAllMaterial;
    @Column(name = "owp_year_not_arrived_weight_road_all_material")
    private long owpYearNotArrivedWeightRoadAllMaterial;
    @Column(name = "owp_day_arrived_tozin_all_material")
    private long owpDayArrivedTozinAllMaterial;
    @Column(name = "owp_day_not_arrived_tozin_all_material")
    private long owpDayNotArrivedTozinAllMaterial;
    @Column(name = "owp_day_arrived_weight_all_material")
    private long owpDayArrivedWeightAllMaterial;
    @Column(name = "owp_day_not_arrived_weight_all_material")
    private long owpDayNotArrivedWeightAllMaterial;
    @Column(name = "owp_total_not_arrived_weight_all_material")
    private long owpTotalNotArrivedWeightAllMaterial;
    @Column(name = "owp_total_not_arrived_tozin_all_material")
    private long owpTotalNotArrivedTozinAllMaterial;
    @Column(name = "owp_month_arrived_tozin_all_material")
    private long owpMonthArrivedTozinAllMaterial;
    @Column(name = "owp_month_not_arrived_tozin_all_material")
    private long owpMonthNotArrivedTozinAllMaterial;
    @Column(name = "owp_month_arrived_weight_all_material")
    private long owpMonthArrivedWeightAllMaterial;
    @Column(name = "owp_month_not_arrived_weight_all_material")
    private long owpMonthNotArrivedWeightAllMaterial;
    @Column(name = "owp_year_arrived_tozin_all_material")
    private long owpYearArrivedTozinAllMaterial;
    @Column(name = "owp_year_not_arrived_tozin_all_material")
    private long owpYearNotArrivedTozinAllMaterial;
    @Column(name = "owp_year_arrived_weight_all_material")
    private long owpYearArrivedWeightAllMaterial;
    @Column(name = "owp_year_not_arrived_weight_all_material")
    private long owpYearNotArrivedWeightAllMaterial;
    @Column(name = "owp_total_not_arrived_weight")
    private long owpTotalNotArrivedWeight;
    @Column(name = "owp_total_not_arrived_tozin")
    private long owpTotalNotArrivedTozin;

    @EqualsAndHashCode
    public static class DailyReportBandAbasId implements Serializable {
        private String date;

        private Long source;

        private Long material;

    }

    @PostLoad
    public void init() {

        if (sumRemainedWeight == null)
            sumRemainedWeight = 0L;
        if (sumOutWeightDay == null)
            sumOutWeightDay = 0L;
        if (sumIncomeWeightDay == null)
            sumIncomeWeightDay = 0L;
        if (sumOutWeightMonth == null)
            sumOutWeightMonth = 0L;
        if (sumIncomeWeightMonth == null)
            sumIncomeWeightMonth = 0L;
        if (sumOutWeightYear == null)
            sumOutWeightYear = 0L;
        if (sumIncomeWeightYear == null)
            sumIncomeWeightYear = 0L;
        if (remainedWeight == null)
            remainedWeight = 0L;
        if (outWeightDay == null)
            outWeightDay = 0L;
        if (incomeWeightDay == null)
            incomeWeightDay = 0L;
        if (outWeightMonth == null)
            outWeightMonth = 0L;
        if (incomeWeightMonth == null)
            incomeWeightMonth = 0L;
        if (outWeightYear == null)
            outWeightYear = 0L;
        if (incomeWeightYear == null)
            incomeWeightYear = 0L;
        if (sumOutPkgDay == null)
            sumOutPkgDay = 0L;
        if (sumInPkgDay == null)
            sumInPkgDay = 0L;
        if (sumOutPkgMonth == null)
            sumOutPkgMonth = 0L;
        if (sumInPkgMonth == null)
            sumInPkgMonth = 0L;
        if (sumRemainedPkg == null)
            sumRemainedPkg = 0L;
        if (sumOutPkgYear == null)
            sumOutPkgYear = 0L;
        if (sumInPkgYear == null)
            sumInPkgYear = 0L;
        if (remainedPkg == null)
            remainedPkg = 0L;
        if (outPkgDay == null)
            outPkgDay = 0L;
        if (inPkgDay == null)
            inPkgDay = 0L;
        if (outPkgMonth == null)
            outPkgMonth = 0L;
        if (inPkgMonth == null)
            inPkgMonth = 0L;
        if (outPkgYear == null)
            outPkgYear = 0L;
        if (inPkgYear == null)
            inPkgYear = 0L;
    }
}
