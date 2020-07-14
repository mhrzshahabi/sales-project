package com.nicico.sales.service;

import com.nicico.sales.dto.InvoiceTypeDTO;
import com.nicico.sales.iservice.IInvoiceTypeService;
import com.nicico.sales.model.entities.base.InvoiceType;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class InvoiceTypeService extends GenericService<InvoiceType, Long, InvoiceTypeDTO.Create, InvoiceTypeDTO.Info, InvoiceTypeDTO.Update, InvoiceTypeDTO.Delete> implements IInvoiceTypeService {
}
