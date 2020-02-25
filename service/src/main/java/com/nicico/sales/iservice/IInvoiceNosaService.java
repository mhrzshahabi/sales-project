package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InvoiceNosaDTO;
import com.nicico.sales.dto.InvoiceSalesDTO;
import com.nicico.sales.model.entities.base.InvoiceNosa;

import java.util.List;

public interface IInvoiceNosaService {

    List<InvoiceNosaDTO.Info> list();
}
