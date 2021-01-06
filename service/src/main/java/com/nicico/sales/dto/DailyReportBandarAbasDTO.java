package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.annotation.report.ReportField;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
//@JsonInclude()
public class DailyReportBandarAbasDTO {

    @ReportField(titleMessageKey = "Daily-report.dat")
    private String date;

    @ReportField(titleMessageKey = "Daily-report.source")
    private Long source;

    @ReportField(titleMessageKey = "Daily-report.material")
    private Long material;

    @ReportField(titleMessageKey = "Daily-report.source.name")
    private String sourceName;

    @ReportField(titleMessageKey = "Daily-report.material.name")
    private String materialName;
    @ReportField(titleMessageKey = "Daily-report.materialp")
    private Long materialp;
    @ReportField(titleMessageKey = "Daily-report.materialpname")
    private String materialPName;
    @ReportField(titleMessageKey = "global.unit")
    private String unit;


    @ReportField(titleMessageKey = "sum-Daily-report.IN.PKG.DAY")
    private Long sumInPkgDay;

    @ReportField(titleMessageKey = "sum-Daily-report.IN.PKG.MONTH")
    private Long sumInPkgMonth;

    @ReportField(titleMessageKey = "sum-Daily-report.IN.PKG.YEAR")
    private Long sumInPkgYear;

    @ReportField(titleMessageKey = "sum-Daily-report.IN.AMOUNT.DAY")
    private Long sumInAmountDay;

    @ReportField(titleMessageKey = "sum-Daily-report.IN.AMOUNT.MONTH")
    private Long sumInAmountMonth;

    @ReportField(titleMessageKey = "sum-Daily-report.IN.AMOUNT.YEAR")
    private Long sumInAmountYear;

    @ReportField(titleMessageKey = "sum-Daily-report.OUT.PKG.DAY")
    private Long sumOutPkgDay;

    @ReportField(titleMessageKey = "sum-Daily-report.OUT.PKG.MONTH")
    private Long sumOutPkgMonth;

    @ReportField(titleMessageKey = "sum-Daily-report.OUT.PKG.YEAR")
    private Long sumOutPkgYear;

    @ReportField(titleMessageKey = "sum-Daily-report.OUT.AMOUNT.DAY")
    private Long sumOutAmountDay;

    @ReportField(titleMessageKey = "sum-Daily-report.OUT.AMOUNT.MONTH")
    private Long sumOutAmountMonth;

    @ReportField(titleMessageKey = "sum-Daily-report.OUT.AMOUNT.YEAR")
    private Long sumOutAmountYear;

    @ReportField(titleMessageKey = "sum-Daily-report.REMAINED.PKG")
    private Long sumRemainedPkg;

    @ReportField(titleMessageKey = "sum-Daily-report.REMAINED.AMOUNT")
    private Long sumRemainedAmount;

    @ReportField(titleMessageKey = "sum-Daily-report.INCOME.WEIGHT.DAY")
    private Long sumIncomeWeightDay;

    @ReportField(titleMessageKey = "sum-Daily-report.INCOME.WEIGHT.MONTH")
    private Long sumIncomeWeightMonth;

    @ReportField(titleMessageKey = "sum-Daily-report.INCOME.WEIGHT.YEAR")
    private Long sumIncomeWeightYear;

    @ReportField(titleMessageKey = "sum-Daily-report.OUT.WEIGHT.DAY")
    private Long sumOutWeightDay;

    @ReportField(titleMessageKey = "sum-Daily-report.OUT.WEIGHT.MONTH")
    private Long sumOutWeightMonth;

    @ReportField(titleMessageKey = "sum-Daily-report.OUT.WEIGHT.YEAR")
    private Long sumOutWeightYear;

    @ReportField(titleMessageKey = "sum-Daily-report.REMAINED.WEIGHT")
    private Long sumRemainedWeight;
    @ReportField(titleMessageKey = "sum-Daily-report.OWP.tadil-month")
    private Long sumTadilYear;
    @ReportField(titleMessageKey = "sum-Daily-report.OWP.tadil-year")
    private Long sumTadilMonth;
    @ReportField(titleMessageKey = "sum-Daily-report.OWP.tadil")
    private Long sumTadil;

