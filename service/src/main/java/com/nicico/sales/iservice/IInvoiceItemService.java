package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InvoiceItemDTO;

import java.util.List;

public interface IInvoiceItemService {

	InvoiceItemDTO.Info get(Long id);

	List<InvoiceItemDTO.Info> list();

	InvoiceItemDTO.Info create(InvoiceItemDTO.Create request);

	InvoiceItemDTO.Info update(Long id, InvoiceItemDTO.Update request);

	void delete(Long id);

	void delete(InvoiceItemDTO.Delete request);

	SearchDTO.SearchRs<InvoiceItemDTO.Info> search(SearchDTO.SearchRq request);
}
