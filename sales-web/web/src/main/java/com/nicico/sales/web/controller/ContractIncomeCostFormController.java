package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.json.JsonParser;
import org.springframework.boot.json.JsonParserFactory;
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
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Controller
@RequestMapping("/contractIncomeCost")
public class ContractIncomeCostFormController {

    private final OAuth2AuthorizedClientService authorizedClientService;
    private final ObjectMapper objectMapper;

    @Value("${nicico.rest-api.url}")
    private String restApiUrl;

    @RequestMapping("/showForm")
    public String showContractIncomeCost(HttpServletRequest req) {

        String[][] contractIncomeCostFields =
                {
                        {"contractNo", "شماره قرارداد"},
                        {"customerFullNameEn", "نام کامل مشتری"},
                        {"productNameEn", "نام محصول"},
                        {"unitNameEn", "نام واحد"},
                        {"amount", "مقدار"},
                        {"totalFreight", "کل کرایه حمل"},
                        {"shipmentAmount", "مقدار حمل"},
                        {"blDate", "تاریخ بارنامه"},
                        {"demurage", "جریمه"},
                        {"dispatch", "تخفیف بارگیری"},
                        {"freight", "کرایه حمل"},
                        {"loadingLetter", "نامه بارگیری"},
                        {"month", "ماه"},
                        {"vesselName", "نام کشتی"},
                        {"invoceDateProvisional", "تاریخ فاکتور اولیه"},
                        {"netProvisional", "وزن خالص اولیه"},
                        {"invoiceTypeProvisional", "نوع فاکتور اولیه"},
                        {"invoiceNoProvisional", "شماره فاکتور اولیه"},
                        {"invoiceValueProvisional", "مقدار فاکتور اولیه"},
                        {"invoiceDollarProvisional", "مقداری دلاری فاکتور اولیه"},
                        {"invoiceEuroProvisional", "مقدار یورویی فاکتور اولیه"},
                        {"invoiceIRRProvisional", "مقدار ریالی فاکتور اولیه"},
                        {"invoceDateFinal", "تاریخ فاکتور نهایی"},
                        {"netFinal", "وزن خالص نهایی"},
                        {"invoiceTypeFinal", "نوع فاکتور نهایی"},
                        {"invoiceNoFinal", "شماره فاکتور نهایی"},
                        {"invoiceValueFinal", "مقدار فاکتور نهایی"},
                        {"invoiceDollarFinal", "مقدار دلاری فاکتور نهایی"},
                        {"invoiceEuroFinal", "مقدار یورویی فاکتور نهایی"},
                        {"invoiceIRRFinal", "مقدار ریالی فاکتور نهایی"},
                        {"costDollar", "هزینه دلاری"},
                        {"costEuro", "هزینه یورویی"},
                        {"costIRR", "هزینه ریالی"},
                        {"destinationInspectionCost", "هزینه بازرسی مقصد"},
                        {"sourceInspectionCost", "هزینه بازرسی مبدا"},
                        {"insuranceCost", "بیمه"},
                        {"umpireCost", "حکم"}
                };
        req.setAttribute("contractIncomeCostFields", contractIncomeCostFields);
        return "base/contractIncomeCost";
    }

    @GetMapping("/print/{type}/{criteria}/{preferences}")
    public ResponseEntity<?> print(
            Authentication authentication,
            @PathVariable String type,
            @PathVariable String criteria,
            @PathVariable String preferences
    ) throws JsonProcessingException {
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

        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(restApiUrl + "/api/contractIncomeCost/print");

        JsonParser jsonParser = JsonParserFactory.getJsonParser();
        Map<String, Object> criteriaMap = jsonParser.parseMap(criteria);
        String criteriaJson = new ObjectMapper().writeValueAsString(criteriaMap.get("criteria"));

        builder.queryParam("operator", criteriaMap.get("operator"));
        builder.queryParam("criteria", ((ArrayList) criteriaMap.get("criteria")).size() == 0 ? "" : criteriaJson);
        builder.queryParam("preferences", preferences);

        switch (type) {
            case "pdf":
                builder.queryParam("type", "pdf");
                return restTemplate.exchange(builder.toUriString(), HttpMethod.GET, entity, byte[].class);
            case "excel":
                builder.queryParam("type", "excel");
                return restTemplate.exchange(builder.toUriString(), HttpMethod.GET, entity, byte[].class);
            case "html":
                builder.queryParam("type", "html");
                return restTemplate.exchange(builder.toUriString(), HttpMethod.GET, entity, byte[].class);
            default:
                return null;
        }
    }
}
