package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class HRMDTO {

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("BusinessDaysInfo")
    public static class BusinessDaysInfo {
        private List<DayInfo> before;
        private DayInfo today;
        private List<DayInfo> After;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("DayInfo")
    public static class DayInfo {
        private Integer yearJalali;
        private Integer monthJalali;
        private String dateJalali;
        private Integer dayOfMonthJalali;
        private String occasionJalali;
        private String monthNameJalali;
        private Boolean isHolidayJalali;
        private Boolean isLeapYearJalali;

        private Integer yearGrg;
        private Integer monthGrg;
        private String dateGrg;
        private Integer dayOfMonthGrg;
        private String occasionGrg;
        private String monthNameGrg;
        private Boolean isHolidayGrg;
        private Boolean isLeapYearGrg;

        private Integer yearHijri;
        private Integer monthHijri;
        private String dateHijri;
        private Integer dayOfMonthHijri;
        private String occasionHijri;
        private String monthNameHijri;
        private Boolean isHolidayHijri;
        private Boolean isLeapYearHijri;

        private Integer dayOfWeek;
        private Boolean isWeekend;
        private String dayOfWeekNameFa;

        private Integer season;
        private String seasonNameFa;

        private Timestamp timestamp;
    }


    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("BusinessDaysRq")
    public static class BusinessDaysRq {
        @NotNull
        @ApiModelProperty(required = true)
        private Integer type;
        @NotNull
        @ApiModelProperty(required = true)
        private Date date;
        private Integer before;
        private Integer after;
    }
}
