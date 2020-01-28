package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InvoiceDTO;

import java.util.List;

public interface IInvoiceService {

    InvoiceDTO.Info get(Long id);

    List<InvoiceDTO.Info> list();

    InvoiceDTO.Info create(InvoiceDTO.Create request);

    InvoiceDTO.Info update(Long id, InvoiceDTO.Update request);

    void delete(Long id);

    void delete(InvoiceDTO.Delete request);

    TotalResponse<InvoiceDTO.Info> search(NICICOCriteria criteria);

    InvoiceDTO.Info sendForm2accounting(Long id, String data);
}
