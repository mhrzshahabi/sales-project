package com.nicico.sales.web.controller;

import com.nicico.sales.dto.WarehouseCadDTO;
import com.nicico.sales.iservice.IWarehouseCadService;
import lombok.RequiredArgsConstructor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;

import static com.nicico.sales.web.controller.ShipmentFormController.replacePOI;

@RequiredArgsConstructor
@Controller
@RequestMapping("/warehouseCad")
public class WarehouseCadFormController {

    private final IWarehouseCadService warehouseCadService;

    @RequestMapping("/showForm")
    public String showWarehouseCad() {
        return "base/warehouseCad";
    }

    @RequestMapping("/showWarehouseCadForm")
    public String showWarehouseCadForm() {
        return "base/warehouseCad_Bijack";
    }

    @RequestMapping("/showWarehouseMoForm")
    public String showWarehouseMoForm() {
        return "base/warehouseMo_Bijack";
    }

    @RequestMapping("/showWarehouseConcForm")
    public String showWarehouseConcForm() {
        return "base/warehouseConc_Bijack";
    }

    @RequestMapping("/print/{id}")
    public void printDocx(HttpServletRequest request, HttpServletResponse response, @PathVariable String id) {

        InputStream stream;


        try {
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFFont font = workbook.createFont();
            font.setFontName("B Nazanin");
            XWPFDocument doc;

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            WarehouseCadDTO.Info warehouseCad = warehouseCadService.get(Long.valueOf(id));

            stream = new ClassPathResource("bijack.docx").getInputStream();
            ServletOutputStream out = response.getOutputStream();
            doc = new XWPFDocument(stream);

            replacePOI(doc, "containerNo", warehouseCad.getContainerNo());
            replacePOI(doc, "sourceLoadDate", warehouseCad.getSourceLoadDate());
            replacePOI(doc, "herasatPolompNo", warehouseCad.getHerasatPolompNo());
            replacePOI(doc, "sourceSheetSum", warehouseCad.getSourceSheetSum().toString());
            replacePOI(doc, "sourceBundleSum", warehouseCad.getSourceBundleSum().toString());
            replacePOI(doc, "destinationSheetSum", warehouseCad.getDestinationSheetSum().toString());
            replacePOI(doc, "destinationBundleSum", warehouseCad.getDestinationBundleSum().toString());

            response.setHeader("Content-Disposition", "attachment; filename=\"bijack.doc\"");
            response.setContentType("application/vnd.ms-word");
            doc.write(out);
            baos.writeTo(out);
            out.flush();

        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println(ex.getMessage());
        }

    }
}
