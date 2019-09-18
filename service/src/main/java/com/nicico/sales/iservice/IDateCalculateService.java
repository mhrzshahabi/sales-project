package com.nicico.sales.iservice;

import com.nicico.sales.dto.DateEventValuesDTO;

import org.springframework.stereotype.Service;

import java.text.ParseException;

@Service
public interface IDateCalculateService {
    String calYesterday(String date);

    DateEventValuesDTO getEveryDateYouWant(String date) throws ParseException;
}
