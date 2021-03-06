package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InvoiceSalesItemDTO;
import com.nicico.sales.model.entities.base.InvoiceSalesItem;

import java.util.List;

public interface IInvoiceSalesItemService {

    InvoiceSalesItemDTO.Info get(Long id);

    List<InvoiceSalesItemDTO.Info> list();

    InvoiceSalesItemDTO.Info create(InvoiceSalesItemDTO.Create request);

    InvoiceSalesItemDTO.Info update(Long id, InvoiceSalesItemDTO.Update request);

    void delete(Long id);

    void deleteAll(InvoiceSalesItemDTO.Delete request);

    TotalResponse<InvoiceSalesItemDTO.Info> search(NICICOCriteria criteria);

    List<InvoiceSalesItem> findByInvoiceSalesId(Long id);

}
