package com.nicico.sales.utility;

import com.nicico.copper.common.domain.i18n.CaptionFactory;
import lombok.RequiredArgsConstructor;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;

@Component
@RequiredArgsConstructor
public class MakeExcelOutputUtil {

    private XSSFSheet sheet;
    private XSSFWorkbook workbook;
    private XSSFCellStyle xssfBlankCellStyle;
    private XSSFCellStyle xssfHeaderCellStyle;
    private XSSFCellStyle xssfStringCellStyle;
    private XSSFCellStyle xssfNumberCellStyle;
    private XSSFCellStyle xssftopRowTitleCellStyle;
    private XSSFCellStyle xssfNumberCommaCellStyle;
    private XSSFCellStyle xssfNumberCommaCellStyleSum;

    public HttpServletResponse makeExcelResponse(byte[] excelData, HttpServletResponse response) throws IOException {

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-disposition", "attachment; filename=export.xlsx");
        response.getOutputStream().write(excelData);

        return response;
    }

    public byte[] makeOutput(List<Object> list, Class<?> entityClass, String[] fieldsName, String[] headers, Boolean insertRowNum, String topRowTitle) throws Exception {

        if (topRowTitle == null)
            topRowTitle = "";

        workbook = new XSSFWorkbook();
        sheet = workbook.createSheet("sheet1");
        sheet.addIgnoredErrors(new CellRangeAddress(0, list.size() + 1 + (!topRowTitle.trim().equals("") ? 1 : 0), 0, fieldsName.length + 1 + (insertRowNum ? 1 : 0)), IgnoredErrorType.NUMBER_STORED_AS_TEXT);
        sheet.setRightToLeft(true);

        setCellStyles();

        int rowNum = 0;
        rowNum = createTopRow(fieldsName, insertRowNum, topRowTitle, rowNum);
        rowNum = createHeaderRow(headers, insertRowNum, rowNum);
        rowNum = createItemRows(list, entityClass, fieldsName, insertRowNum, topRowTitle, rowNum);

        // Freeze Pane
        if (!topRowTitle.trim().equals("")) sheet.createFreezePane(0, 2);
        else sheet.createFreezePane(1, 1);

        // AutoSize Columns
        makeColumnsAutoSize(fieldsName, insertRowNum);

        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        workbook.write(byteArrayOutputStream);
        byteArrayOutputStream.close();

        return byteArrayOutputStream.toByteArray();
    }

    private void setCellStyles() {

        xssftopRowTitleCellStyle = workbook.createCellStyle();
        xssfHeaderCellStyle = workbook.createCellStyle();
        xssfStringCellStyle = workbook.createCellStyle();
        xssfNumberCellStyle = workbook.createCellStyle();
        xssfNumberCommaCellStyle = workbook.createCellStyle();
        XSSFCellStyle xssfNumberComma3CellStyle = workbook.createCellStyle();
        xssfBlankCellStyle = workbook.createCellStyle();
        xssfNumberCommaCellStyleSum = workbook.createCellStyle();
        XSSFCellStyle xssfNumberComma3CellStyleSum = workbook.createCellStyle();


        // Double 3 dot format
        XSSFDataFormat xssfDataFormat = workbook.createDataFormat();
        short doubleDecimalDataFormat = xssfDataFormat.getFormat("#,##0.000");

        // topRowTitle
        xssftopRowTitleCellStyle.setBorderLeft(BorderStyle.THIN);
        xssftopRowTitleCellStyle.setBorderTop(BorderStyle.THIN);
        xssftopRowTitleCellStyle.setBorderRight(BorderStyle.THIN);
        xssftopRowTitleCellStyle.setBorderBottom(BorderStyle.THIN);
        xssftopRowTitleCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        xssftopRowTitleCellStyle.setAlignment(HorizontalAlignment.RIGHT);
        XSSFColor customColor = new XSSFColor(new java.awt.Color(250, 210, 190, 128));
        xssftopRowTitleCellStyle.setFillForegroundColor(customColor);
        xssftopRowTitleCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        // Header Row
        xssfHeaderCellStyle.setBorderLeft(BorderStyle.THIN);
        xssfHeaderCellStyle.setBorderTop(BorderStyle.THIN);
        xssfHeaderCellStyle.setBorderRight(BorderStyle.THIN);
        xssfHeaderCellStyle.setBorderBottom(BorderStyle.THIN);
        xssfHeaderCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        xssfHeaderCellStyle.setAlignment(HorizontalAlignment.CENTER);
        xssfHeaderCellStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
        xssfHeaderCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
//        Font header = workbook.createFont();
//        header.setBold(true);
//        header.setFontHeightInPoints((short) 14);
//        header.setColor(IndexedColors.RED.getIndex());


        // String Fields
        xssfStringCellStyle.setAlignment(HorizontalAlignment.RIGHT);
        xssfStringCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        xssfStringCellStyle.setBorderLeft(BorderStyle.THIN);
        xssfStringCellStyle.setBorderTop(BorderStyle.THIN);
        xssfStringCellStyle.setBorderRight(BorderStyle.THIN);
        xssfStringCellStyle.setBorderBottom(BorderStyle.THIN);

        // Standard Number Fields
        xssfNumberCellStyle.setAlignment(HorizontalAlignment.RIGHT);
        xssfNumberCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        xssfNumberCellStyle.setBorderLeft(BorderStyle.THIN);
        xssfNumberCellStyle.setBorderTop(BorderStyle.THIN);
        xssfNumberCellStyle.setBorderRight(BorderStyle.THIN);
        xssfNumberCellStyle.setBorderBottom(BorderStyle.THIN);
        xssfNumberCellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("0"));

