package com.nicico.sales.utility;

import com.nicico.sales.exception.NotFoundException;
import lombok.RequiredArgsConstructor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;

@Component
@RequiredArgsConstructor
public class MakeExcelInputUtil {

    public List<Map<String, Object>> getData(Integer sheetNum, Integer recordLimit, InputStream file, List<String> fieldNames) throws IOException {

        Workbook workbook = new XSSFWorkbook(file);
        Sheet sheet = workbook.getSheetAt(sheetNum);
        List<Map<String, Object>> result = new ArrayList<>();

        if (sheet == null) throw new NotFoundException(String.format("Sheet not found. [%d]", sheetNum));

        Iterator<Row> rowIterator = sheet.rowIterator();
        Row headerRow = rowIterator.next();
        if (headerRow == null) return result;

        List<Cell> neededCells = new ArrayList<>();
        for (Cell cell : headerRow)
            if (cell.getCellType() == Cell.CELL_TYPE_STRING && fieldNames.contains(cell.getStringCellValue()))
                neededCells.add(cell);

        if (fieldNames.size() != neededCells.size())
            throw new NotFoundException(String.format("Some cells not found. [%s]", String.join(",", fieldNames)));

        while (rowIterator.hasNext()) {

            Row row = rowIterator.next();
            if (recordLimit > 0 && row.getRowNum() > recordLimit) break;

            Map<String, Object> rowMap = new HashMap<>();
            for (Cell cell : neededCells) {

                switch (cell.getCellType()) {
                    case Cell.CELL_TYPE_BOOLEAN:

                        rowMap.put(cell.getStringCellValue(), row.getCell(cell.getColumnIndex()).getBooleanCellValue());
                        break;
                    case Cell.CELL_TYPE_FORMULA:

                        FormulaEvaluator formulaEvaluator = workbook.getCreationHelper().createFormulaEvaluator();
                        Cell evaluatedCell = formulaEvaluator.evaluateInCell(row.getCell(cell.getColumnIndex()));
                        switch (evaluatedCell.getCellType()) {
                            case Cell.CELL_TYPE_BOOLEAN:

                                rowMap.put(cell.getStringCellValue(), row.getCell(cell.getColumnIndex()).getBooleanCellValue());
                                break;
                            case Cell.CELL_TYPE_NUMERIC:

                                rowMap.put(cell.getStringCellValue(), row.getCell(cell.getColumnIndex()).getNumericCellValue());
                                break;
                            case Cell.CELL_TYPE_STRING:

                                rowMap.put(cell.getStringCellValue(), row.getCell(cell.getColumnIndex()).getStringCellValue());
                                break;
                        }
                        break;
                    case Cell.CELL_TYPE_NUMERIC:

                        rowMap.put(cell.getStringCellValue(), row.getCell(cell.getColumnIndex()).getNumericCellValue());
                        break;
                    case Cell.CELL_TYPE_STRING:

                        rowMap.put(cell.getStringCellValue(), row.getCell(cell.getColumnIndex()).getStringCellValue());
                        break;
                }
            }

            result.add(rowMap);
        }

        return result;
    }
}