    @ReportField(titleMessageKey = "sum-Daily-report.OWP.WEIGHT")
    private Long sumOwpWeight;
    @ReportField(titleMessageKey = "sum-Daily-report.OWP.PKG")
    private Long sumOwpPkg;
    @ReportField(titleMessageKey = "sum-Daily-report.OWP.TOZIN")
    private Long sumOwpTozin;
    private Double sumTadilYearPrecent;

    @ReportField(titleMessageKey = "Daily-report.IN.PKG.DAY")
    private Long inPkgDay;

    @ReportField(titleMessageKey = "Daily-report.IN.PKG.MONTH")
    private Long inPkgMonth;

    @ReportField(titleMessageKey = "Daily-report.IN.PKG.YEAR")
    private Long inPkgYear;

    @ReportField(titleMessageKey = "Daily-report.IN.AMOUNT.DAY")
    private Long inAmountDay;

    @ReportField(titleMessageKey = "Daily-report.IN.AMOUNT.MONTH")
    private Long inAmountMonth;

    @ReportField(titleMessageKey = "Daily-report.IN.AMOUNT.YEAR")
    private Long inAmountYear;

    @ReportField(titleMessageKey = "Daily-report.OUT.PKG.DAY")
    private Long outPkgDay;

    @ReportField(titleMessageKey = "Daily-report.OUT.PKG.MONTH")
    private Long outPkgMonth;

    @ReportField(titleMessageKey = "Daily-report.OUT.PKG.YEAR")
    private Long outPkgYear;

    @ReportField(titleMessageKey = "Daily-report.OUT.AMOUNT.DAY")
    private Long outAmountDay;

    @ReportField(titleMessageKey = "Daily-report.OUT.AMOUNT.MONTH")
    private Long outAmountMonth;

    @ReportField(titleMessageKey = "Daily-report.OUT.AMOUNT.YEAR")
    private Long outAmountYear;

    @ReportField(titleMessageKey = "Daily-report.REMAINED.PKG")
    private Long remainedPkg;

    @ReportField(titleMessageKey = "Daily-report.REMAINED.AMOUNT")
    private Long remainedAmount;

    @ReportField(titleMessageKey = "Daily-report.INCOME.WEIGHT.DAY")
    private Long incomeWeightDay;

    @ReportField(titleMessageKey = "Daily-report.INCOME.WEIGHT.MONTH")
    private Long incomeWeightMonth;

    @ReportField(titleMessageKey = "Daily-report.INCOME.WEIGHT.YEAR")
    private Long incomeWeightYear;

    @ReportField(titleMessageKey = "Daily-report.OUT.WEIGHT.DAY")
    private Long outWeightDay;

    @ReportField(titleMessageKey = "Daily-report.OUT.WEIGHT.MONTH")
    private Long outWeightMonth;

    @ReportField(titleMessageKey = "Daily-report.OUT.WEIGHT.YEAR")
    private Long outWeightYear;

    @ReportField(titleMessageKey = "Daily-report.REMAINED.WEIGHT")
    private Long remainedWeight;
    @ReportField(titleMessageKey = "Daily-report.OWP.tadil-month")
    private Long tadilYear;
    @ReportField(titleMessageKey = "Daily-report.OWP.tadil-year")
    private Long tadilMonth;
    @ReportField(titleMessageKey = "Daily-report.OWP.tadil")
    private Long tadil;


    @ReportField(titleMessageKey = "tadil.year.precent") //new
    private Double tadilYearPrecent;

