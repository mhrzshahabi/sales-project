package com.nicico.sales.service;

import com.nicico.sales.dto.DateEventValuesDTO;
import com.nicico.sales.iservice.IDateEventService;

import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class DateEventService implements IDateEventService {
    @Override
    public DateEventValuesDTO calDateValues(String date) {

        DateEventValuesDTO dateEventValues = new DateEventValuesDTO();
        String exper = new String();
        String experMoon = new String();
        String experYear = new String();
        ArrayList<String> nimeAvalSal = new ArrayList<String>(6);
        ArrayList<String> nimeDovomSal = new ArrayList<String>(6);
        nimeAvalSal.add("01");
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
        String sjustmahghabl = new String();
        Integer justmahghabl = 0;
        String testDayAvlinRoz = date.substring(8, 10);
        String testDayAvalFarvardin = date.substring(5, 10);
        //cal yesterday
        //1398/01/27
        String gheirRoz = date.substring(0, 8);
        String firstOfMonth = date.substring(0, 8).concat("01");
        String firstOfYears = date.substring(0, 5).concat("01/01");


        Integer justparSal = (Integer.valueOf(date.substring(0, 4)) - 1);
        String sjustparSal = justparSal.toString().concat("/");
        Integer beforDayInt = (Integer.valueOf(date.substring(8, 10)) - 1);
        if (date.substring(5, 7).matches("01")) {
            justmahghabl = 12;
            sjustmahghabl = sjustparSal.concat(justmahghabl.toString()).concat("/");
        } else {
            justmahghabl = Integer.valueOf(date.substring(5, 7)) - 1;
            sjustmahghabl = date.substring(0, 6).concat(justmahghabl.toString()).concat("/");
        }

        //test if nimeaval or nimedovom
        String testNimeAvalDovom = date.substring(5, 7);

        //        but //1398/08/01 -> 30
        if (testDayAvalFarvardin.matches("01/01")) {
            exper = sjustparSal.toString().concat("30");

            experMoon = exper;

        }
        // initvaluesDay=  initvaluesMoon=initvaluesYear=}
        else if (testDayAvlinRoz.matches("01") && nimeAvalSal.contains(testNimeAvalDovom) && !testDayAvalFarvardin.matches("01/01")) {//1398/05/01 || 1398/01/05
            exper = sjustmahghabl.concat("31");

            experMoon = exper;

        } else if (testDayAvlinRoz.matches("01") && nimeDovomSal.contains(testNimeAvalDovom)) {//1398/08/01
            exper = sjustmahghabl.concat("30");

            experMoon = exper;
        } else {//1398/08/29 //1398/01/27
            exper = gheirRoz.concat(beforDayInt.toString());

            if (date.substring(5, 7).matches(testNimeAvalDovom))
                experMoon = sjustmahghabl.concat("30");
            else experMoon = sjustmahghabl.concat("31");
        }
        experYear = sjustparSal.concat("12/30");


        dateEventValues.setBeforeYear(experYear);
        dateEventValues.setBeforMonth(experMoon);
        dateEventValues.setYeasterday(exper);
        dateEventValues.setFirstOfMonth(firstOfMonth);//1398/05/06--1398/05/01
        dateEventValues.setFirstOfYear(firstOfYears);//1398/05/06--1398/01/01

        return dateEventValues;
    }
}
