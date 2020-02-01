package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InvoiceInternalDTO;

import java.util.List;

public interface IInvoiceInternalService {

    InvoiceInternalDTO.Info get(Long id);

    List<InvoiceInternalDTO.Info> getIds(List id);

    List<InvoiceInternalDTO.Info> list();

    InvoiceInternalDTO.Info create(InvoiceInternalDTO.Create request);

    InvoiceInternalDTO.Info update(Long id, InvoiceInternalDTO.Update request);

    void delete(Long id);

    void delete(InvoiceInternalDTO.Delete request);

    TotalResponse<InvoiceInternalDTO.Info> search(NICICOCriteria criteria);

    InvoiceInternalDTO.Info sendInternalForm2accounting(Long id, String data);
}
