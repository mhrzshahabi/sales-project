package com.nicico.sales.iservice;

import com.nicico.sales.dto.InvoiceNosaDTO;

import java.util.List;

public interface IInvoiceNosaService {

    List<InvoiceNosaDTO.Info> list();
}
