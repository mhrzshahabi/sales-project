package com.nicico.sales.dto;

public class DateEventValuesDTO {

    private String firstOfMonth;
    private String firstOfYear;
    private String yeasterday;
    private String beforMonth;
    private String beforeYear;

    public DateEventValuesDTO() {

    }

    public DateEventValuesDTO(String firstOfMonth, String firstOfYear, String yeasterday, String beforMonth, String beforeYear) {
        this.firstOfMonth = firstOfMonth;
        this.firstOfYear = firstOfYear;
        this.yeasterday = yeasterday;
        this.beforMonth = beforMonth;
        this.beforeYear = beforeYear;
    }

    public String getFirstOfMonth() {
        return firstOfMonth;
    }

    public void setFirstOfMonth(String firstOfMonth) {
        this.firstOfMonth = firstOfMonth;
    }

    public String getFirstOfYear() {
        return firstOfYear;
    }

    public void setFirstOfYear(String firstOfYear) {
        this.firstOfYear = firstOfYear;
    }

    public String getYeasterday() {
        return yeasterday;
    }

    public void setYeasterday(String yeasterday) {
        this.yeasterday = yeasterday;
    }

    public String getBeforMonth() {
        return beforMonth;
    }

    public void setBeforMonth(String beforMonth) {
        this.beforMonth = beforMonth;
    }

    public String getBeforeYear() {
        return beforeYear;
    }

    public void setBeforeYear(String beforeYear) {
        this.beforeYear = beforeYear;
    }
}
