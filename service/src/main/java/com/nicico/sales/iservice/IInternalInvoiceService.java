package com.nicico.sales.iservice;

import com.nicico.sales.dto.InternalInvoiceDTO;

public interface IInternalInvoiceService {

    InternalInvoiceDTO.Info get(String id);
}
