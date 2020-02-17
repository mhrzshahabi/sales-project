package com.nicico.sales.web.controller;

import com.nicico.copper.core.util.file.FileUtil;
import com.nicico.sales.service.ContractService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.persistence.EntityManager;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/contract")
public class ContractFormController {

    private final FileUtil fileUtil;
    private final Environment environment;
    private final ContractService contractService;
    private final EntityManager entityManager;

    @RequestMapping("/showForm")
    public String showContract() {
        return "contract/contract";
    }

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    @RequestMapping("/print/{id}")
    public void print(HttpServletRequest request, HttpServletResponse response, @PathVariable Long id) throws IOException {

        String docName = contractService.printContract(id);
        docName = docName + ".doc";
        String UPLOAD_FILE_DIR = environment.getProperty("nicico.upload.dir");
        String filePath = UPLOAD_FILE_DIR + File.separator + "contract" + File.separator + docName;
        File downloadFile = new File(filePath);
        FileInputStream inputStream = new FileInputStream(downloadFile);

        ServletContext context = request.getServletContext();
        String mimeType = context.getMimeType(filePath);
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }
        response.setContentType(mimeType);
        String headerKey = "Content-Disposition";
        String headerValue = String.format("attachment; filename=%s", docName);
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
        fileUtil.download(docName, response);
    }

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    @RequestMapping("/print/{id}/{idDradf}")
    public void print(HttpServletRequest request, HttpServletResponse response, @PathVariable Long id, @PathVariable Long idDradf) throws IOException {
        String docName = contractService.printContract(id, idDradf);
        docName = docName + ".doc";
        String UPLOAD_FILE_DIR = environment.getProperty("nicico.upload.dir");
        String filePath = UPLOAD_FILE_DIR + File.separator + "contract" + File.separator + docName;
        File downloadFile = new File(filePath);
        FileInputStream inputStream = new FileInputStream(downloadFile);
        ServletContext context = request.getServletContext();
        String mimeType = context.getMimeType(filePath);
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }
        response.setContentType(mimeType);
        String headerKey = "Content-Disposition";
        String headerValue = String.format("attachment; filename=%s", docName);
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
        fileUtil.download(docName, response);
    }


    private Integer findMax(List<Integer> list) {
        if (list == null || list.size() == 0) {
            return Integer.MIN_VALUE;
        }
        List<Integer> sortedlist = new ArrayList<>(list);
        Collections.sort(sortedlist);
        return sortedlist.get(sortedlist.size() - 1);
    }
}
