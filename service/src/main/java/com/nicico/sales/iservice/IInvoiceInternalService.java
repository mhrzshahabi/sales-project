package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InvoiceInternalDTO;

import java.util.List;

public interface IInvoiceInternalService {

    InvoiceInternalDTO.Info get(Long id);

    List<InvoiceInternalDTO.Info> getIds(List<Long> id);

    List<InvoiceInternalDTO.Info> list();

    TotalResponse<InvoiceInternalDTO.Info> search(NICICOCriteria criteria);

    InvoiceInternalDTO.Info sendInternalForm2accounting(Long id, String data);
}
