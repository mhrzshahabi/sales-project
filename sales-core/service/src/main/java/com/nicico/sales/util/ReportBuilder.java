package com.nicico.sales.util;

import com.nicico.sales.dto.ContractIncomeCostDTO;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRPen;
import net.sf.jasperreports.engine.design.*;
import net.sf.jasperreports.engine.type.*;
import net.sf.jasperreports.engine.xml.JRBandFactory;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import java.awt.*;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ReportBuilder {
    public static JasperDesign getPageTemplateDesign(InputStream templatePath, ArrayList<String> columns, ArrayList<String> fields) throws JRException {

        JasperDesign jasDes = JRXmlLoader.load(templatePath);
        jasDes.setName("report");
        jasDes.setOrientation(OrientationEnum.PORTRAIT);

        // Style
        JRDesignStyle mystyle = new JRDesignStyle();
        mystyle.setName("mystyle");
        mystyle.setDefault(true);
        mystyle.setFontSize(8f);
        mystyle.setPdfEncoding("UTF-8");
        jasDes.addStyle(mystyle);

        // Fields
        for (String myField : fields) {
            JRDesignField field = new JRDesignField();
            field.setName(myField);
            try {
                field.setValueClass(ContractIncomeCostDTO.class.getDeclaredField(myField).getType());
            } catch (NoSuchFieldException e) {
                e.printStackTrace();
            }
            jasDes.addField(field);
        }

        // Header
        JRDesignBand headerBand = new JRDesignBand();
        headerBand.setHeight(20);
        headerBand.setSplitType(SplitTypeEnum.STRETCH);

        // Detail
        JRDesignBand detailBand = new JRDesignBand();
        detailBand.setHeight(20);

        int start = 0;
        int index = 0;
        for (String column : columns) {
            headerBand.addElement(getStaticText(start, 0, 100, 20, column));
            detailBand.addElement(getTextField(start, 0, 100, 20, fields.get(index)));
            index++;
            start = start + 100;
        }

        jasDes.setColumnHeader(headerBand);
        ((JRDesignSection) jasDes.getDetailSection()).addBand(detailBand);

        return jasDes;
    }

    private static JRDesignStaticText getStaticText(int x, int y, int width, int height, String text) {
        JRDesignStaticText staticText = new JRDesignStaticText();
        staticText.setX(x);
        staticText.setY(y);
        staticText.setWidth(width);
        staticText.setHeight(height);
        staticText.setHorizontalTextAlign(HorizontalTextAlignEnum.CENTER);
        staticText.setVerticalTextAlign(VerticalTextAlignEnum.MIDDLE);
        staticText.setText(text);
        staticText.getLineBox().setPadding(1);
        staticText.getLineBox().getPen().setLineColor(Color.BLACK);
        staticText.getLineBox().getPen().setLineWidth(1f);
        return staticText;
    }

    private static JRDesignTextField getTextField(int x, int y, int width, int height, String text) {
        JRDesignTextField textField = new JRDesignTextField();
        textField.setBlankWhenNull(true);
        textField.setX(x);
        textField.setY(y);
        textField.setWidth(width);
        textField.setHeight(height);
        textField.setHorizontalTextAlign(HorizontalTextAlignEnum.CENTER);
        textField.setVerticalTextAlign(VerticalTextAlignEnum.MIDDLE);
        textField.setExpression(new JRDesignExpression("$F{" + text + "}"));
        textField.getLineBox().setPadding(1);
        textField.getLineBox().getPen().setLineColor(Color.BLACK);
        textField.getLineBox().getPen().setLineWidth(1f);
        return textField;
    }
}
