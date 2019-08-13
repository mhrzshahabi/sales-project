package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.ByteArrayHttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.Charset;

@RequiredArgsConstructor
@Controller
@RequestMapping("/dailyReportBandarAbbas")
public class DailyReportBandarAbbasFormController {

    private final OAuth2AuthorizedClientService authorizedClientService;

    @Value("${nicico.rest-api.url:''}")
    private String restApiUrl;

    @RequestMapping("/showForm")
    public String showDailyReportBandarAbbas() {
        return "report/dailyReportBandarAbbas";
    }

    @RequestMapping("/print/{type}")
    public ResponseEntity<?> printDailyReportBandarAbbas(Authentication authentication, @PathVariable String type, @RequestParam(name = "toDay", required = false) String toDay, @RequestParam(name = "warehouseNo", required = false) String warehouseNo) throws Exception {


        String token = "";
        if (authentication instanceof OAuth2AuthenticationToken) {
            OAuth2AuthorizedClient client = authorizedClientService
                    .loadAuthorizedClient(
                            ((OAuth2AuthenticationToken) authentication).getAuthorizedClientRegistrationId(),
                            authentication.getName());
            token = client.getAccessToken().getTokenValue();
        }

        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getMessageConverters()
                .add(0, new StringHttpMessageConverter(Charset.forName("UTF-8")));
        restTemplate.getMessageConverters().add(1, new ByteArrayHttpMessageConverter());

        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + token);
        headers.add("toDay", toDay);
        headers.add("warehouseNo", warehouseNo);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        switch (type) {
            case "pdf":
                return restTemplate.exchange(restApiUrl + "/api/report/printDailyReportBandarAbbas", HttpMethod.POST, entity, byte[].class);
            case "excel":
                return restTemplate.exchange(restApiUrl + "/api/report/printDailyReportBandarAbbas", HttpMethod.POST, entity, byte[].class);
            case "html":
                return restTemplate.exchange(restApiUrl + "/api/report/printDailyReportBandarAbbas", HttpMethod.POST, entity, byte[].class);
            default:
                return null;
        }


    }
}