    @ReportField(titleMessageKey = "sum.first.remained.weight.day") //new
    private Long sumFirstRemainedWeightDay;
    @ReportField(titleMessageKey = "sum.first.remained.weight.month") //new
    private Long sumFirstRemainedWeightMonth;
    @ReportField(titleMessageKey = "sum.first.remained.weight.year") //new
    private Long sumFirstRemainedWeightYear;
    @ReportField(titleMessageKey = "first.remained.weight.day") //new
    private Long firstRemainedWeightDay;
    @ReportField(titleMessageKey = "first.remained.weight.month") //new
    private Long firstRemainedWeightMonth;
    @ReportField(titleMessageKey = "first.remained.weight.year") //new
    private Long firstRemainedWeightYear;
    @ReportField(titleMessageKey = "Daily-report.owp.day.arrived.tozin.rail")
    private long owpDayArrivedTozinRail;
    @ReportField(titleMessageKey = "Daily-report.owp.day.not.arrived.tozin.rail")
    private long owpDayNotArrivedTozinRail;
    @ReportField(titleMessageKey = "Daily-report.owp.day.arrived.weight.rail")
    private long owpDayArrivedWeightRail;
    @ReportField(titleMessageKey = "Daily-report.owp.day.not.arrived.weight.rail")
    private long owpDayNotArrivedWeightRail;
    @ReportField(titleMessageKey = "Daily-report.owp.day.arrived.tozin.road")
    private long owpDayArrivedTozinRoad;
    @ReportField(titleMessageKey = "Daily-report.owp.day.not.arrived.tozin.road")
    private long owpDayNotArrivedTozinRoad;
    @ReportField(titleMessageKey = "Daily-report.owp.day.arrived.weight.road")
    private long owpDayArrivedWeightRoad;
    @ReportField(titleMessageKey = "Daily-report.owp.day.not.arrived.weight.road")
    private long owpDayNotArrivedWeightRoad;
    @ReportField(titleMessageKey = "Daily-report.owp.total.not.arrived.weight.rail")
    private long owpTotalNotArrivedWeightRail;
    @ReportField(titleMessageKey = "Daily-report.owp.total.not.arrived.tozin.rail")
    private long owpTotalNotArrivedTozinRail;
    @ReportField(titleMessageKey = "Daily-report.owp.total.not.arrived.weight.road")
    private long owpTotalNotArrivedWeightRoad;
    @ReportField(titleMessageKey = "Daily-report.owp.total.not.arrived.tozin.road")
    private long owpTotalNotArrivedTozinRoad;
    @ReportField(titleMessageKey = "Daily-report.owp.month.arrived.tozin.rail")
    private long owpMonthArrivedTozinRail;
    @ReportField(titleMessageKey = "Daily-report.owp.month.not.arrived.tozin.rail")
    private long owpMonthNotArrivedTozinRail;
    @ReportField(titleMessageKey = "Daily-report.owp.month.arrived.weight.rail")
    private long owpMonthArrivedWeightRail;
    @ReportField(titleMessageKey = "Daily-report.owp.month.not.arrived.weight.rail")
    private long owpMonthNotArrivedWeightRail;
    @ReportField(titleMessageKey = "Daily-report.owp.month.arrived.tozin.road")
    private long owpMonthArrivedTozinRoad;
    @ReportField(titleMessageKey = "Daily-report.owp.month.not.arrived.tozin.road")
    private long owpMonthNotArrivedTozinRoad;
    @ReportField(titleMessageKey = "Daily-report.owp.month.arrived.weight.road")
    private long owpMonthArrivedWeightRoad;
    @ReportField(titleMessageKey = "Daily-report.owp.month.not.arrived.weight.road")
    private long owpMonthNotArrivedWeightRoad;
    @ReportField(titleMessageKey = "Daily-report.owp.year.arrived.tozin.rail")
    private long owpYearArrivedTozinRail;
    @ReportField(titleMessageKey = "Daily-report.owp.year.not.arrived.tozin.rail")
    private long owpYearNotArrivedTozinRail;
    @ReportField(titleMessageKey = "Daily-report.owp.year.arrived.weight.rail")
    private long owpYearArrivedWeightRail;
    @ReportField(titleMessageKey = "Daily-report.owp.year.not.arrived.weight.rail")
    private long owpYearNotArrivedWeightRail;
    @ReportField(titleMessageKey = "Daily-report.owp.year.arrived.tozin.road")
    private long owpYearArrivedTozinRoad;
    @ReportField(titleMessageKey = "Daily-report.owp.year.not.arrived.tozin.road")
    private long owpYearNotArrivedTozinRoad;
    @ReportField(titleMessageKey = "Daily-report.owp.year.arrived.weight.road")
    private long owpYearArrivedWeightRoad;
    @ReportField(titleMessageKey = "Daily-report.owp.year.not.arrived.weight.road")
    private long owpYearNotArrivedWeightRoad;
    @ReportField(titleMessageKey = "Daily-report.owp.day.arrived.tozin.rail.all.material")
    private long owpDayArrivedTozinRailAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.day.not.arrived.tozin.rail.all.material")
    private long owpDayNotArrivedTozinRailAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.day.arrived.weight.rail.all.material")
    private long owpDayArrivedWeightRailAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.day.not.arrived.weight.rail.all.material")
    private long owpDayNotArrivedWeightRailAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.total.not.arrived.weight.rail.all.material")
    private long owpTotalNotArrivedWeightRailAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.total.not.arrived.tozin.rail.all.material")
    private long owpTotalNotArrivedTozinRailAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.month.arrived.tozin.rail.all.material")
    private long owpMonthArrivedTozinRailAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.month.not.arrived.tozin.rail.all.material")
    private long owpMonthNotArrivedTozinRailAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.month.arrived.weight.rail.all.material")
    private long owpMonthArrivedWeightRailAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.month.not.arrived.weight.rail.all.material")
    private long owpMonthNotArrivedWeightRailAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.year.arrived.tozin.rail.all.material")
    private long owpYearArrivedTozinRailAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.year.not.arrived.tozin.rail.all.material")
    private long owpYearNotArrivedTozinRailAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.year.arrived.weight.rail.all.material")
    private long owpYearArrivedWeightRailAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.year.not.arrived.weight.rail.all.material")
    private long owpYearNotArrivedWeightRailAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.day.arrived.tozin.road.all.material")
    private long owpDayArrivedTozinRoadAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.day.not.arrived.tozin.road.all.material")
    private long owpDayNotArrivedTozinRoadAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.day.arrived.weight.road.all.material")
    private long owpDayArrivedWeightRoadAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.day.not.arrived.weight.road.all.material")
    private long owpDayNotArrivedWeightRoadAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.total.not.arrived.weight.road.all.material")
    private long owpTotalNotArrivedWeightRoadAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.total.not.arrived.tozin.road.all.material")
    private long owpTotalNotArrivedTozinRoadAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.month.arrived.tozin.road.all.material")
    private long owpMonthArrivedTozinRoadAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.month.not.arrived.tozin.road.all.material")
    private long owpMonthNotArrivedTozinRoadAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.month.arrived.weight.road.all.material")
    private long owpMonthArrivedWeightRoadAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.month.not.arrived.weight.road.all.material")
    private long owpMonthNotArrivedWeightRoadAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.year.arrived.tozin.road.all.material")
    private long owpYearArrivedTozinRoadAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.year.not.arrived.tozin.road.all.material")
    private long owpYearNotArrivedTozinRoadAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.year.arrived.weight.road.all.material")
    private long owpYearArrivedWeightRoadAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.year.not.arrived.weight.road.all.material")
    private long owpYearNotArrivedWeightRoadAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.day.arrived.tozin.all.material")
    private long owpDayArrivedTozinAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.day.not.arrived.tozin.all.material")
    private long owpDayNotArrivedTozinAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.day.arrived.weight.all.material")
    private long owpDayArrivedWeightAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.day.not.arrived.weight.all.material")
    private long owpDayNotArrivedWeightAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.total.not.arrived.weight.all.material")
    private long owpTotalNotArrivedWeightAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.total.not.arrived.tozin.all.material")
    private long owpTotalNotArrivedTozinAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.month.arrived.tozin.all.material")
    private long owpMonthArrivedTozinAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.month.not.arrived.tozin.all.material")
    private long owpMonthNotArrivedTozinAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.month.arrived.weight.all.material")
    private long owpMonthArrivedWeightAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.month.not.arrived.weight.all.material")
    private long owpMonthNotArrivedWeightAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.year.arrived.tozin.all.material")
    private long owpYearArrivedTozinAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.year.not.arrived.tozin.all.material")
    private long owpYearNotArrivedTozinAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.year.arrived.weight.all.material")
    private long owpYearArrivedWeightAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.year.not.arrived.weight.all.material")
    private long owpYearNotArrivedWeightAllMaterial;
    @ReportField(titleMessageKey = "Daily-report.owp.total.not.arrived.weight")
    private long owpTotalNotArrivedWeight;
    @ReportField(titleMessageKey = "owp.total.not.arrived.tozin") //new
    private long owpTotalNotArrivedTozin;
    @ReportField(titleMessageKey = "sum.first.remained.pkg.day") //new
    private Long sumFirstRemainedPkgDay;
    @ReportField(titleMessageKey = "sum.first.remained.pkg.month") //new
    private Long sumFirstRemainedPkgMonth;
    @ReportField(titleMessageKey = "sum.first.remained.pkg.year") //new
    private Long sumFirstRemainedPkgYear;
    @ReportField(titleMessageKey = "first.remained.pkg.day") //new
    private Long firstRemainedPkgDay;
    @ReportField(titleMessageKey = "first.remained.pkg.month") //new
    private Long firstRemainedPkgMonth;
    @ReportField(titleMessageKey = "first.remained.pkg.year") //new
    private Long firstRemainedPkgYear;

