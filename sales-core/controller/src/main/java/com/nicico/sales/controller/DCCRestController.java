package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.nicico.copper.core.dto.search.EOperator;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.copper.core.util.Loggable;
import com.nicico.copper.core.util.file.FileInfo;
import com.nicico.copper.core.util.file.FileUtil;
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

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
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
    private final FileUtil fileUtil;
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
    public ResponseEntity<DCCDTO.Info> createOrUpdate(
            @RequestParam("file") MultipartFile file,
            @RequestParam("folder") String folder,
            @RequestParam("data") String data
    ) {
        if (file.isEmpty())
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

        try {
            FileInfo fileInfo = new FileInfo();
            File destinationFile;
            String UPLOAD_FILE_DIR = environment.getProperty("system.upload.dir");

            String fileName = file.getOriginalFilename();

            destinationFile = new File(UPLOAD_FILE_DIR + File.separator + "\\" + folder + "\\" + fileName);
            Long imageNumber = contactAttachmentService.findNextImageNumber();
            String ext = getExtensionOfFile(destinationFile.getPath());
            String fileNewName = imageNumber.toString() + "-" + System.currentTimeMillis() + "." + ext;
            destinationFile = new File(UPLOAD_FILE_DIR + "\\" + folder + "\\" + File.separator + fileNewName);
            file.transferTo(destinationFile);
            fileInfo.setFileName(destinationFile.getPath());

            //create file new name
            fileInfo.setFileSize(file.getSize());
            Gson gson = new GsonBuilder().setLenient().create();

            if (data.contains("id")) {
                DCCDTO.Update dcc = gson.fromJson(data, DCCDTO.Update.class);
                dcc.setFileName(file.getOriginalFilename());
                dcc.setFileNewName(fileNewName);
                return new ResponseEntity<>(dCCService.update(dcc.getId(), dcc), HttpStatus.OK);

            } else {
                DCCDTO.Create dcc = gson.fromJson(data, DCCDTO.Create.class);
                dcc.setFileName(file.getOriginalFilename());
                dcc.setFileNewName(fileNewName);
                return new ResponseEntity<>(dCCService.create(dcc), HttpStatus.CREATED);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
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

    @Loggable
    @GetMapping(value = "/downloadFile")
//    @PreAuthorize("hasAuthority('r_dcc')")
    public void downloadFile(@RequestParam String data, HttpServletRequest request, HttpServletResponse response) {
        try {
            String filePath;
            filePath = "C:\\" + "upload" + "\\" + data;
            File downloadFile = new File(filePath);
            FileInputStream inputStream = new FileInputStream(downloadFile);

            ServletContext context = request.getServletContext();
            String mimeType = context.getMimeType(filePath);
            if (mimeType == null) {
                mimeType = "application/octet-stream";
            }
            response.setContentType(mimeType);
            String headerKey = "Content-Disposition";
            String headerValue = String.format("attachment; filename=\"%s\"", data);
            response.setHeader(headerKey, headerValue);
            response.setContentLength((int) downloadFile.length());
            OutputStream outputStream = response.getOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }

            outputStream.flush();
            inputStream.close();
            fileUtil.download(data, response);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
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
