package com.nicico.sales.service.contract;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.dto.report.ReportMethodDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ApiService {

    private final ObjectMapper objectMapper;

    public List<String> getRestApisFromFile() throws IOException {

        byte[] readAllBytes = readFile("restUrls.txt");
        return objectMapper.readValue(readAllBytes, new TypeReference<List<String>>() {
        });
    }

    public List<ReportMethodDTO> getReportMethod() throws IOException {

        byte[] readAllBytes = readFile("reportMethods.txt");
        return objectMapper.readValue(readAllBytes, new TypeReference<List<ReportMethodDTO>>() {
        });
    }

    private byte[] readFile(String fileName) throws IOException {

        File file = new File(fileName);
        return Files.readAllBytes(file.toPath());
    }
}