    public Long getSumFirstRemainedWeightDay() {
        return sumRemainedWeight + sumOutWeightDay - sumIncomeWeightDay;
    }

    public Long getSumFirstRemainedWeightMonth() {
        return sumRemainedWeight + sumOutWeightMonth - sumIncomeWeightMonth;
    }

    public Long getSumFirstRemainedWeightYear() {
        return sumRemainedWeight + sumOutWeightYear - sumIncomeWeightYear;
    }

    public Long getFirstRemainedWeightDay() {
        return remainedWeight + outWeightDay - incomeWeightDay;
    }

    public Long getFirstRemainedWeightMonth() {
        return remainedWeight + outWeightMonth - incomeWeightMonth;
    }

    public Long getFirstRemainedWeightYear() {
        return remainedWeight + outWeightYear - incomeWeightYear;
    }

    public Long getSumFirstRemainedPkgDay() {
        return sumRemainedPkg + sumOutPkgDay - sumInPkgDay;
    }

    public Long getSumFirstRemainedPkgMonth() {
        return sumRemainedPkg + sumOutPkgMonth - sumInPkgMonth;
    }

    public Long getSumFirstRemainedPkgYear() {
        return sumRemainedPkg + sumOutPkgYear - sumInPkgYear;
    }

    public Long getFirstRemainedPkgDay() {
        return remainedPkg + outPkgDay - inPkgDay;
    }

