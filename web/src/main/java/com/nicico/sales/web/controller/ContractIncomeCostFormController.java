package com.nicico.sales.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractIncomeCostDTO;
import com.nicico.sales.iservice.IContractIncomeCostService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.json.JsonParser;
import org.springframework.boot.json.JsonParserFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@RequiredArgsConstructor
@Controller
@RequestMapping("/contractIncomeCost")
public class ContractIncomeCostFormController {

    private final OAuth2AuthorizedClientService authorizedClientService;
    private final IContractIncomeCostService contractIncomeCostService;
    private final ObjectMapper objectMapper;

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
            @PathVariable String type,
            @PathVariable String criteria,
            @PathVariable String preferences,
            HttpServletResponse httpServletResponse
    ) throws JsonProcessingException {

        JsonParser jsonParser = JsonParserFactory.getJsonParser();
        Map<String, Object> criteriaMap = jsonParser.parseMap(criteria);
        String criteriaJson = new ObjectMapper().writeValueAsString(criteriaMap.get("criteria"));

        String operator = criteriaMap.get("operator").toString();
        criteria = ((ArrayList) criteriaMap.get("criteria")).size() == 0 ? "" : criteriaJson;

        try {
            SearchDTO.SearchRq request = new SearchDTO.SearchRq();

            preferences = java.net.URLDecoder.decode(preferences, StandardCharsets.UTF_8.name());
            preferences = preferences.replaceAll(":", "\":");
            preferences = preferences.replaceAll("\\{", "\\{\"");
            preferences = preferences.replaceAll(",", ",\"");
            preferences = preferences.replaceAll("\"\\{", "\\{");

            Map<String, Object> preferencesMap = jsonParser.parseMap(preferences);
            ArrayList<String> columns = new ArrayList<>();
            ArrayList<String> fields = new ArrayList<>();
            for (Map<String, Object> field : (ArrayList<Map<String, Object>>) preferencesMap.get("field")) {
                if (!field.containsKey("visible")) {
                    if ((type.equals("pdf") || type.equals("excel")) && (columns.size() >= 8 || field.size() >= 8)) { // view exceeded problem!
                        continue;
                    }
                    columns.add(field.get("title").toString());
                    fields.add(field.get("name").toString());
                }
            }

            criteria = java.net.URLDecoder.decode(criteria, StandardCharsets.UTF_8.name());
            if (criteria.equals(""))
                criteria = "[" + criteria + "]";
            SearchDTO.CriteriaRq criteriaRq = new SearchDTO.CriteriaRq();
            criteriaRq.setOperator(EOperator.valueOf(operator))
                    .setCriteria(objectMapper.readValue(criteria, new TypeReference<List<SearchDTO.CriteriaRq>>() {
                    }));

            if (preferencesMap.containsKey("sort")) {
                List<String> sortByList = new ArrayList<>();
                for (Map<String, Object> sort : (ArrayList<Map<String, Object>>) ((Map) preferencesMap.get("sort")).get("sortSpecifiers")) {
                    if (sort.get("direction").equals("descending")) {
                        sortByList.add("-" + sort.get("property"));
                    } else {
                        sortByList.add(sort.get("property").toString());
                    }
                }
                request.setSortBy(sortByList);
            }

            request.setCriteria(criteriaRq);
            request.setStartIndex(0).setCount(50);

            List<ContractIncomeCostDTO.Info> searchList = contractIncomeCostService.search(request).getList();

            contractIncomeCostService.pdfFx(searchList, columns, fields, type, httpServletResponse);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
