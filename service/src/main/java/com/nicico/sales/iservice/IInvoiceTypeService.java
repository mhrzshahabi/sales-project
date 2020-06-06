package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InvoiceTypeDTO;


import java.util.List;

public interface IInvoiceTypeService {

    InvoiceTypeDTO.Info get(Long id);

    List<InvoiceTypeDTO.Info> list();

    InvoiceTypeDTO.Info create(InvoiceTypeDTO.Create request);

    InvoiceTypeDTO.Info update(Long id, InvoiceTypeDTO.Update request);

    void delete(Long id);

    void deleteAll(InvoiceTypeDTO.Delete request);

    TotalResponse<InvoiceTypeDTO.Info> search(NICICOCriteria criteria);

}
