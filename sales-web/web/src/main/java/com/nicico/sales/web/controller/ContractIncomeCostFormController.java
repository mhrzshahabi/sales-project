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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;

@RequiredArgsConstructor
@Controller
@RequestMapping("/contractIncomeCost")
public class ContractIncomeCostFormController {

    private final OAuth2AuthorizedClientService authorizedClientService;

    @Value("${nicico.rest-api.url}")
    private String restApiUrl;

    @RequestMapping("/showForm")
    public String showContractIncomeCost( HttpServletRequest req) {
        String [][] aa=
        {{ "String","contractNo","@" },
        { "String","customerFullNameEn","@" },
        { "String","ProductNameEn","@" },
        { "String","unitNameEn","@" },
        { "Double","amount","@" },
        { "String","totalFreight","@" },
        { "Double","ShipmentAmount","@" },
        { "String","blDate","@" },
        { "Double","Demurage","@" },
        { "Double","Dispatch","@" },
        { "Double","freight","@" },
        { "String","loadingLetter","@" },
        { "String","month","@" },
        { "String","vesselName","@" },
        { "String","invoceDateProvisional","@" },
        { "Double","netProvisional","@" },
        { "String","invoiceTypeProvisional","@" },
        { "String","invoiceNoProvisional","@" },
        { "String","invoiceValueProvisional","@" },
        { "Double","invoiceDollarProvisional","@" },
        { "Double","invoiceEuroProvisional","@" },
        { "Double","invoiceIRRProvisional","@" },
        { "String","invoceDateFinal","@" },
        { "Double","netFinal","@" },
        { "String","invoiceTypeFinal","@" },
        { "String","invoiceNoFinal","@" },
        { "String","invoiceValueFinal","@" },
        { "Double","invoiceDollarFinal","@" },
        { "Double","invoiceEuroFinal","@" },
        { "Double","invoiceIRRFinal","@" },
        { "Double","costDollar","@" },
        { "Double","costEuro","@" },
        { "Double","costIRR","@" },
        { "String","DestinationInspectionCost","@" },
        { "String","SourceInspectionCost","@" },
        { "String","insuranceCost","@" },
        { "String","umpireCost","@" }};
        req.setAttribute("aa",aa);
        return "base/contractIncomeCost";
    }

    @RequestMapping("/print/{type}")
    public ResponseEntity<?> print(Authentication authentication, @PathVariable String type) {
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

        if(type.equals("pdf"))
            return restTemplate.exchange(restApiUrl + "/api/contractIncomeCost/print", HttpMethod.GET, entity, byte[].class);
        else if(type.equals("excel"))
            return restTemplate.exchange(restApiUrl + "/api/contractIncomeCost/print/excel", HttpMethod.GET, entity, byte[].class);
        else if(type.equals("html"))
            return restTemplate.exchange(restApiUrl + "/api/contractIncomeCost/print/html", HttpMethod.GET, entity, byte[].class);
        else
            return null;
    }
}
