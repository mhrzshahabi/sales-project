package com.nicico.sales.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.nicico.sales.model.entities.base.myModel.WholeDto;
import org.activiti.engine.impl.util.json.JSONObject;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Component
public class ResultSetConverterTest {
    private final ObjectMapper objectMapper;
    private WholeDto wholeDto;
    JsonParser parser = new JsonParser();

    /*"amountDay",
                                "amountImportDay", "amountFirstDay", "amountExportDay", "amountReviseDay",
                                "amountFirstMon", "amountImportMon", "amountExportMon", "amountReviseMon",
                                "amountFirstSal", "amountImportSal", "amountExportSal", "amountReviseSal", "reviseSal", "aa"*/
   /* public List<JsonObject> toJsonArray(List<Object[]> resultSet, String[] columnNames
            ,List amountDaylist , String amountDay,List amountImportDayList , String amountImportDay
            ,List amountFirstDaylist , String amountFirstDay,List amountExportDaylist , String amountExportDay
            ,List amountReviseDaylist , String amountReviseDay,List amountFirstMonlist , String amountFirstMon
            ,List amountImportMonlist, String amountImportMon ,List amountExportMonlist, String amountExportMon
            ,List amountReviseMonlist, String amountReviseMon ,List amountFirstSallist, String amountFirstSal
            ,List amountImportSallist , String amountImportSal ,List  amountExportSallist, String amountExportSal
            ,List amountReviseSallist  , String amountReviseSal ,List reviseSallist, String reviseSal ,List aalist, String aa ) {*/
    public List<JsonObject> toJsonArray(List<WholeDto> resultSet, String[] columnNames) throws CloneNotSupportedException {
        List<JsonObject> res = new ArrayList();
        // Iterator iterator = resultSet.iterator();
        //List<Object[]> result=mapper(resultSet);
        Iterator iterator = resultSet.iterator();
       /*Object oo
        =((ArrayList<WholeDto>) resultSet).clone();
       Object[] test= resultSet.toArray().clone();*/


        JSONObject obj = new JSONObject();


        while (iterator.hasNext()) {
            //     Object[] next = (Object[]) iterator.next();
            wholeDto = (WholeDto) iterator.next();



            //  WholeDto  = (WholeDto) iterator.next();;

            //WholeDto emp = objectMapper.re(, WholeDto.class);

            /* for (int i = 0; i < 17; ++i) {*/
            // String column_name = columnNames[i];
            obj.put(columnNames[0], wholeDto.getWarehouse());
            obj.put(columnNames[1], wholeDto.getToDay());
            //obj.put(columnNames[2], wholeDto.getPackingType());
            obj.put(columnNames[2], wholeDto.getDescp());
            obj.put(columnNames[3], wholeDto.getPlant());
           // obj.put(columnNames[4], wholeDto.getAmountDay());
            obj.put(columnNames[4], wholeDto.getPackingType());
            obj.put(columnNames[7], wholeDto.getAmountFirstDay());
            obj.put(columnNames[5], wholeDto.getAmountDay());
            obj.put(columnNames[6], wholeDto.getAmountImportDay());
            obj.put(columnNames[8], wholeDto.getAmountExportDay());
            obj.put(columnNames[9], wholeDto.getAmountReviseDay());
            obj.put(columnNames[10], wholeDto.getAmountFirstMon());
            obj.put(columnNames[11], wholeDto.getAmountImportMon());
            obj.put(columnNames[12], wholeDto.getAmountExportMon());
            obj.put(columnNames[13], wholeDto.getAmountReviseMon());
            obj.put(columnNames[14], wholeDto.getAmountFirstSal());
            obj.put(columnNames[15], wholeDto.getAmountImportSal());
            obj.put(columnNames[16], wholeDto.getAmountExportSal());
            obj.put(columnNames[17], wholeDto.getAmountReviseSal());
            obj.put(columnNames[18], wholeDto.getReviseSal());
            obj.put(columnNames[19], wholeDto.getAa());
           //obj.put(columnNames[19], wholeDto.getAa());

            /*}*/

            String json = obj.toString();
            JsonObject o = parser.parse(json).getAsJsonObject();
            res.add(o);
        }

        return res;
    }

    public List<JsonObject> stringListToJsonArray(List<WholeDto> resultSet, String[] columnNames) {
        List<JsonObject> res = new ArrayList();
        Iterator iterator = resultSet.iterator();

        while (iterator.hasNext()) {
            // String next = (String) iterator.next();
            WholeDto next = (WholeDto) iterator.next();
            JSONObject obj = new JSONObject();
            String column_name = columnNames[0];
            obj.put(column_name, next);
            String json = obj.toString();
            JsonParser parser = new JsonParser();
            JsonObject o = parser.parse(json).getAsJsonObject();
            res.add(o);
        }

        return res;
    }

    public ResultSetConverterTest(final ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
    }

    public List<Object[]> mapper(List<WholeDto> wholeDtos) {
        List<Object[]> objects = new ArrayList<Object[]>();
        Object[] objects1;

        Object[] test = wholeDtos.toArray().clone();
        objects.add(test);
        return objects;

    }
}
