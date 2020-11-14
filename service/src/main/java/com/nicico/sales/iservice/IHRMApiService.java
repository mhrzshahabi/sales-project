package com.nicico.sales.iservice;

import com.nicico.sales.dto.HRMDTO;

public interface IHRMApiService {

    HRMDTO.BusinessDaysInfo getBusinessDays(HRMDTO.BusinessDaysRq request);
}
