package com.nicico.sales.web.controller;

import com.github.mfathi91.time.PersianDate;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.iservice.IShipmentService;
import lombok.RequiredArgsConstructor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xwpf.usermodel.*;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/shipment")
public class ShipmentFormController {
	    private final IShipmentService shipmentService;
	@RequestMapping("/showForm")
	public String showShipment() {

		return "shipment/shipment";
	}

	@RequestMapping("/print/{shipmentId}")
    public void printDocx(HttpServletRequest request, HttpServletResponse response,@PathVariable String shipmentId) {

             InputStream stream;

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        dtf.format(PersianDate.now());
        String dateday =  PersianDate.now().format(dtf);

        try {
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFFont font = workbook.createFont();
            font.setFontName("B Nazanin");
            XWPFDocument doc;

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ShipmentDTO.Info

               shipment = shipmentService.get(Long.valueOf(shipmentId));
               String description = shipment.getMaterial().getDescl();
               String shiptype = shipment.getShipmentType();


                if(description.contains("Copper Cathode Leaching") || description.contains("Copper Cathode") || description.contains("cat")  ){
                    if(shiptype.contains("bulk") ){

                        stream = new ClassPathResource("reports/word/Ship_Cat_bulk.docx").getInputStream();
                        ServletOutputStream out = response.getOutputStream();
                        doc = (XWPFDocument) new XWPFDocument(stream);
                        replacePOI(doc,"vessel_name", shipment.getVesselName());
                        replacePOI(doc,"agent", shipment.getContactByAgent().getNameFA());
                        replacePOI(doc,"contract_amount", shipment.getAmount().toString());
                        replacePOI(doc,"unitNameFa", shipment.getMaterial().getUnit().getNameFA());
                        replacePOI(doc,"descp",  shipment.getMaterial().getDescp());
                        replacePOI(doc,"tolorance", "-/+" + shipment.getContractShipment().getTolorance().toString() + "%" );
                        replacePOI(doc,"contract_no", shipment.getContract().getContractNo());

                        String[] loa = shipment.getPortByLoading().getPort().split(",");
                        replacePOI(doc, "loa", loa[0]);

                        String[] port = shipment.getPortByDischarge().getPort().split(",");
                        replacePOI(doc, "port", " به مقصد " + port[1] );


                        String[] portw = shipment.getPortByDischarge().getPort().split(",");
                        replacePOI(doc, "comp", " به مقصد بندر " + port[0] + " در کشور " + port[1] );

                        /**/

                        replacePOI(doc, "barname", String.valueOf(shipment.getNumberOfBLs()) );

                        /*Date */
                        replacePOI(doc, "dateday", dateday );
                        /*End Date*/


                        response.setHeader("Content-Disposition", "attachment; filename=\"Ship_Cat_bulk.doc\"");
                        response.setContentType("application/vnd.ms-word");
                        doc.write(out);
                        baos.writeTo(out);
                        out.flush();
                    } else if (shiptype.contains("container") ){

                        stream = new ClassPathResource("reports/word/Ship_Cat_Container.docx").getInputStream();
                        ServletOutputStream out = response.getOutputStream();
                        doc = (XWPFDocument) new XWPFDocument(stream);

                        replacePOI(doc,"agent", shipment.getContactByAgent().getNameFA());
                        replacePOI(doc,"contract_amount", shipment.getAmount().toString());
                        replacePOI(doc,"unitNameFa", shipment.getMaterial().getUnit().getNameFA());
                        replacePOI(doc,"descp",    shipment.getMaterial().getDescp() );
                        replacePOI(doc,"tolorance", "-/+" + shipment.getContractShipment().getTolorance().toString() + "%" );
                        replacePOI(doc,"contract_no", shipment.getContract().getContractNo());


                        List<String> inspector = shipmentService.inspector();
                        for(int i = 0 ; i < inspector.size() ; i++){

                            replacePOI(doc, "inspector",  inspector.get(i));
                        }


                        replacePOI(doc,"noContainer", String.valueOf(shipment.getNoContainer()));

                        replacePOI(doc, "loa", shipment.getPortByLoading().getPort());

                        String[] port = shipment.getPortByDischarge().getPort().split(",");
                        replacePOI(doc, "port", " به مقصد " + port[1] );


                        String[] portw = shipment.getPortByDischarge().getPort().split(",");
                        replacePOI(doc, "comp", " به مقصد بندر " + port[0] + " در کشور " + port[1] );



                        replacePOI(doc, "containerType", shipment.getContainerType());
                        replacePOI(doc, "blNumbers" ,   shipment.getBlNumbers());


                        replacePOI(doc, "bookingno" ,   "(Booking No."+shipment.getBookingCat() + ")" );


                        /*Date*/
                        replacePOI(doc, "dateday", dateday );
                        /*End Date*/


                        response.setHeader("Content-Disposition", "attachment; filename=\"Ship_Cat_Container.doc\"");
                        response.setContentType("application/vnd.ms-word");
                        doc.write(out);
                        baos.writeTo(out);
                        out.flush();
                    }
        }

        if(description.contains("Copper Concentrate")){
            if(shiptype.contains("bulk")){

                stream = new ClassPathResource("reports/word/Copper_Concentrate_bulk.docx").getInputStream();
                ServletOutputStream out = response.getOutputStream();
                doc = (XWPFDocument) new XWPFDocument(stream);

                replacePOI(doc,"tolorance", "-/+" + shipment.getContractShipment().getTolorance().toString() + "%" );
                replacePOI(doc,"vessel_name", shipment.getVesselName());
                replacePOI(doc,"contract_amount", shipment.getAmount().toString());
                replacePOI(doc,"descp",    shipment.getMaterial().getDescp() );
                replacePOI(doc,"unitNameFa", shipment.getMaterial().getUnit().getNameFA());
                replacePOI(doc,"contract_no", shipment.getContract().getContractNo());
                replacePOI(doc, "agent", shipment.getContactByAgent().getNameFA());
                replacePOI(doc, "loa", shipment.getPortByLoading().getPort());
                replacePOI(doc, "company", shipment.getContact().getNameFA());


                /*N*/
                    String[] port = shipment.getPortByDischarge().getPort().split(",");
                    replacePOI(doc, "port", " به مقصد " + port[1] );


                    String[] portw = shipment.getPortByDischarge().getPort().split(",");
                    replacePOI(doc, "comp", " به مقصد بندر " + port[0] + "در کشور " + port[1] );

                    /*Date*/
                replacePOI(doc, "dateday", dateday );
                    /*End Date*/


                List<String> inspector = shipmentService.inspector();
                for(int i = 0 ; i < inspector.size() ; i++){

                    replacePOI(doc, "inspector",  inspector.get(i));
                }



                response.setHeader("Content-Disposition", "attachment; filename=\"Copper_Concentrate_bulk.doc\"");
                response.setContentType("application/vnd.ms-word");
                doc.write(out);
                baos.writeTo(out);
                out.flush();
            }

        }

        if(description.contains("Molybdenum Oxide")){
            if(shiptype.contains("container")){


                stream = new ClassPathResource("reports/word/Molybdenum Oxide.docx").getInputStream();
                ServletOutputStream out = response.getOutputStream();
                doc = (XWPFDocument) new XWPFDocument(stream);
                /*Date*/
                replacePOI(doc, "dateday", dateday );
                /*End Date*/

                replacePOI(doc,"contract_amount", shipment.getAmount().toString());
                replacePOI(doc,"unitNameFa", shipment.getMaterial().getUnit().getNameFA());
                replacePOI(doc,"descp",    shipment.getMaterial().getDescp() );
                replacePOI(doc,"contract_no", shipment.getContract().getContractNo());
                replacePOI(doc, "agent", shipment.getContactByAgent().getNameFA());
                replacePOI(doc,"tolorance", "-/+" + shipment.getContractShipment().getTolorance().toString() + "%" );
                replacePOI(doc, "containerType",    shipment.getContainerType() +  " فوت "   );
                replacePOI(doc, "buyer",     shipment.getContact().getNameEN());
                replacePOI(doc, "company", shipment.getContactByAgent().getNameEN());
//                replacePOI(doc, "ffff", shipment.getContact().getNameFA());


                String[] portw = shipment.getPortByDischarge().getPort().split(",");
                replacePOI(doc, "comp", "به مقصد بندر " + portw[0] + "در کشور " + portw[1] );



                //***************************************************************************************************************************
                /*Add By Jalal Don't Forget To Add Moli */

                String shipId = shipment.getContract().getId();
                List<String> lotnamelist = shipmentService.findLotname(shipId);
                List<String> bookingNo = shipmentService.findbooking(shipId);



                List<String> inspector = shipmentService.inspector();
                for(int i = 0 ; i < inspector.size() ; i++){

                    replacePOI(doc, "inspector",  inspector.get(i));
                }



                if(lotnamelist.size()!=0 && bookingNo.size()!= 0)
                {
                    for(int k = 0 ; k < lotnamelist.size();k++ )
                    {
                        for(int m = 0 ; m < k ; m++)
                        {
                            replacePOI(doc,"lot",   lotnamelist.get(k)  + " & " + lotnamelist.get(m) );

                        }
                    }
                    for(int j = 0 ; j < bookingNo.size() ; j++)
                        {
                            for(int u = 0 ; u < j ; u++){
                                replacePOI(doc,"booking",    lotnamelist.get(1) +"->  "+bookingNo.get(j) + "    " +lotnamelist.get(0) + " -> "+  bookingNo.get(u));
                            }

                        }

                }else {
                    System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"); //TODO
                }

                int sizelotnamelist = lotnamelist.size();
                replacePOI(doc,"ola", String.valueOf(sizelotnamelist));
                replacePOI(doc,"nocont",  shipment.getNoContainer().toString());


//                for(int i = 0 ; i < lotnamelist.size() ; i++ )
//                {
//                    for(int j = 0 ; j < i ; j++){
//                        replacePOI(doc,"lot",   lotnamelist.get(i)  + " & " + lotnamelist.get(j) );
//
//                        String jj = lotnamelist.get(i);
//                        replacePOI(doc,"lone",  jj  );
//                        replacePOI(doc,"ltwo",    lotnamelist.get(j));
//
//                    }
//                }
//                for(int k = 0 ; k < bookingNo.size(); k++)
//                {
//                    for (int s = 0 ; s < k ; s++){
//                        replacePOI(doc,"booking",    bookingNo.get(k) + lotnamelist.get(jj) + "-" +  bookingNo.get(s));
//                    }
//                }






                /*End By Jalal For Lot */
//*****************************************************************************************************************************

                response.setHeader("Content-Disposition", "attachment; filename=\"Molybdenum Oxide.doc\"");
                response.setContentType("application/vnd.ms-word");
                doc.write(out);
                baos.writeTo(out);
                out.flush();

            }
        }

        }

        catch (Exception ex) {
            ex.printStackTrace();
            System.out.println(ex.getMessage());
        }

    }

