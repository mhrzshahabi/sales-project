package com.nicico.sales.controller;

import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.pdf.*;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.util.date.DateUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.ContractIncomeCostDTO;
import com.nicico.sales.iservice.IContractIncomeCostService;
import com.nicico.sales.model.entities.base.ContractIncomeCost;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.JRException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/contractIncomeCost")
public class ContractIncomeCostRestController {

    private final IContractIncomeCostService contractIncomeCostService;
    private final ReportUtil reportUtil;

    // ------------------------------s

    @Loggable
    @GetMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('r_contractIncomeCost')")
    public ResponseEntity<ContractIncomeCostDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(contractIncomeCostService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
//    @PreAuthorize("hasAuthority('r_contractIncomeCost')")
    public ResponseEntity<List<ContractIncomeCostDTO.Info>> list() {
        return new ResponseEntity<>(contractIncomeCostService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
//    @PreAuthorize("hasAuthority('c_contractIncomeCost')")
    public ResponseEntity<ContractIncomeCostDTO.Info> create(@Validated @RequestBody ContractIncomeCostDTO.Create request) {
        return new ResponseEntity<>(contractIncomeCostService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
//    @PreAuthorize("hasAuthority('u_contractIncomeCost')")
    public ResponseEntity<ContractIncomeCostDTO.Info> update(@RequestBody ContractIncomeCostDTO.Update request) {
        return new ResponseEntity<>(contractIncomeCostService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('d_contractIncomeCost')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        contractIncomeCostService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
//    @PreAuthorize("hasAuthority('d_contractIncomeCost')")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractIncomeCostDTO.Delete request) {
        contractIncomeCostService.delete(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
//    @PreAuthorize("hasAuthority('r_contractIncomeCost')")
    public ResponseEntity<ContractIncomeCostDTO.ContractIncomeCostSpecRs> list(
            @RequestParam("_startRow") Integer startRow,
            @RequestParam("_endRow") Integer endRow,
            @RequestParam(value = "operator", required = false) String operator,
            @RequestParam(value = "criteria", required = false) String criteria
    ) {
        SearchDTO.SearchRq request = new SearchDTO.SearchRq();
        request.setStartIndex(startRow)
                .setCount(endRow - startRow);

        SearchDTO.SearchRs<ContractIncomeCostDTO.Info> response = contractIncomeCostService.search(request);

        final ContractIncomeCostDTO.SpecRs specResponse = new ContractIncomeCostDTO.SpecRs();
        specResponse.setData(response.getList())
                .setStartRow(startRow)
                .setEndRow(startRow + response.getTotalCount().intValue())
                .setTotalRows(response.getTotalCount().intValue());

        final ContractIncomeCostDTO.ContractIncomeCostSpecRs specRs = new ContractIncomeCostDTO.ContractIncomeCostSpecRs();
        specRs.setResponse(specResponse);

        return new ResponseEntity<>(specRs, HttpStatus.OK);
    }

    // ------------------------------

    @Loggable
    @GetMapping(value = "/search")
//    @PreAuthorize("hasAuthority('r_contractIncomeCost')")
    public ResponseEntity<SearchDTO.SearchRs<ContractIncomeCostDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
        return new ResponseEntity<>(contractIncomeCostService.search(request), HttpStatus.OK);
    }
//---------------------------------------------------------------
    private Long count = new Long(1);
    PdfTemplate total;
    private final ServletContext context;

    @Loggable
    @GetMapping("/print")
    public ResponseEntity<?> print(HttpServletResponse response) {


        try {
            List<ContractIncomeCostDTO.Info> myList=contractIncomeCostService.list();

            count = new Long(1);

            ServletOutputStream out = response.getOutputStream();

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            baos = pdfFx(myList);

            response.setContentType("application/pdf");
            response.setContentLength(baos.size());
            baos.writeTo(out);
            out.flush();

        } catch (RemoteException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;


    }

    private ByteArrayOutputStream pdfFx(List<ContractIncomeCostDTO.Info> myList) {
        Document document = new Document(PageSize.A4, 10, 10, 80, 170);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            PdfWriter writer = PdfWriter.getInstance(document, baos);
            TableHeader event = new TableHeader();
            writer.setPageEvent(event);
            document.open();

            BaseFont bf = BaseFont.createFont("reports/fonts/karnik.ttf", BaseFont.IDENTITY_H, true);
            BaseFont bfk = BaseFont.createFont("reports/fonts/titr_pdf.ttf", BaseFont.IDENTITY_H, true);

            Font f1 = new Font(bf, 8, Font.BOLD, Color.BLACK);
            Font f25 = new Font(bf, 14, Font.BOLD, Color.BLACK);
            Font f2 = new Font(bfk, 18, Font.BOLD, Color.BLACK);
            Font f7 = new Font(bf, 12, Font.NORMAL, Color.BLACK);

            Map<String, Field> fieldMap = new HashMap<>();
            Field[] InfoFields = ContractIncomeCostDTO.Info.class.getDeclaredFields();
            for(Field field : InfoFields) {
                field.setAccessible(true);
                fieldMap.put(field.getName(), field);
            }
            Field[] InfoSuperClassFields = ContractIncomeCostDTO.Info.class.getSuperclass().getDeclaredFields();
            for(Field field : InfoSuperClassFields) {
                field.setAccessible(true);
                fieldMap.put(field.getName(), field);
            }

            // Start Header Images
            PdfPCell cell = new PdfPCell();
            cell.setPadding(4);
            cell.setBorderWidth(0);
            cell.setPaddingBottom(2);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);

            //Start Definition for desc
            PdfPTable definitions = new PdfPTable(8);
            definitions.setWidthPercentage(90);
            definitions.setSpacingAfter(20f);
            definitions.setRunDirection(PdfWriter.RUN_DIRECTION_RTL);
            definitions.setSplitLate(true);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setPadding(4);
            cell.setBorderWidth(0);
            cell.setPaddingBottom(6);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);

            cell.setPhrase(new Phrase(10, "شماره درخواست:" + fieldMap.get("contractNo").get(myList.get(0)), f7));
            cell.setColspan(2);
            cell.setBorderWidthTop(1);
            cell.setBorderWidthLeft(1);
            cell.setBorderWidthRight(1);
            cell.setBorderWidthBottom(0);
            definitions.addCell(cell);

            cell.setPhrase(new Phrase(10, "آيتم:" + myList.get(0).getCustomerFullNameEn(), f7));
            cell.setColspan(2);
            cell.setBorderWidthTop(1);
            cell.setBorderWidthLeft(1);
            cell.setBorderWidthRight(1);
            cell.setBorderWidthBottom(0);
            definitions.addCell(cell);

            cell.setPhrase(new Phrase(10, "تعداد کل درخواست:" , f7));
            cell.setColspan(2);
            cell.setBorderWidthTop(1);
            cell.setBorderWidthLeft(1);
            cell.setBorderWidthRight(1);
            cell.setBorderWidthBottom(0);
            definitions.addCell(cell);

            cell.setPhrase(new Phrase(10, "شماره استاک:" , f7));
            cell.setColspan(2);
            cell.setBorderWidthTop(1);
            cell.setBorderWidthLeft(1);
            cell.setBorderWidthRight(1);
            cell.setBorderWidthBottom(0);
            definitions.addCell(cell);

            cell.setPhrase(new Phrase(10, "شرح کالا:", f7));
            cell.setColspan(8);
            cell.setBorderWidthTop(1);
            cell.setBorderWidthLeft(1);
            cell.setBorderWidthRight(1);
            cell.setBorderWidthBottom(0);
            definitions.addCell(cell);

            cell.setPhrase(new Phrase(10, "تعداد بازرسي شده:" , f7));
            cell.setColspan(2);
            cell.setBorderWidthTop(1);
            cell.setBorderWidthLeft(1);
            cell.setBorderWidthRight(1);
            cell.setBorderWidthBottom(0);
            definitions.addCell(cell);

            definitions.setSpacingAfter(20f);
            //Start Definition for desc
            PdfPTable certificate = new PdfPTable(8);
            certificate.setWidthPercentage(90);
            certificate.setRunDirection(PdfWriter.RUN_DIRECTION_RTL);
            certificate.setSplitLate(true);
            certificate.setSpacingAfter(20f);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setPadding(4);
            cell.setBorderWidth(0);
            cell.setPaddingBottom(6);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            //********************************************************tblCertificate************************************************************
            //  if(tblCertificate != null && tblCertificate.length > 0)
            for (int i = 0; i < myList.size(); i++) {
                cell.setPhrase(new Phrase(10, "شماره رديف :" + count++, f7));
                cell.setColspan(2);
                cell.setBorderWidthTop(1);
                cell.setBorderWidthLeft(1);
                cell.setBorderWidthRight(1);
                cell.setBorderWidthBottom(0);
                certificate.addCell(cell);

                cell.setPhrase(new Phrase(10, "شرح"+myList.get(i).getMonth(), f7));
                cell.setColspan(6);
                cell.setBorderWidthTop(1);
                cell.setBorderWidthLeft(1);
                cell.setBorderWidthRight(1);
                cell.setBorderWidthBottom(0);
                certificate.addCell(cell);

                }

            document.add(definitions);
            document.add(certificate);
            document.close();

        } catch (Exception de) {
            de.printStackTrace();
        }
        return baos;
    }

    class TableHeader extends PdfPageEventHelper {

        PdfTemplate total;

        public void onOpenDocument(PdfWriter writer, Document document) {
            total = writer.getDirectContent().createTemplate(30, 16);
        }

        public void onStartPage(PdfWriter writer, Document document) {
            try {
                BaseFont bfk = BaseFont.createFont("reports/fonts/titr_pdf.ttf", BaseFont.IDENTITY_H, true);

                Font f2 = new Font(bfk, 18, Font.BOLD, Color.BLACK);

                PdfPTable headerTable = new PdfPTable(3);
                headerTable.setRunDirection(PdfWriter.RUN_DIRECTION_RTL);
                PdfPCell cell = new PdfPCell();
                cell.setPadding(4);
                cell.setBorderWidth(0);
                cell.setPaddingBottom(2);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);

                String file = "reports/image/arm.gif";
                com.lowagie.text.Image image = com.lowagie.text.Image.getInstance(file);
                image.scalePercent(15);
                Chunk chk = new Chunk(image, 0, 0);
                cell.setPhrase(new Phrase(chk));
                headerTable.addCell(cell);

                cell.setPhrase(new Phrase(10, "گزارش کنترل کيفيت", f2));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                headerTable.addCell(cell);

                String file2 = "reports/image/arm.gif";
                com.lowagie.text.Image image2 = com.lowagie.text.Image.getInstance(file2);
                image2.scalePercent(15);
                Chunk chk2 = new Chunk(image2, 0, 0);
                cell.setPhrase(new Phrase(chk2));
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                headerTable.addCell(cell);

                headerTable.setTotalWidth(500);
                headerTable.writeSelectedRows(0, 10, 40, 820,
                        writer.getDirectContent());


            } catch (Exception de) {
                throw new ExceptionConverter(de);
            }
        }

        public void onEndPage(PdfWriter writer, Document document) {
            try {
                BaseFont bfk = BaseFont.createFont("reports/fonts/BNAZANIN.ttf", BaseFont.IDENTITY_H, true);

                Font f2 = new Font(bfk, 10, Font.NORMAL, Color.BLACK);

                PdfPTable headerTable = new PdfPTable(6);
                headerTable.setRunDirection(PdfWriter.RUN_DIRECTION_RTL);
                PdfPCell cell = new PdfPCell();
                cell.setBorderWidth(0);
                com.lowagie.text.Image image12 = null;
                Chunk chk12 = null;
                cell.setColspan(1);
                if (chk12 != null) {

                    cell.setPhrase(new Phrase(chk12));
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    cell.setColspan(1);
                    cell.setBorderWidthTop(0);
                    cell.setBorderWidthBottom(0);
                    cell.setBorderWidthLeft(0);
                    cell.setBorderWidthRight(0);
                    headerTable.addCell(cell);

                } else {
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    cell.setPhrase(new Phrase(10, "", f2));
                    cell.setColspan(1);
                    cell.setBorderWidthTop(0);
                    cell.setBorderWidthBottom(0);
                    cell.setBorderWidthLeft(0);
                    cell.setBorderWidthRight(0);
                    headerTable.addCell(cell);
                }
                com.lowagie.text.Image image1 = null;
                Chunk chk1 = null;
                chk1 = null;


                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                cell.setPhrase(new Phrase(10, " ", f2));
                cell.setColspan(6);
                cell.setBorderWidthTop(0);
                cell.setBorderWidthBottom(0);
                cell.setBorderWidthLeft(0);
                cell.setBorderWidthRight(0);
                headerTable.addCell(cell);

                cell.setColspan(2);
                cell.setBorderWidthTop(1);

                cell.setPhrase(new Phrase(10, "قراردادها", f2));
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                headerTable.addCell(cell);
                cell.setPhrase(new Phrase(10, "" + document.getPageNumber(), f2));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                headerTable.addCell(cell);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                cell.setPhrase(new Phrase(10, "", f2)); //F-47-30/02
                cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                headerTable.addCell(cell);

                headerTable.setTotalWidth(515);
                headerTable.writeSelectedRows(0, 10, 40, 150, writer.getDirectContent());

            } catch (Exception de) {
                throw new ExceptionConverter(de);
            }
        }

        public void onCloseDocument(PdfWriter writer, Document document) {
            ColumnText.showTextAligned(total, Element.ALIGN_LEFT, new Phrase(
                    String.valueOf(writer.getPageNumber() - 1)), 2, 2, 0);
        }
    }

    private String RTL2LTR(String in) {
        return RTL2LTR(in, "/");
    }

    private String RTL2LTR(String in, String d) {
        ArrayList a = new ArrayList();
        String result = "";
        while (in.indexOf(d) > -1) {
            a.add(in.substring(0, in.indexOf(d)));
            in = in.substring(in.indexOf(d) + 1);
        }
        a.add(in);
        String[] strs = (String[]) a.toArray(new String[a.size()]);
        for (int i = strs.length - 1; i > 0; i--) {
            result += strs[i] + d;
        }

        result += strs[0];
        return result;
    }
}
