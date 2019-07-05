package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.nicico.copper.core.dto.search.EOperator;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.copper.core.util.file.FileInfo;
import com.nicico.sales.dto.DCCDTO;
import com.nicico.sales.iservice.IDCCService;
import com.nicico.sales.service.ContactAttachmentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/dcc")
public class DCCRestController {

	private final IDCCService dCCService;
	private final Environment environment;
	private final ContactAttachmentService contactAttachmentService;
	private final ObjectMapper objectMapper;
	// ------------------------------s

	@Loggable
	@GetMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('r_dcc')")
	public ResponseEntity<DCCDTO.Info> get(@PathVariable Long id) {
		return new ResponseEntity<>(dCCService.get(id), HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/list")
//    @PreAuthorize("hasAuthority('r_dcc')")
	public ResponseEntity<List<DCCDTO.Info>> list() {
		return new ResponseEntity<>(dCCService.list(), HttpStatus.OK);
	}

	@Loggable
	@PostMapping
//    @PreAuthorize("hasAuthority('c_dcc')")
	public ResponseEntity<DCCDTO.Info> create(@Validated @RequestBody DCCDTO.Create request) {
		return new ResponseEntity<>(dCCService.create(request), HttpStatus.CREATED);
	}

	@Loggable
	@PutMapping
//    @PreAuthorize("hasAuthority('u_dcc')")
	public ResponseEntity<DCCDTO.Info> update(@RequestBody DCCDTO.Update request) {
		return new ResponseEntity<>(dCCService.update(request.getId(), request), HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/{id}")
//    @PreAuthorize("hasAuthority('d_dcc')")
	public ResponseEntity<Void> delete(@PathVariable Long id) {
		dCCService.delete(id);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@DeleteMapping(value = "/list")
//    @PreAuthorize("hasAuthority('d_dcc')")
	public ResponseEntity<Void> delete(@Validated @RequestBody DCCDTO.Delete request) {
		dCCService.delete(request);
		return new ResponseEntity(HttpStatus.OK);
	}

	@Loggable
	@GetMapping(value = "/spec-list")
//    @PreAuthorize("hasAuthority('r_dcc')")
	public ResponseEntity<DCCDTO.DCCSpecRs> list(@RequestParam("_startRow") Integer startRow,
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
				criteriaRq.set_sortBy(sortBy);
			}

			request.setCriteria(criteriaRq);
		}

		request.setStartIndex(startRow)
				.setCount(endRow - startRow);
		SearchDTO.SearchRs<DCCDTO.Info> response = dCCService.search(request);

		final DCCDTO.SpecRs specResponse = new DCCDTO.SpecRs();
		specResponse.setData(response.getList())
				.setStartRow(startRow)
				.setEndRow(startRow + response.getTotalCount().intValue())
				.setTotalRows(response.getTotalCount().intValue());

		final DCCDTO.DCCSpecRs specRs = new DCCDTO.DCCSpecRs();
		specRs.setResponse(specResponse);

		return new ResponseEntity<>(specRs, HttpStatus.OK);
	}

	// ------------------------------

	@Loggable
	@GetMapping(value = "/search")
//    @PreAuthorize("hasAuthority('r_dcc')")
	public ResponseEntity<SearchDTO.SearchRs<DCCDTO.Info>> search(@RequestBody SearchDTO.SearchRq request) {
		return new ResponseEntity<>(dCCService.search(request), HttpStatus.OK);
	}

	@PostMapping(value = "/add")
	public String uploadProcessDefinition(
			@RequestParam("file") MultipartFile file,
			@RequestParam("folder") String folder,
			@RequestParam("data") String data,
			final HttpServletRequest request) {
		FileInfo fileInfo = new FileInfo();
		File destinationFile;
		String UPLOAD_FILE_DIR = environment.getProperty("system.upload.dir");
		try {
//            UtilsFunction utilsFunction = new UtilsFunction();
			if (!file.isEmpty()) {
				try {
//                    Long userId = new Long(request.getSession().getAttribute("userId").toString());
					String fileName = file.getOriginalFilename();

					destinationFile = new File(UPLOAD_FILE_DIR + File.separator + "\\" + folder + "\\" + fileName);
					Long imageNumber = contactAttachmentService.findNextImageNumber();
//                    String ext = utilsFunction.getExtensionOfFile(destinationFile.getPath());
					String ext = getExtensionOfFile(destinationFile.getPath());
					String fileNewName = imageNumber.toString() + "-" + System.currentTimeMillis() + "." + ext;
					destinationFile = new File(UPLOAD_FILE_DIR + "\\" + folder + "\\" + File.separator + fileNewName);
					file.transferTo(destinationFile);
					fileInfo.setFileName(destinationFile.getPath());

					//create file new name
					fileInfo.setFileSize(file.getSize());
					Gson gson = new GsonBuilder().setLenient().create();

					DCCDTO.Create dcc = gson.fromJson(data, DCCDTO.Create.class);
					dcc.setFileName(file.getOriginalFilename());
					dcc.setFileNewName(fileNewName);
//                    dcc.setCreateUser(userId);
					dCCService.create(dcc);

					return "success";
				} catch (Exception e) {
					return "error";
				}
			} else {
				return "error";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			return "error";
		}
	}

	private String getExtensionOfFile(String fileName) {
		int i = fileName.lastIndexOf(".");
		if (i >= 0)
			return fileName.substring(i + 1);
		else
			return "";
	}
}