        // Comma Separated Number Fields
        xssfNumberCommaCellStyle.setAlignment(HorizontalAlignment.RIGHT);
        xssfNumberCommaCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        xssfNumberCommaCellStyle.setBorderLeft(BorderStyle.THIN);
        xssfNumberCommaCellStyle.setBorderTop(BorderStyle.THIN);
        xssfNumberCommaCellStyle.setBorderRight(BorderStyle.THIN);
        xssfNumberCommaCellStyle.setBorderBottom(BorderStyle.THIN);
        xssfNumberCommaCellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));

        // Comma Separated With 3 Dot Number Fields
        xssfNumberComma3CellStyle.setAlignment(HorizontalAlignment.RIGHT);
        xssfNumberComma3CellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        xssfNumberComma3CellStyle.setBorderLeft(BorderStyle.THIN);
        xssfNumberComma3CellStyle.setBorderTop(BorderStyle.THIN);
        xssfNumberComma3CellStyle.setBorderRight(BorderStyle.THIN);
        xssfNumberComma3CellStyle.setBorderBottom(BorderStyle.THIN);
        xssfNumberComma3CellStyle.setDataFormat(doubleDecimalDataFormat);

        // String Fields
        xssfBlankCellStyle.setAlignment(HorizontalAlignment.RIGHT);
        xssfBlankCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        xssfBlankCellStyle.setBorderTop(BorderStyle.THIN);

        // Comma Separated Number Fields
        xssfNumberCommaCellStyleSum.setAlignment(HorizontalAlignment.RIGHT);
        xssfNumberCommaCellStyleSum.setVerticalAlignment(VerticalAlignment.CENTER);
        xssfNumberCommaCellStyleSum.setBorderLeft(BorderStyle.THIN);
        xssfNumberCommaCellStyleSum.setBorderTop(BorderStyle.THIN);
        xssfNumberCommaCellStyleSum.setBorderRight(BorderStyle.THIN);
        xssfNumberCommaCellStyleSum.setBorderBottom(BorderStyle.THIN);
        xssfNumberCommaCellStyleSum.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
        xssfNumberCommaCellStyleSum.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());
        xssfNumberCommaCellStyleSum.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        // Comma Separated With 3 Dot Number Fields
        xssfNumberComma3CellStyleSum.setAlignment(HorizontalAlignment.RIGHT);
        xssfNumberComma3CellStyleSum.setVerticalAlignment(VerticalAlignment.CENTER);
        xssfNumberComma3CellStyleSum.setBorderLeft(BorderStyle.THIN);
        xssfNumberComma3CellStyleSum.setBorderTop(BorderStyle.THIN);
        xssfNumberComma3CellStyleSum.setBorderRight(BorderStyle.THIN);
        xssfNumberComma3CellStyleSum.setBorderBottom(BorderStyle.THIN);
        xssfNumberComma3CellStyleSum.setDataFormat(doubleDecimalDataFormat);
        xssfNumberComma3CellStyleSum.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());
        xssfNumberComma3CellStyleSum.setFillPattern(FillPatternType.SOLID_FOREGROUND);
    }

    private Field getField(String fieldName, Class<?> entityClass) {

        try {

            return entityClass.getDeclaredField(fieldName);

        } catch (NoSuchFieldException e) {

            return getField(fieldName, entityClass.getSuperclass());
        }
    }

    private Method getMethod(String fieldName, Class<?> entityClass) {

        try {

            return entityClass.getDeclaredMethod(fieldName);

        } catch (NoSuchMethodException e) {

            try {

                return entityClass.getDeclaredMethod("get" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1));

            } catch (NoSuchMethodException e2) {

                return getMethod(fieldName, entityClass.getSuperclass());
            }
        }
    }

    @SuppressWarnings("unchecked")
    private Object getFieldValue(List fieldNames, Object item, Class<?> entityClass) throws Exception {

        Object obj = getObject(fieldNames, item, entityClass);

        if (obj == null) return null;
        if (fieldNames.size() == 1) return obj;
        else {

            Class c = obj.getClass();
            fieldNames.remove(0);
            List<Class> classes = Arrays.asList(c.getInterfaces());
            if (classes.contains(List.class) || classes.contains(Set.class)) {

                List<String> listValue = new ArrayList();
                for (Object itemValue : (List) obj)
                    listValue.add(String.valueOf(getFieldValue(fieldNames, itemValue, itemValue.getClass())));

                return String.join(", ", listValue);
            }

            return getFieldValue(fieldNames, obj, c);
        }
    }

    private Object getObject(List fieldNames, Object item, Class<?> entityClass) throws IllegalAccessException, InvocationTargetException {

        Object obj;
        if (entityClass.equals(Map.class))
            obj = ((Map) item).get(fieldNames.get(0));
        else
            try {

                Field field = getField(fieldNames.get(0).toString(), entityClass);
                field.setAccessible(true);
                obj = field.get(item);

            } catch (Exception e2) {

                Method method = getMethod(fieldNames.get(0).toString(), entityClass);
                method.setAccessible(true);
                obj = method.invoke(item);
            }

        return obj;
    }

    private void makeColumnsAutoSize(String[] fieldsName, Boolean insertRowNum) {
        XSSFFormulaEvaluator.evaluateAllFormulaCells(workbook);
        for (int i = 0; i < fieldsName.length + (insertRowNum ? 1 : 0); i++) {
            sheet.autoSizeColumn(i, true);
        }
    }

    private int createTopRow(String[] fieldsName, Boolean insertRowNum, String topRowTitle, int rowNum) {

        if (!topRowTitle.trim().equals("")) {

            Row topRow = sheet.createRow(rowNum++);
            for (int i = 0; i < fieldsName.length + (insertRowNum ? 1 : 0); i++) {

                Cell cell = topRow.createCell(i);
                cell.setCellType(CellType.STRING);

                if (i == 0) cell.setCellValue(topRowTitle);
                else cell.setCellValue("");

                cell.setCellStyle(xssftopRowTitleCellStyle);
            }

            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, fieldsName.length - (insertRowNum ? 0 : 1)));
        }

        return rowNum;
    }

    private int createHeaderRow(String[] headers, Boolean insertRowNum, int rowNum) {

        Row headerRow = sheet.createRow(rowNum++);

        int i = 0;
        if (insertRowNum) {

            Cell cell = headerRow.createCell(i++);
            cell.setCellValue("ردیف");
            cell.setCellStyle(xssfHeaderCellStyle);
        }
        for (String header : headers)
            if (!header.equalsIgnoreCase("")) {

                Cell cell = headerRow.createCell(i++);
                cell.setCellValue(header);
                cell.setCellStyle(xssfHeaderCellStyle);
            }

        return rowNum;
    }

    private int createItemRows(List<Object> list, Class<?> entityClass, String[] fieldsName, Boolean insertRowNum, String topRowTitle, int rowNum) throws Exception {

        for (Object item : list) {

            Row row = sheet.createRow(rowNum++);

            int i = 0;
            if (insertRowNum) {

                Cell cell = row.createCell(i++);
                cell.setCellValue(row.getRowNum() - (topRowTitle.trim().equals("") ? 0 : 1));
                cell.setCellStyle(xssfNumberCellStyle);
            }

            for (String fieldName : fieldsName) {

                List<String> fieldNames = new ArrayList<>(Arrays.asList(fieldName.split(Pattern.quote("."))));
                Cell cell = row.createCell(i++);

                Object obj = getFieldValue(fieldNames, item, entityClass);
                if (obj != null) {

                    String objType = obj.getClass().getTypeName();
                    if (objType.equalsIgnoreCase(Date.class.getName())) {

                        cell.setCellType(CellType.STRING);
                        cell.setCellValue(new SimpleDateFormat("YYYY/MM/dd").format(obj));
                        cell.setCellStyle(xssfStringCellStyle);
                    } else if (objType.equalsIgnoreCase(Long.class.getName())) {

                        cell.setCellType(CellType.NUMERIC);
                        cell.setCellValue(Long.parseLong(obj.toString()));
                        cell.setCellStyle(xssfNumberCellStyle);
                    } else if (objType.equalsIgnoreCase(Double.class.getName())) {

                        cell.setCellType(CellType.NUMERIC);
                        cell.setCellValue(((Double) obj));
                        cell.setCellStyle(xssfNumberCommaCellStyle);
                    } else if (objType.equalsIgnoreCase(Boolean.class.getName())) {

                        cell.setCellType(CellType.BOOLEAN);
                        cell.setCellValue(obj.toString().equalsIgnoreCase("true") ? CaptionFactory.getLabel("yes") : CaptionFactory.getLabel("no"));
                        cell.setCellStyle(xssfStringCellStyle);
                    } else {

                        cell.setCellType(CellType.STRING);
                        cell.setCellValue(obj.toString());
                        cell.setCellStyle(xssfStringCellStyle);
                    }
                } else {

                    cell.setCellType(CellType.STRING);
                    cell.setCellStyle(xssfStringCellStyle);
                }
            }
        }

        return rowNum;
    }
}