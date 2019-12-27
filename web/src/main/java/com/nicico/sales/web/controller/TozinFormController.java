package com.nicico.sales.web.controller;

import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.util.report.ReportUtil;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JRException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/tozin")
public class TozinFormController {
    private final ReportUtil reportUtil;

    @Value("${nicico.rest-api.url:''}")
    private String restApiUrl;

    @RequestMapping("/showForm")
    public String showTozin() {
        return "product/tozin";
    }

    @RequestMapping("/showOnWayProductForm")
    public String showOnWayProductForm() {
        return "product/onWayProduct";
    }

    @RequestMapping("/showWarehouseCadForm")
    public String showWarehouseCadForm() {
        return "base/warehouseCad_OnWayProduct";
    }

    @RequestMapping("/showWarehouseMoForm")
    public String showWarehouseMoForm() {
        return "base/warehouseMo_OnWayProduct";
    }

    @RequestMapping("/showWarehouseConcForm")
    public String showWarehouseConcForm() {
        return "base/warehouseConc_OnWayProduct";
    }

    @RequestMapping(value = {"/showTransport2Plants/{date}"})
    public String showTransport2Plants(HttpServletRequest req, @PathVariable String date, @RequestParam("Authorization") String auth) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", auth);
        HttpEntity<String> request = new HttpEntity<String>(headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> modelMapFromRest = restTemplate.exchange(restApiUrl + "/api/tozin/showTransport2Plants/" + date, HttpMethod.GET, request, String.class);

        String out = modelMapFromRest.getBody();
        req.setAttribute("out", out);
        return "base/tozinTransport2Plants";
    }

    @RequestMapping("/print/{type}/{date}")
    public ResponseEntity<?> print(HttpServletResponse response, Authentication authentication, @PathVariable String type, @PathVariable String date)
            throws SQLException, IOException, JRException {

        String day = date.substring(0, 4) + "/" + date.substring(4, 6) + "/" + date.substring(6, 8);
        Map<String, Object> params = new HashMap<>();
        params.put("dateReport", day);
        params.put(ConstantVARs.REPORT_TYPE, type);
        reportUtil.export("/reports/tozin_beyn_mojtama.jasper", params, response);
        return null;
    }
}
