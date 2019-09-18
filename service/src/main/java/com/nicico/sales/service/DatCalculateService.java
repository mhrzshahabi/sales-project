package com.nicico.sales.service;


import com.ghasemkiani.util.icu.PersianCalendar;
import com.github.eloyzone.jalalicalendar.*;
import com.nicico.sales.dto.DateEventValuesDTO;
import com.nicico.sales.iservice.IDateCalculateService;

import ir.huri.jcal.JalaliCalendar;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * Created by m.azarpour on 3/13/2019.
 */
@Service
public class DatCalculateService implements IDateCalculateService {
  //  ResponseDateDTO responseDate = new ResponseDateDTO();
    DateEventValuesDTO dateEventValues = new DateEventValuesDTO();
    PersianCalendar persianCalendar1 = new PersianCalendar(new Date());
    DecimalFormat mFormat = new DecimalFormat("00");


    @Override
    public String calYesterday(String date) {
        String thisday = date.substring(8, 10);
        String thismonth = date.substring(5, 7);
        String thisYear = date.substring(0, 4);
        JalaliCalendar jalaliCalendar = new JalaliCalendar(Integer.valueOf(thisYear), Integer.valueOf(thismonth), Integer.valueOf(thisday));
        GregorianCalendar gc = jalaliCalendar.toGregorian();
        Date tomiladi = gc.getTime();
        PersianCalendar today = new PersianCalendar(tomiladi);
        Date yemiladi = new Date(tomiladi.getTime() - 2);
        PersianCalendar yesterday = new PersianCalendar(yemiladi);
        String year1 = mFormat.format((double) yesterday.get((Calendar.YEAR)));
        String month1 = mFormat.format((double) yesterday.get((Calendar.MONTH)) + 1);
        //  String month1 = mFormat.format((double) yesterday.get((Calendar.M)) + 1);
        String day1 = mFormat.format((double) yesterday.get((Calendar.DAY_OF_MONTH)));
        String correctYesterday = year1.concat("/").concat(month1).concat("/").concat(day1);
        return correctYesterday;

    }

    public DateEventValuesDTO getEveryDateYouWant(String date) throws ParseException {
        String endDayOfbeforMonth;
        String endDayOfbeforYear;
        String endDay;
        String beforMonthFor;
        ArrayList<String> nimeAvalSal = new ArrayList<String>(6);
        ArrayList<String> nimeDovomSal = new ArrayList<String>(6);
        nimeAvalSal.add("02");
        nimeAvalSal.add("03");
        nimeAvalSal.add("04");
        nimeAvalSal.add("05");
        nimeAvalSal.add("06");
        nimeAvalSal.add("07");
        nimeDovomSal.add("08");
        nimeDovomSal.add("09");
        nimeDovomSal.add("10");
        nimeDovomSal.add("11");
        nimeDovomSal.add("12");
        String thisday = date.substring(8, 10);
        String thismonth = date.substring(5, 7);
        String thisYear = date.substring(0, 4);

        JalaliCalendar jalaliCalendar = new JalaliCalendar(Integer.valueOf(thisYear), Integer.valueOf(thismonth), Integer.valueOf(thisday));

        GregorianCalendar gc = jalaliCalendar.toGregorian();
        Date tomiladi = gc.getTime();
        PersianCalendar today = new PersianCalendar(tomiladi);
        String yesterday = calYesterday(date);

        String year = mFormat.format((double) today.get((Calendar.YEAR)));
        /*endDayOfbeforMonth*/ /*3 state 1398/01/01---1398/05/10/---1398/05/01---1398/08/10-1398/01/20*/
        if (thismonth.matches("01")) {
            if (thisday.matches("01")) endDayOfbeforMonth = yesterday;
            else endDayOfbeforMonth = calYesterday(thisYear.concat("/").concat(thismonth).concat("/").concat("01"));

        } else {
            beforMonthFor = mFormat.format((double) today.get((Calendar.MONTH)));
            if (nimeAvalSal.contains(thismonth)) endDay = "31";
            else endDay = "30";
            endDayOfbeforMonth = thisYear.concat("/").concat(beforMonthFor).concat("/").concat(endDay);
        }

        endDayOfbeforYear = calYesterday(thisYear.concat("/").concat("01").concat("/").concat("01"));

        dateEventValues.setYeasterday(yesterday);
        dateEventValues.setFirstOfMonth(thisYear.concat("/").concat(thismonth).concat("/").concat("01"));
        dateEventValues.setFirstOfYear(thisYear + "/" + "01" + "/" + "01");

        dateEventValues.setBeforMonth(endDayOfbeforMonth);
        dateEventValues.setBeforeYear(endDayOfbeforYear);


        return dateEventValues;
    }


}


