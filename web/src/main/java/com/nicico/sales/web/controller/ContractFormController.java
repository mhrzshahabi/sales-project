package com.nicico.sales.web.controller;

import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.core.util.file.FileUtil;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.service.ContractService;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JRException;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/contract")
public class ContractFormController {

    private final FileUtil fileUtil;
    private final Environment environment;
    private final ContractService contractService;

    @RequestMapping("/showForm")
    public String showContract() {
        return "contract/contract";
    }

    @RequestMapping("/print/{id}")
    public void print(HttpServletRequest request, HttpServletResponse response, @PathVariable Long id) throws IOException {
        String docName = contractService.printContract(id);

            String UPLOAD_FILE_DIR = environment.getProperty("nicico.upload.dir");
            String filePath = UPLOAD_FILE_DIR + File.separator + "contract" + File.separator + docName+".doc";
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
}
