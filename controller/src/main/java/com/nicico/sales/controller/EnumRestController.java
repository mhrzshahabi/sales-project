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

    @Loggable
    @GetMapping(value = "/priceBaseReference")
    public ResponseEntity<ArrayList<Object>> getPriceBaseReference(@RequestParam MultiValueMap<String, String> criteria) {

        ArrayList<Object> priceBaseReferenceArray = new ArrayList<>();

        for (PriceBaseReference value : PriceBaseReference.values()) {

            Object pbEnum = new Object(){{

                final String id = value.name();
                final String name = value.name();
            }};
            priceBaseReferenceArray.add(pbEnum);
        }

        return new ResponseEntity<>(priceBaseReferenceArray, HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/dataType")
    public ResponseEntity<ArrayList<Object>> getDataType(@RequestParam MultiValueMap<String, String> criteria) {

        ArrayList<Object> dataTypeArray = new ArrayList<>();

        for (DataType value : DataType.values()) {

            Object dtEnum = new Object(){{

                final String id = value.name();
                final String name = value.name();
            }};

            dataTypeArray.add(dtEnum);
        }

        return new ResponseEntity<>(dataTypeArray, HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/rateReference")
    public ResponseEntity<ArrayList<Object>> getRateReference(@RequestParam MultiValueMap<String, String> criteria) {

        ArrayList<Object> rateReferenceArray = new ArrayList<>();

        for (RateReference value : RateReference.values()) {

            Object rrEnum = new Object(){{

                final String id = value.name();
                final String name = value.name();
            }};

            rateReferenceArray.add(rrEnum);
        }

        return new ResponseEntity<>(rateReferenceArray, HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/commercialRole")
    public ResponseEntity<ArrayList<Object>> getCommercialRole(@RequestParam MultiValueMap<String, String> criteria) {

        ArrayList<Object> commercialRoleArray = new ArrayList<>();

        for (CommercialRole value : CommercialRole.values()) {

            Object crEnum = new Object(){{

                final String id = value.name();
                final String name = value.name();
            }};

            commercialRoleArray.add(crEnum);
        }

        return new ResponseEntity<>(commercialRoleArray, HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/categoryUnit")
    public ResponseEntity<ArrayList<Object>> getCategoryUnit(@RequestParam MultiValueMap<String, String> criteria) {

        ArrayList<Object> categoryUnitArray = new ArrayList<>();

        for (CategoryUnit value : CategoryUnit.values()) {

            Object cuEnum = new Object(){{

                final String id = value.name();
                final String name = value.name();
            }};

            categoryUnitArray.add(cuEnum);
        }

        return new ResponseEntity<>(categoryUnitArray, HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/contractDetailTypeReference")
    public ResponseEntity<ArrayList<Object>> getContractDetailTypeReference(@RequestParam MultiValueMap<String, String> criteria) {

        ArrayList<Object> contractDetailTypeReferenceArray = new ArrayList<>();

        for (ContractDetailTypeReference value : ContractDetailTypeReference.values()) {

            Object cdtrEnum = new Object(){{

                final String id = value.name();
                final String name = value.name();
            }};

            contractDetailTypeReferenceArray.add(cdtrEnum);
        }

        return new ResponseEntity<>(contractDetailTypeReferenceArray, HttpStatus.OK);
    }

    @Loggable
    @GetMapping(value = "/symbolUnit")
    public ResponseEntity<ArrayList<Object>> getSymbolUnit(@RequestParam MultiValueMap<String, String> criteria) {

        ArrayList<Object> symbolUnitArray = new ArrayList<>();

        for (SymbolUnit value : SymbolUnit.values()) {

            Object suEnum = new Object(){{

                final String id = value.name();
                final String name = value.name();
            }};

            symbolUnitArray.add(suEnum);
        }

        return new ResponseEntity<>(symbolUnitArray, HttpStatus.OK);
    }

}
