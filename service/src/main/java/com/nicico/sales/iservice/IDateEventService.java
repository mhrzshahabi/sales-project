package com.nicico.sales.iservice;

import com.nicico.sales.dto.DateEventValuesDTO;

import org.springframework.stereotype.Service;

@Service
public interface IDateEventService {
    DateEventValuesDTO calDateValues(String date);
}
