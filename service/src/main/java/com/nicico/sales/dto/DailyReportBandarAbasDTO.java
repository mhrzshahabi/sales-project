package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.annotation.report.ReportField;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.persistence.Column;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
//@JsonInclude()
public class DailyReportBandarAbasDTO {
    
    @ReportField(titleMessageKey="Daily-report.dat")
    private String date;
    
    @ReportField(titleMessageKey="Daily-report.source")
    private Long source;
    
    @ReportField(titleMessageKey="Daily-report.material")
    private Long material;
    
    @ReportField(titleMessageKey="Daily-report.source.name")
    private String sourceName;
    
    @ReportField(titleMessageKey="Daily-report.material.name")
    private String materialName;
    @Column(name = "materialp")
    private Long materialp;
    @Column(name = "materialpname")
    private String materialPName;
    @ReportField(titleMessageKey="Daily-report.IN.PKG.DAY")
    private Long inPkgDay;
    
    @ReportField(titleMessageKey="Daily-report.IN.PKG.MONTH")
    private Long inPkgMonth;
    
    @ReportField(titleMessageKey="Daily-report.IN.PKG.YEAR")
    private Long inPkgYear;
    
   @ReportField(titleMessageKey="Daily-report.IN.AMOUNT.DAY")
   private Long inAmountDay;
    
    @ReportField(titleMessageKey="Daily-report.IN.AMOUNT.MONTH")
    private Long inAmountMonth;
    
  @ReportField(titleMessageKey="Daily-report.IN.AMOUNT.YEAR")
  private Long inAmountYear;
    
  @ReportField(titleMessageKey="Daily-report.OUT.PKG.DAY")
  private Long outPkgDay;
    
   @ReportField(titleMessageKey="Daily-report.OUT.PKG.MONTH")
   private Long outPkgMonth;
    
   @ReportField(titleMessageKey="Daily-report.OUT.PKG.YEAR")
   private Long outPkgYear;
    
   @ReportField(titleMessageKey="Daily-report.OUT.AMOUNT.DAY")
   private Long outAmountDay;
    
   @ReportField(titleMessageKey="Daily-report.OUT.AMOUNT.MONTH")
   private Long outAmountMonth;
    
   @ReportField(titleMessageKey="Daily-report.OUT.AMOUNT.YEAR")
   private Long outAmountYear;
    
   @ReportField(titleMessageKey="Daily-report.REMAINED.PKG")
   private Long remainedPkg;
    
   @ReportField(titleMessageKey="Daily-report.REMAINED.AMOUNT")
   private Long remainedAmount;
    
   @ReportField(titleMessageKey="Daily-report.INCOME.WEIGHT.DAY")
   private Long incomeWeightDay;
    
   @ReportField(titleMessageKey="Daily-report.INCOME.WEIGHT.MONTH")
   private Long incomeWeightMonth;
    
   @ReportField(titleMessageKey="Daily-report.INCOME.WEIGHT.YEAR")
   private Long incomeWeightYear;
    
   @ReportField(titleMessageKey="Daily-report.OUT.WEIGHT.DAY")
   private Long outWeightDay;
    
   @ReportField(titleMessageKey="Daily-report.OUT.WEIGHT.MONTH")
   private Long outWeightMonth;
    
   @ReportField(titleMessageKey="Daily-report.OUT.WEIGHT.YEAR")
   private Long outWeightYear;
    
   @ReportField(titleMessageKey="Daily-report.REMAINED.WEIGHT")
   private Long remainedWeight;
    @ReportField(titleMessageKey="Daily-report.OWP.tadil-month")
    private Long tadilYear;
    @ReportField(titleMessageKey="Daily-report.OWP.tadil-year")
    private Long tadilMonth;
    @ReportField(titleMessageKey="Daily-report.OWP.tadil")
    private Long tadil;

   @ReportField(titleMessageKey="Daily-report.OWP.WEIGHT")
   private Long owpWeight;
   @ReportField(titleMessageKey="Daily-report.OWP.PKG")
   private Long owpPkg;
   @ReportField(titleMessageKey="Daily-report.OWP.TOZIN")
    private Long owpTozin;
    private Double tadilYearPrecent;
    @ReportField(titleMessageKey="global.unit")
    private String unit;


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
