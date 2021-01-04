package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.sales.model.enumeration.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/enum")
public class EnumRestController {

    private Object createEnumObject(String value) {

        return new Object() {{

            final String id = value;
            final String name = value;
        }};
    }

    private ArrayList<Object> createEnumList(Enum[] enums) {

        ArrayList<Object> array = new ArrayList<>();
        for (Enum value : enums)
            array.add(createEnumObject(value.name()));

        return array;
    }

    @Loggable
    @GetMapping(value = "/priceBaseReference")
    public ResponseEntity<ArrayList<Object>> getPriceBaseReference(@RequestParam MultiValueMap<String, String> criteria) {

        return new ResponseEntity<>(createEnumList(PriceBaseReference.values()), HttpStatus.OK);
    }

//    @Loggable
//    @GetMapping(value = "/dataType")
//    public ResponseEntity<ArrayList<Object>> getDataType(@RequestParam MultiValueMap<String, String> criteria) {
//
//        return new ResponseEntity<>(createEnumList(DataType.values()), HttpStatus.OK);
//    }

    @Loggable
    @GetMapping(value = "/rateReference")
    public ResponseEntity<ArrayList<Object>> getRateReference(@RequestParam MultiValueMap<String, String> criteria) {

        return new ResponseEntity<>(createEnumList(RateReference.values()), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/commercialRole")
    public ResponseEntity<ArrayList<Object>> getCommercialRole(@RequestParam MultiValueMap<String, String> criteria) {

        return new ResponseEntity<>(createEnumList(CommercialRole.values()), HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/categoryUnit")
    public ResponseEntity<ArrayList<Object>> getCategoryUnit(@RequestParam MultiValueMap<String, String> criteria) {

        return new ResponseEntity<>(createEnumList(CategoryUnit.values()), HttpStatus.OK);
    }

//    @Loggable
//    @GetMapping(value = "/contractDetailTypeReference")
//    public ResponseEntity<ArrayList<Object>> getContractDetailTypeReference(@RequestParam MultiValueMap<String, String> criteria) {
//
//        return new ResponseEntity<>(createEnumList(ContractDetailTypeReference.values()), HttpStatus.OK);
//    }

    @Loggable
    @GetMapping(value = "/symbolUnit")
    public ResponseEntity<ArrayList<Object>> getSymbolUnit(@RequestParam MultiValueMap<String, String> criteria) {

        return new ResponseEntity<>(createEnumList(SymbolUnit.values()), HttpStatus.OK);
    }
}
