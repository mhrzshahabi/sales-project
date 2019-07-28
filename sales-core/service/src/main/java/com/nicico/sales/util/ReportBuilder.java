package com.nicico.sales.util;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.design.*;
import net.sf.jasperreports.engine.type.HorizontalAlignEnum;
import net.sf.jasperreports.engine.type.HorizontalTextAlignEnum;
import net.sf.jasperreports.engine.type.OrientationEnum;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

public class ReportBuilder {
    public static JasperDesign getPageTemplateDesign(String templatePath) throws JRException {

        JasperDesign jasDes = JRXmlLoader.load(templatePath);
        jasDes.setName("report");
        jasDes.setOrientation(OrientationEnum.PORTRAIT);

        // Style
        JRDesignStyle mystyle = new JRDesignStyle();
        mystyle.setName("mystyle");
        mystyle.setDefault(true);
        mystyle.setFontSize(12f);
        mystyle.setPdfFontName("Helvetica");
        mystyle.setPdfEncoding("UTF-8");
        jasDes.addStyle(mystyle);

        // Fields
        JRDesignField field1 = new JRDesignField();
        field1.setName("id");
        field1.setValueClass(Long.class);
        jasDes.addField(field1);

        JRDesignField field2 = new JRDesignField();
        field2.setName("contractNo");
        field2.setValueClass(String.class);
        jasDes.addField(field2);

        // Title

        JRDesignBand bHeader = (JRDesignBand) jasDes.getColumnHeader();
        JRDesignStaticText text1 = new JRDesignStaticText();
        text1.setText("id");
        text1.setWidth(40);
        text1.setHeight(20);
        text1.setX(0);
        text1.setY(0);
        bHeader.addElement(text1);

        JRDesignStaticText text2 = new JRDesignStaticText();
        text2.setText("id");
        text2.setWidth(40);
        text2.setHeight(20);
        text2.setX(0);
        text2.setY(0);
        bHeader.addElement(text2);

        // Detail
        JRDesignBand detailBand = new JRDesignBand();
        detailBand.setHeight(60);

        JRDesignTextField tf2 = new JRDesignTextField();
        tf2.setBlankWhenNull(true);
        tf2.setX(0);
        tf2.setY(0);
        tf2.setWidth(40);
        tf2.setHeight(20);
        tf2.setHorizontalTextAlign(HorizontalTextAlignEnum.CENTER);
        tf2.setStyle(mystyle);
        tf2.setExpression(new JRDesignExpression("$F{id}"));
        detailBand.addElement(tf2);

        JRDesignTextField tf3 = new JRDesignTextField();
        tf3.setBlankWhenNull(true);
        tf3.setX(40);
        tf3.setY(0);
        tf3.setWidth(40);
        tf3.setHeight(20);
        tf3.setHorizontalTextAlign(HorizontalTextAlignEnum.CENTER);
        tf3.setStyle(mystyle);
        tf3.setExpression(new JRDesignExpression("$F{contractNo}"));
        detailBand.addElement(tf3);

        ((JRDesignSection) jasDes.getDetailSection()).addBand(detailBand);

        return jasDes;
    }
}
