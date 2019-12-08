package com.nicico.sales.web.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.util.report.ReportUtil;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JRException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/warehouseStock")
public class WarehouseStockFormController {

    private final ReportUtil reportUtil;

    @RequestMapping("/showForm")
    public String showWarehouseStock() {
        return "base/warehouseStock";
    }

	//---------------------------------------------------------------
	@Loggable
	@GetMapping(value = {"/print/{type}/{date}"})
	public void print(HttpServletResponse response, @PathVariable String type, @PathVariable("date") String date)
			throws SQLException, IOException, JRException {
		String day = date.substring(0, 4) + "/" + date.substring(4, 6) + "/" + date.substring(6, 8);
		Map<String, Object> params = new HashMap<>();
		params.put("dateReport", day);
		params.put(ConstantVARs.REPORT_TYPE, type);
		reportUtil.export("/reports/warehouse.jasper", params, response);
	}
}