    public Long getFirstRemainedPkgMonth() {
        return remainedPkg + outPkgMonth - inPkgMonth;
    }

    public Long getFirstRemainedPkgYear() {
        return remainedPkg + outPkgYear - inPkgYear;
    }





    @ReportField(titleMessageKey = "owp.day.sent.tozin.rail") //new
    private long owpDaySentTozinRail;
    @ReportField(titleMessageKey = "owp.day.sent.weight.rail") //new
    private long owpDaySentWeightRail;
    @ReportField(titleMessageKey = "owp.day.sent.tozin.road") //new
    private long owpDaySentTozinRoad;
    @ReportField(titleMessageKey = "owp.day.sent.weight.road") //new
    private long owpDaySentWeightRoad;
    @ReportField(titleMessageKey = "owp.month.sent.tozin.rail") //new
    private long owpMonthSentTozinRail;
    @ReportField(titleMessageKey = "owp.month.sent.weight.rail") //new
    private long owpMonthSentWeightRail;
    @ReportField(titleMessageKey = "owp.month.sent.tozin.road") //new
    private long owpMonthSentTozinRoad;
    @ReportField(titleMessageKey = "owp.month.sent.weight.road") //new
    private long owpMonthSentWeightRoad;
    @ReportField(titleMessageKey = "owp.year.sent.tozin.rail") //new
    private long owpYearSentTozinRail;
    @ReportField(titleMessageKey = "owp.year.sent.weight.rail") //new
    private long owpYearSentWeightRail;
    @ReportField(titleMessageKey = "owp.year.sent.tozin.road") //new
    private long owpYearSentTozinRoad;
    @ReportField(titleMessageKey = "owp.year.sent.weight.road") //new
    private long owpYearSentWeightRoad;
    @ReportField(titleMessageKey = "owp.day.sent.tozin.rail.all.material") //new
    private long owpDaySentTozinRailAllMaterial;
    @ReportField(titleMessageKey = "owp.day.sent.weight.rail.all.material") //new
    private long owpDaySentWeightRailAllMaterial;
    @ReportField(titleMessageKey = "owp.total.sent.weight.rail.all.material") //new
    private long owpTotalSentWeightRailAllMaterial;
    @ReportField(titleMessageKey = "owp.total.sent.tozin.rail.all.material") //new
    private long owpTotalSentTozinRailAllMaterial;
    @ReportField(titleMessageKey = "owp.month.sent.tozin.rail.all.material") //new
    private long owpMonthSentTozinRailAllMaterial;
    @ReportField(titleMessageKey = "owp.month.sent.weight.rail.all.material") //new
    private long owpMonthSentWeightRailAllMaterial;
    @ReportField(titleMessageKey = "owp.year.sent.tozin.rail.all.material") //new
    private long owpYearSentTozinRailAllMaterial;
    @ReportField(titleMessageKey = "owp.year.sent.weight.rail.all.material") //new
    private long owpYearSentWeightRailAllMaterial;
    @ReportField(titleMessageKey = "owp.day.sent.tozin.road.all.material") //new
    private long owpDaySentTozinRoadAllMaterial;
    @ReportField(titleMessageKey = "owp.day.sent.weight.road.all.material") //new
    private long owpDaySentWeightRoadAllMaterial;
    @ReportField(titleMessageKey = "owp.total.sent.weight.road.all.material") //new
    private long owpTotalSentWeightRoadAllMaterial;
    @ReportField(titleMessageKey = "owp.total.sent.tozin.road.all.material") //new
    private long owpTotalSentTozinRoadAllMaterial;
    @ReportField(titleMessageKey = "owp.month.sent.tozin.road.all.material") //new
    private long owpMonthSentTozinRoadAllMaterial;
    @ReportField(titleMessageKey = "owp.month.sent.weight.road.all.material") //new
    private long owpMonthSentWeightRoadAllMaterial;
    @ReportField(titleMessageKey = "owp.year.sent.tozin.road.all.material") //new
    private long owpYearSentTozinRoadAllMaterial;
    @ReportField(titleMessageKey = "owp.year.sent.weight.road.all.material") //new
    private long owpYearSentWeightRoadAllMaterial;
    @ReportField(titleMessageKey = "owp.day.sent.tozin.all.material") //new
    private long owpDaySentTozinAllMaterial;
    @ReportField(titleMessageKey = "owp.day.sent.weight.all.material") //new
    private long owpDaySentWeightAllMaterial;
    @ReportField(titleMessageKey = "owp.month.sent.tozin.all.material") //new
    private long owpMonthSentTozinAllMaterial;
    @ReportField(titleMessageKey = "owp.month.sent.weight.all.material") //new
    private long owpMonthSentWeightAllMaterial;
    @ReportField(titleMessageKey = "owp.year.sent.tozin.all.material") //new
    private long owpYearSentTozinAllMaterial;
    @ReportField(titleMessageKey = "owp.year.sent.weight.all.material") //new
    private long owpYearSentWeightAllMaterial;

