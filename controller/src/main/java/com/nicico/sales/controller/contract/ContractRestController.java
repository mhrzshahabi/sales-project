package com.nicico.sales.controller.contract;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractDTO;
import com.nicico.sales.dto.contract.ContractDetailDTO;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.contract.IContractDetailService;
import com.nicico.sales.iservice.contract.IContractService;
import com.nicico.sales.utility.SpecListUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/g-contract")
public class ContractRestController {

    private final SpecListUtil specListUtil;
    private final IContractService contractService;
    private final IContractDetailService contractDetailService;
    private final ResourceBundleMessageSource messageSource;


    @Loggable
    @GetMapping(value = "/{id}")
    public ResponseEntity<ContractDTO.Info> get(@PathVariable Long id) {

        return new ResponseEntity<>(contractService.get(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/content/{id}")
    public ResponseEntity<String> getContent(@PathVariable Long id) {
        return new ResponseEntity<>(contractService.getContent(id), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<List<ContractDTO.Info>> list() {

        return new ResponseEntity<>(contractService.list(), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/is-depend-on-contract-detail-type/{cdtId}")
    public ResponseEntity<Boolean> isDependOnContractDetailType(@PathVariable Long cdtId) {

        boolean isDependOnContractDetailType = contractService.findAllByContractDetailTypeId(cdtId).size() > 0;
        return new ResponseEntity<>(isDependOnContractDetailType, HttpStatus.OK);
    }

    @Loggable
    @PostMapping
    public ResponseEntity<ContractDTO.Info> create(@Validated @RequestBody ContractDTO.Create request) {

        return new ResponseEntity<>(contractService.create(request), HttpStatus.CREATED);
    }

    @Loggable
    @PostMapping("/finalize/{id}")
    public ResponseEntity<ContractDTO.Info> finalize(@PathVariable Long id) {

        return new ResponseEntity<>(contractService.finalize(id), HttpStatus.CREATED);
    }

    @Loggable
    @PostMapping("/disapprove/{id}")
    public ResponseEntity<ContractDTO.Info> disapprove(@PathVariable Long id) {

        return new ResponseEntity<>(contractService.disapprove(id), HttpStatus.CREATED);
    }

    @Loggable
    @PutMapping
    public ResponseEntity<ContractDTO.Info> update(@Validated @RequestBody ContractDTO.Update request) {

        return new ResponseEntity<>(contractService.update(request.getId(), request), HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {

        contractService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @DeleteMapping(value = "/list")
    public ResponseEntity<Void> delete(@Validated @RequestBody ContractDTO.Delete request) {

        contractService.deleteAll(request);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/spec-list")
    public ResponseEntity<TotalResponse<ContractDTO.ListGridInfo>> list(@RequestParam MultiValueMap<String, String> criteria) {

        final NICICOCriteria nicicoCriteria = NICICOCriteria.of(criteria);
        return new ResponseEntity<>(contractService.refinedSearch(nicicoCriteria), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/latest-version-of-data/{contractId}/{code}/{contractDetailValueKey}")
    public ResponseEntity<List<Object>> latestVersionOfData(@PathVariable String contractDetailValueKey, @PathVariable Long contractId, @PathVariable String code) {
        return new ResponseEntity<>(contractService.getOperationalDataOfContractArticle(contractId, code, contractDetailValueKey), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/latest-version-of-data-response")
    public ResponseEntity<Map<String, Object>> latestVersionOfDataResponse(@RequestParam String code, @RequestParam String contractDetailValueKey, @RequestParam(required = false) Long contractId) {

        List<Object> contractArticle = contractService.getOperationalDataOfContractArticle(contractId, code, contractDetailValueKey);
        if (contractArticle == null) contractArticle = new ArrayList<>();
        return new ResponseEntity<>(specListUtil.getCoveredByResponse(contractArticle), HttpStatus.OK);
    }

    @GetMapping(value = "/entities")
    public ResponseEntity<List<String>> entityList() throws IOException {

        return new ResponseEntity<>(contractService.getRestApis(), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/get-delivery-article/{materialId}/{contractId}")
    public String getDeliveryArticle(@PathVariable Long materialId, @PathVariable Long contractId) {

        Locale locale = LocaleContextHolder.getLocale();
        String message = messageSource.getMessage("shipment.show.article.empty", null, locale);

        if (materialId == 2) {

            try {
                ContractDetailDTO.Info shipmentDetail = contractDetailService.getContractDetailByContractDetailTypeCode(contractId, materialId, EContractDetailTypeCode.Shipment);
                if (shipmentDetail != null)
                    return shipmentDetail.getContent();
            } catch (Exception e) {
                throw new SalesException2(ErrorType.NotFound, null, message);
            }

        } else if (materialId == 1) {

            try {
                ContractDetailDTO.Info deliveryDetail = contractDetailService.getContractDetailByContractDetailTypeCode(contractId, materialId, EContractDetailTypeCode.DeliveryTerms);
                if (deliveryDetail != null)
                    return deliveryDetail.getContent();
            } catch (Exception e) {
                throw new SalesException2(ErrorType.NotFound, null, message);
            }

        } else {
            throw new SalesException2(ErrorType.NotFound, null, message);
        }
        return null;
    }
}