    //****************************************************************************************************************
    private static XWPFDocument replaceDynamicTable(XWPFDocument doc,ShipmentDTO.Info shipment) throws NumberFormatException, Exception {
        List<XWPFTable> tables = doc.getTables();
        XWPFTable table = tables.get(1);
        for (int r = 0; r < 1; r++) {
            XWPFTableRow tablerow1 = table.createRow();
            List<XWPFTableCell> tableCells1 = tablerow1.getTableCells();
            XWPFParagraph para3 = tableCells1.get(0).getParagraphs().get(0);
            XWPFRun rh3 = para3.createRun();
            rh3.setText(r + "");
            para3 = tableCells1.get(1).getParagraphs().get(0);
            rh3 = para3.createRun();
            rh3.setFontSize(8);
            if (shipment.getContactByAgent() != null)
                rh3.setText(shipment.getContactByAgent().getNameEN().toString());
            else
                rh3.setText("");
        }
        return doc;
    }

    public static XWPFDocument replacePOI(XWPFDocument doc, String placeHolder, String replaceText){
        // REPLACE ALL HEADERS
        for (XWPFHeader header : doc.getHeaderList())
            replaceAllBodyElements(header.getBodyElements(), placeHolder, replaceText);
        // REPLACE BODY
        replaceAllBodyElements(doc.getBodyElements(), placeHolder, replaceText);
        return doc;
    }
    private static void replaceAllBodyElements(List<IBodyElement> bodyElements, String placeHolder, String replaceText){
        for (IBodyElement bodyElement : bodyElements) {
            if (bodyElement.getElementType().compareTo(BodyElementType.PARAGRAPH) == 0)
                replaceParagraph((XWPFParagraph) bodyElement, placeHolder, replaceText);
            if (bodyElement.getElementType().compareTo(BodyElementType.TABLE) == 0)
                replaceTable((XWPFTable) bodyElement, placeHolder, replaceText);
        }
    }

    private static void replaceTable(XWPFTable table, String placeHolder, String replaceText) {
        for (XWPFTableRow row : table.getRows()) {
            for (XWPFTableCell cell : row.getTableCells()) {
                for (IBodyElement bodyElement : cell.getBodyElements()) {
                    if (bodyElement.getElementType().compareTo(BodyElementType.PARAGRAPH) == 0) {
                        replaceParagraph((XWPFParagraph) bodyElement, placeHolder, replaceText);
                    }
                    if (bodyElement.getElementType().compareTo(BodyElementType.TABLE) == 0) {
                        replaceTable((XWPFTable) bodyElement, placeHolder, replaceText);
                    }
                }
            }
        }
    }


    private static void replaceParagraph(XWPFParagraph paragraph, String placeHolder, String replaceText) {
        for (XWPFRun r : paragraph.getRuns()) {
            String text = r.getText(r.getTextPosition());
            if (text != null && text.contains(placeHolder)) {
                text = text.replace(placeHolder, replaceText);
                r.setText(text, 0);
            }
        }
    }


}
