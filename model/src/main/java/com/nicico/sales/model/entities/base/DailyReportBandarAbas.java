package com.nicico.sales.model.entities.base;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
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
    @Column(name = "OWP_WEIGHT")
    private Long owpWeight;
    @Column(name = "OWP_PKG")
    private Long owpPkg;
    @Column(name = "OWP_TOZIN")
    private Long owpTozin;

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
    @Column(name = "sum_OWP_WEIGHT")
    private Long sumOwpWeight;
    @Column(name = "sum_OWP_PKG")
    private Long sumOwpPkg;
    @Column(name = "sum_OWP_TOZIN")
    private Long sumOwpTozin;


    @EqualsAndHashCode
    public static class DailyReportBandAbasId implements Serializable {
        private String date;

        private Long source;

        private Long material;

    }

}
