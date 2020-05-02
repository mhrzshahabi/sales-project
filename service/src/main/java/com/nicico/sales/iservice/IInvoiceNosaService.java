package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InvoiceNosaDTO;

public interface IInvoiceNosaService {

    TotalResponse<InvoiceNosaDTO.Info> search(NICICOCriteria criteria);
}
