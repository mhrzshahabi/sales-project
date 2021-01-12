package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.sales.model.enumeration.*;
import com.nicico.sales.utility.SpecListUtil;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/enum")
public class EnumRestController {

    private final SpecListUtil specListUtil;

    @Getter
    @Setter
    private class EnumObject {

        private String id;
        private String name;
    }

    private Object createEnumObject(String value) {

        EnumObject enumObject = new EnumObject();
        enumObject.setId(value);
        enumObject.setName(value);
        return enumObject;
    }

    private Map<String, Object> createEnumList(Enum[] enums) {

        ArrayList<Object> array = new ArrayList<>();
        for (Enum value : enums)
            array.add(createEnumObject(value.name()));

        return specListUtil.getCoveredByResponse(array);
    }

    @Loggable
    @GetMapping(value = "/priceBaseReference")
    public ResponseEntity<Map<String, Object>> getPriceBaseReference(@RequestParam MultiValueMap<String, String> criteria) {

        return new ResponseEntity<>(createEnumList(PriceBaseReference.values()), HttpStatus.OK);
    }

//    @Loggable
//    @GetMapping(value = "/dataType")
//    public ResponseEntity<Map<String, Object>> getDataType(@RequestParam MultiValueMap<String, String> criteria) {
//
//        return new ResponseEntity<>(createEnumList(DataType.values()), HttpStatus.OK);
//    }

    @Loggable
    @GetMapping(value = "/rateReference")
    public ResponseEntity<Map<String, Object>> getRateReference(@RequestParam MultiValueMap<String, String> criteria) {

        return new ResponseEntity<>(createEnumList(RateReference.values()), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/commercialRole")
    public ResponseEntity<Map<String, Object>> getCommercialRole(@RequestParam MultiValueMap<String, String> criteria) {

        return new ResponseEntity<>(createEnumList(CommercialRole.values()), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/categoryUnit")
    public ResponseEntity<Map<String, Object>> getCategoryUnit(@RequestParam MultiValueMap<String, String> criteria) {

        return new ResponseEntity<>(createEnumList(CategoryUnit.values()), HttpStatus.OK);
    }

//    @Loggable
//    @GetMapping(value = "/contractDetailTypeReference")
//    public ResponseEntity<Map<String, Object>> getContractDetailTypeReference(@RequestParam MultiValueMap<String, String> criteria) {
//
//        return new ResponseEntity<>(createEnumList(ContractDetailTypeReference.values()), HttpStatus.OK);
//    }

    @Loggable
    @GetMapping(value = "/symbolUnit")
    public ResponseEntity<Map<String, Object>> getSymbolUnit(@RequestParam MultiValueMap<String, String> criteria) {

        return new ResponseEntity<>(createEnumList(SymbolUnit.values()), HttpStatus.OK);
    }
}
