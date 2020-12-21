package com.nicico.sales.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.dto.FileDTO;
import com.nicico.sales.service.FileService;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.*;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/files")
public class FileRestController {

    private final FileService fileService;
    private final ObjectMapper objectMapper;

    @PostMapping
    public ResponseEntity<String> Store(@Validated @ApiParam FileDTO.Request request) throws Exception {
        return new ResponseEntity<>(fileService.store(request), HttpStatus.OK);
    }

    @GetMapping
    public ResponseEntity<List<FileDTO.FileMetaData>> getFiles(@RequestParam Long recordId, @RequestParam String entityName) {
        return new ResponseEntity<>(fileService.getFiles(recordId, entityName), HttpStatus.OK);
    }

    @GetMapping(value = "/byEntityName")
    public ResponseEntity<List<FileDTO.FileMetaData>> getFiles(@RequestParam String entityName) {
        return new ResponseEntity<>(fileService.getFiles(entityName), HttpStatus.OK);
    }

    @PutMapping(value = "/updateAll")
    public ResponseEntity<Void> updateAllFiles(@RequestParam List<MultipartFile> files, @RequestParam String entityName, @RequestParam String fileMetaData) throws Exception {
        List<FileDTO.FileData> fileDataList = objectMapper.readValue(fileMetaData, new TypeReference<List<FileDTO.FileData>>() {
        });
        int index = 0;
        Map<Long, List<MultipartFile>> recordToFilesListMap = new HashMap<>();
        Map<Long, List<FileDTO.FileData>> recordToFileMetaDataMap = new HashMap<>();
        for (FileDTO.FileData fileData : fileDataList) {
            Long recordId = fileData.getRecordId();
            List<MultipartFile> l1 = recordToFilesListMap.get(recordId);
            List<FileDTO.FileData> l2 = recordToFileMetaDataMap.get(recordId);
            if (l1 == null) {
                l1 = new ArrayList<>();
                recordToFilesListMap.put(recordId, l1);
            }
            if (l2 == null) {
                l2 = new ArrayList<>();
                recordToFileMetaDataMap.put(recordId, l2);
            }
            if (!fileDataList.get(index).getEntityName().equals("DELETED")) {
                l1.add(files.get(index));
                l2.add(fileDataList.get(index));
            }
            index++;
        }
        for (Long recordId : recordToFileMetaDataMap.keySet()) {
            fileService.updateFiles(recordId, entityName, recordToFilesListMap.get(recordId), recordToFileMetaDataMap.get(recordId));
        }
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PutMapping(value = "/update")
    public ResponseEntity<Void> updateFiles(@RequestParam List<MultipartFile> files, @RequestParam String entityName, @RequestParam Long recordId, @RequestParam String fileMetaData) throws Exception {
        List<FileDTO.FileData> fileData = objectMapper.readValue(fileMetaData, new TypeReference<List<FileDTO.FileData>>() {
        });
        fileService.updateFiles(recordId, entityName, files, fileData);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping(value = "/{key}")
    public ResponseEntity<Resource> retrieve(@PathVariable String key) throws Exception {
        final FileDTO.Response response = fileService.retrieve(key);

        final HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentDisposition(ContentDisposition.parse("attachment; filename=\"" + response.getFileName() + "." + response.getExtension() + "\""));

        final ByteArrayResource resource = new ByteArrayResource(response.getContent());

        return ResponseEntity.ok()
                .headers(httpHeaders)
                .contentLength(response.getContent().length)
                .contentType(MediaType.valueOf(response.getContentType()))
                .body(resource);
    }

    @DeleteMapping(value = "/{key}")
    public ResponseEntity<Void> delete(@PathVariable String key) throws Exception {
        fileService.delete(key);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PutMapping(value = "/{key}")
    public ResponseEntity<Void> restore(@PathVariable String key) throws Exception {
        fileService.restore(key);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
