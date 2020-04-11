package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.PaymentTypeDTO;

import java.util.List;

public interface IPaymentTypeService {

    List<PaymentTypeDTO.Info> list();

    TotalResponse<PaymentTypeDTO.Info> search(NICICOCriteria criteria);
}
