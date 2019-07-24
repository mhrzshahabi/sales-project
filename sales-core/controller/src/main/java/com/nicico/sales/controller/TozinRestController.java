package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.dto.search.EOperator;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.TozinDTO;
import com.nicico.sales.iservice.ITozinService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jasperreports.engine.JRException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/tozin")
public class TozinRestController {

	private final ObjectMapper objectMapper;
	private final ITozinService tozinService;
	private final ReportUtil reportUtil;

	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('r_tozin')")
	public ResponseEntity<TozinDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(tozinService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//    @PreAuthorize("hasAuthority('r_tozin')")
	public ResponseEntity<List<TozinDTO.Info>> list() {
		return new ResponseEntity<>(tozinService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//    @PreAuthorize("hasAuthority('c_tozin')")
	public ResponseEntity<TozinDTO.Info> create(@Validated @RequestBody TozinDTO.Create request) {
		return new ResponseEntity<>(tozinService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//    @PreAuthorize("hasAuthority('u_tozin')")
	public ResponseEntity<TozinDTO.Info> update(@RequestBody TozinDTO.Update request) {
		return new ResponseEntity<>(tozinService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('d_tozin')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		tozinService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//    @PreAuthorize("hasAuthority('d_tozin')")
	public ResponseEntity<Void> delete(@Validated @RequestBody TozinDTO.Delete request) {
		tozinService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//    @PreAuthorize("hasAuthority('r_tozin')")
	public ResponseEntity<TozinDTO.TozinSpecRs> list(@RequestParam("_startRow") Integer startRow,
													 @RequestParam("_endRow") Integer endRow,
													 @RequestParam(value = "_constructor", required = false) String constructor,
													 @RequestParam(value = "operator", required = false) String operator,
													 @RequestParam(value = "_sortBy", required = false) String sortBy,
													 @RequestParam(value = "criteria", required = false) String criteria) throws IOException {
		SearchDTO.SearchRq request = new SearchDTO.SearchRq();
		SearchDTO.CriteriaRq criteriaRq;
		if (StringUtils.isNotEmpty(constructor) && constructor.equals("AdvancedCriteria")) {
			criteria = "[" + criteria + "]";
			criteriaRq = new SearchDTO.CriteriaRq();
			criteriaRq.setOperator(EOperator.valueOf(operator))
					.setCriteria(objectMapper.readValue(criteria, new TypeReference<List<SearchDTO.CriteriaRq>>() {
					}));

			if (StringUtils.isNotEmpty(sortBy)) {
				request.set_sortBy(sortBy);
			}

			request.setCriteria(criteriaRq);
		}

		request.setStartIndex(startRow)
				.setCount(endRow - startRow);

		SearchDTO.SearchRs<TozinDTO.Info> response = tozinService.search(request);

		final TozinDTO.SpecRs specResponse = new TozinDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final TozinDTO.TozinSpecRs specRs = new TozinDTO.TozinSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/showTransport2Plants/{date}")
//    @PreAuthorize("hasAuthority('r_tozin')")
	public ResponseEntity<String> list(@PathVariable("date") String date) throws IOException {
		String[] plants = tozinService.findPlants();
		String day = date.substring(0, 4) + "/" + date.substring(4, 6) + "/" + date.substring(6, 8);
		String out = "";

		for (int i = 0; i < plants.length; i++) {
			String[] plantId = plants[i].split(",");
			out += "<table width='100%' align='center'  border='1' cellspacing='1' cellpadding='1'> <tbody><tr><td><b>" + plantId[1] + "</b></td> </tr> ";
			out += "<tr> . </tr><tr> </tr><tr><th>مبدا</th><th>مقصد</th><th>محصول</th><th>حمل</th><th>تناژ</th><th>تعداد</th></tr>";
			List<Object[]> list = tozinService.findTransport2Plants(day, plantId[0]);
			for (Object[] aa : list) {
				out += "<tr>";
				for (Object s : aa) {
					out += "<td>" + s.toString() + "</td>";
				}
			}
			out += "</tr></table>";
		}
//        out += "</table>";
		return new ResponseEntity<>(out, HttpStatus.OK);
	}
	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//    @PreAuthorize("hasAuthority('r_tozin')")
	public ResponseEntity<SearchDTO.SearchRs<TozinDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(tozinService.search(request), HttpStatus.OK);
	}
	//---------------------------------------------------------------
	@Loggable
	@GetMapping(value = {"/print/{type}/{date}"})
	public void print(HttpServletResponse response, @PathVariable String type, @PathVariable("date") String date) throws SQLException, IOException, JRException {
		String day = date.substring(0, 4) + "/" + date.substring(4, 6) + "/" + date.substring(6, 8);
		Map<String, Object> params = new HashMap<>();
		params.put("dateReport", day);
		params.put(ConstantVARs.REPORT_TYPE, type);
		reportUtil.export("/reports/tozin_m1.jasper", params, response);
	}

}
