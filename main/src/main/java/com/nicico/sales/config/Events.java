//package com.nicico.sales.config;
//
//import com.nicico.sales.dto.ShipmentCostDutyDTO;
//import com.nicico.sales.model.entities.base.ShipmentCostDuty;
//import lombok.RequiredArgsConstructor;
//import org.modelmapper.ModelMapper;
//import org.modelmapper.TypeMap;
//import org.springframework.stereotype.Component;
//
//import javax.annotation.PostConstruct;
//
//@Component
//@RequiredArgsConstructor
//public class Events {
//
//    private final ModelMapper modelMapper;
//
//    @PostConstruct
//    public void init() {
//
//        TypeMap<ShipmentCostDuty, ShipmentCostDutyDTO.Info> typeMap = modelMapper.createTypeMap(ShipmentCostDuty.class, ShipmentCostDutyDTO.Info.class);
//        typeMap.setConverter(new i18nConverter<>());
//    }
//}