    public Long getOwpDaySentTozinRail(){
        return owpDayNotArrivedTozinRail + owpDayArrivedTozinRail;
    }
    public Long getOwpDaySentWeightRail(){
        return owpDayNotArrivedWeightRail + owpDayArrivedWeightRail;
    }
    public Long getOwpDaySentTozinRoad(){
        return owpDayNotArrivedTozinRoad + owpDayArrivedTozinRoad;
    }
    public Long getOwpDaySentWeightRoad(){
        return owpDayNotArrivedWeightRoad + owpDayArrivedWeightRoad;
    }
    public Long getOwpMonthSentTozinRail(){
        return owpMonthNotArrivedTozinRail + owpMonthArrivedTozinRail;
    }
    public Long getOwpMonthSentWeightRail(){
        return owpMonthNotArrivedWeightRail + owpMonthArrivedWeightRail;
    }
    public Long getOwpMonthSentTozinRoad(){
        return owpMonthNotArrivedTozinRoad + owpMonthArrivedTozinRoad;
    }
    public Long getOwpMonthSentWeightRoad(){
        return owpMonthNotArrivedWeightRoad + owpMonthArrivedWeightRoad;
    }
    public Long getOwpYearSentTozinRail(){
        return owpYearNotArrivedTozinRail + owpYearArrivedTozinRail;
    }
    public Long getOwpYearSentWeightRail(){
        return owpYearNotArrivedWeightRail + owpYearArrivedWeightRail;
    }
    public Long getOwpYearSentTozinRoad(){
        return owpYearNotArrivedTozinRoad + owpYearArrivedTozinRoad;
    }
    public Long getOwpYearSentWeightRoad(){
        return owpYearNotArrivedWeightRoad + owpYearArrivedWeightRoad;
    }
    public Long getOwpDaySentTozinRailAllMaterial(){
        return owpDayNotArrivedTozinRailAllMaterial + owpDayArrivedTozinRailAllMaterial;
    }
    public Long getOwpDaySentWeightRailAllMaterial(){
        return owpDayNotArrivedWeightRailAllMaterial + owpDayArrivedWeightRailAllMaterial;
    }

