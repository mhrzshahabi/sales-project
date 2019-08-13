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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequiredArgsConstructor
@Controller
@RequestMapping("/dcc")
public class DCCFormController {
    private final OAuth2AuthorizedClientService authorizedClientService;

    @Value("${nicico.rest-api.url:''}")
    private String restApiUrl;

    @GetMapping(value = {"/showForm/{dccTableName}/{dccTableId}"})
    public String showDCC(ModelMap modelMap, @PathVariable String dccTableName, @PathVariable String dccTableId) {
        modelMap.addAttribute("dccTableName", dccTableName);
        modelMap.addAttribute("dccTableId", dccTableId);
        return "base/dcc";
    }

    @RequestMapping("/print/{type}")
    public void printDCC(HttpServletResponse response, @PathVariable String type) throws Exception {
    }

    @GetMapping(value = "/downloadFile")
    public ResponseEntity<?> downloadFile(@RequestParam String data, HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
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

        HttpEntity<String> entity = new HttpEntity<String>(headers);

        return restTemplate.exchange(restApiUrl + "/api/dcc/downloadFile?data=" + data, HttpMethod.GET, entity, byte[].class);
    }
}
