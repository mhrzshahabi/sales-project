package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.ByteArrayHttpMessageConverter;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

@RequiredArgsConstructor
@Controller
@RequestMapping("/bank")
public class BankFormController {

    private final OAuth2AuthorizedClientService authorizedClientService;

    @Value("${nicico.rest-api.url:''}")
    private String restApiUrl;

    @RequestMapping("/showForm")
    public String showBank() {
        return "base/bank";
    }

    @RequestMapping("/print/{type}")
    public ResponseEntity<byte[]> print(Authentication authentication, @PathVariable String type) {
        String token = "";
        if (authentication instanceof OAuth2AuthenticationToken) {
            OAuth2AuthorizedClient client = authorizedClientService
                    .loadAuthorizedClient(
                            ((OAuth2AuthenticationToken) authentication).getAuthorizedClientRegistrationId(),
                            authentication.getName());
            token = client.getAccessToken().getTokenValue();
        }

        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getMessageConverters().add(new ByteArrayHttpMessageConverter());

        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + token);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        switch (type) {
            case "pdf":
                return restTemplate.exchange(restApiUrl + "/api/bank/print/pdf", HttpMethod.GET, entity, byte[].class);
            case "excel":
                return restTemplate.exchange(restApiUrl + "/api/bank/print/excel", HttpMethod.GET, entity, byte[].class);
            case "html":
                return restTemplate.exchange(restApiUrl + "/api/bank/print/html", HttpMethod.GET, entity, byte[].class);
            default:
                return null;
        }
    }
}