package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InvoiceSalesDTO;

import java.util.List;

public interface IInvoiceSalesService {

    InvoiceSalesDTO.Info get(Long id);

    List<InvoiceSalesDTO.Info> list();

    InvoiceSalesDTO.Info create(InvoiceSalesDTO.Create request);

    InvoiceSalesDTO.Info update(Long id, InvoiceSalesDTO.Update request);

    void delete(Long id);

    void deleteAll(InvoiceSalesDTO.Delete request);

    TotalResponse<InvoiceSalesDTO.Info> search(NICICOCriteria criteria);
}
