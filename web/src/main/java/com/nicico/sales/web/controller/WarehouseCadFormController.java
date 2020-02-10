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
import java.io.IOException;
import java.io.InputStream;

import static com.nicico.sales.web.controller.ShipmentFormController.replacePOI;

@RequiredArgsConstructor
@Controller
@RequestMapping("/warehouseCad")
public class WarehouseCadFormController {

    private final IWarehouseCadService warehouseCadService;

    @RequestMapping("/showForm")
    public String showWarehouseCad() {
        return "product/warehouseCad";
    }

    @RequestMapping("/showWarehouseCadForm")
    public String showWarehouseCadForm() {
        return "product/warehouseCad_Bijack";
    }

    @RequestMapping("/showWarehouseMoForm")
    public String showWarehouseMoForm() {
        return "product/warehouseMo_Bijack";
    }

    @RequestMapping("/showWarehouseConcForm")
    public String showWarehouseConcForm() {
        return "product/warehouseConc_Bijack";
    }
}