    public Long getOwpMonthSentTozinRailAllMaterial(){
        return owpMonthNotArrivedTozinRailAllMaterial + owpMonthArrivedTozinRailAllMaterial;
    }
    public Long getOwpMonthSentWeightRailAllMaterial(){
        return owpMonthNotArrivedWeightRailAllMaterial + owpMonthArrivedWeightRailAllMaterial;
    }
    public Long getOwpYearSentTozinRailAllMaterial(){
        return owpYearNotArrivedTozinRailAllMaterial + owpYearArrivedTozinRailAllMaterial;
    }
    public Long getOwpYearSentWeightRailAllMaterial(){
        return owpYearNotArrivedWeightRailAllMaterial + owpYearArrivedWeightRailAllMaterial;
    }
    public Long getOwpDaySentTozinRoadAllMaterial(){
        return owpDayNotArrivedTozinRoadAllMaterial + owpDayArrivedTozinRoadAllMaterial;
    }
    public Long getOwpDaySentWeightRoadAllMaterial(){
        return owpDayNotArrivedWeightRoadAllMaterial + owpDayArrivedWeightRoadAllMaterial;
    }

    public Long getOwpMonthSentWeightRoadAllMaterial(){
        return owpMonthNotArrivedWeightRoadAllMaterial + owpMonthArrivedWeightRoadAllMaterial;
    }
    public Long getOwpYearSentTozinRoadAllMaterial(){
        return owpYearNotArrivedTozinRoadAllMaterial + owpYearArrivedTozinRoadAllMaterial;
    }
    public Long getOwpYearSentWeightRoadAllMaterial(){
        return owpYearNotArrivedWeightRoadAllMaterial + owpYearArrivedWeightRoadAllMaterial;
    }
    public Long getOwpDaySentTozinAllMaterial(){
        return owpDayNotArrivedTozinAllMaterial + owpDayArrivedTozinAllMaterial;
    }
    public Long getOwpDaySentWeightAllMaterial(){
        return owpDayNotArrivedWeightAllMaterial + owpDayArrivedWeightAllMaterial;
    }
    public Long getOwpMonthSentTozinAllMaterial(){
        return owpMonthNotArrivedTozinAllMaterial + owpMonthArrivedTozinAllMaterial;
    }
    public Long getOwpMonthSentWeightAllMaterial(){
        return owpMonthNotArrivedWeightAllMaterial + owpMonthArrivedWeightAllMaterial;
    }
    public Long getOwpYearSentTozinAllMaterial(){
        return owpYearNotArrivedTozinAllMaterial + owpYearArrivedTozinAllMaterial;
    }
    public Long getOwpYearSentWeightAllMaterial(){
        return owpYearNotArrivedWeightAllMaterial + owpYearArrivedWeightAllMaterial;
    }






    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("DailyReportBandarAbasInfo")
    public static class Info extends DailyReportBandarAbasDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("DailyReportBandarAbasInfo")
    public static class PDF extends DailyReportBandarAbasDTO.Info {
    }


    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class DailyReportBandarAbasIdDTO {

    }
}
