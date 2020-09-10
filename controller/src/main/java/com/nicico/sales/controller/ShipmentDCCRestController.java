package com.nicico.sales.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.core.util.file.FileInfo;
import com.nicico.sales.dto.DCCDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IDCCService;
import com.nicico.sales.iservice.IShipmentDCCService;
import com.nicico.sales.model.entities.base.DCC;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Locale;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/shipmentDcc")
public class ShipmentDCCRestController {

    private final IDCCService dCCService;
    private final IShipmentDCCService shipmentDCCService;
    private final Environment environment;
    private final ResourceBundleMessageSource  messageSource;
    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<DCCDTO.Info> get(@PathVariable Long id) {
        return new ResponseEntity<>(dCCService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<DCCDTO.Info>> list() {
        return new ResponseEntity<>(dCCService.list(), HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<DCCDTO.Info> create(
            @RequestParam("file") MultipartFile file,
            @RequestParam("folder") String folder,
            @RequestParam("data") String data
    ) throws IOException {
        if (file.isEmpty())
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);


            FileInfo fileInfo = new FileInfo();
            File destinationFile;

            String UPLOAD_FILE_DIR = environment.getProperty("nicico.upload.dir");
            String fileName = file.getOriginalFilename();
            Gson gson = new GsonBuilder().setLenient().create();
            DCCDTO.Create dcc = gson.fromJson(data, DCCDTO.Create.class);

            new File(UPLOAD_FILE_DIR + File.separator + folder).mkdirs();
            destinationFile = new File(UPLOAD_FILE_DIR + File.separator + folder + File.separator + fileName);
          //  Long imageNumber = dCCService.findNextImageNumber();
            String ext = getExtensionOfFile(destinationFile.getPath());
            String fileNewName =  dcc.getFileNewName() + "." + ext; //imageNumber.toString() + "-" + System.currentTimeMillis()

            DCC dcc1 = shipmentDCCService.getByFileNewName(fileNewName);
            if(dcc1 != null) {
                Locale locale = LocaleContextHolder.getLocale();
                String message = messageSource.getMessage("exception.invalid-file-name", null, locale);
                throw  new SalesException2(ErrorType.BadRequest,null,message);
            }

            destinationFile = new File(UPLOAD_FILE_DIR + File.separator + folder + File.separator + fileNewName);
            file.transferTo(destinationFile);
            fileInfo.setFileName(destinationFile.getPath());

            //create file new name
            fileInfo.setFileSize(file.getSize());
            dcc.setFileName(file.getOriginalFilename());
            dcc.setFileNewName(fileNewName);
            return new ResponseEntity<>(dCCService.create(dcc), HttpStatus.CREATED);


    }

    private String getExtensionOfFile(String fileName) {
        int i = fileName.lastIndexOf(".");
        if (i >= 0)
            return fileName.substring(i + 1);
        else
            return "";
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        DCCDTO.Info dccdto = dCCService.get(id);
        dCCService.delete(id);
        //move file to deleted folder
        String UPLOAD_FILE_DIR = environment.getProperty("nicico.upload.dir");
        String folder = UPLOAD_FILE_DIR + File.separator + dccdto.getTblName1().toLowerCase().split("tbl_")[1];
        File file = new File(folder + File.separator + dccdto.getFileNewName());
        new File(folder + File.separator + "deleted").mkdirs();
        File movedFile = new File(folder + File.separator + "deleted" + File.separator + dccdto.getFileNewName());
        file.renameTo(movedFile);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody DCCDTO.Delete request) {
        dCCService.deleteAll(request);
        return new ResponseEntity(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<DCCDTO.Info>> list(@RequestParam MultiValueMap<String, String> criteria) throws IOException {
        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(dCCService.search(nicicoCriteria), HttpStatus.OK);
    }
}
