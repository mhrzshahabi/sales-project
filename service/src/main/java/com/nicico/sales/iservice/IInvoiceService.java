package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InvoiceDTO;

import java.util.List;

public interface IInvoiceService {

	InvoiceDTO.Info get(Long id);

	List<InvoiceDTO.Info> list();

	InvoiceDTO.Info create(InvoiceDTO.Create request);

	InvoiceDTO.Info update(Long id, InvoiceDTO.Update request);

	void delete(Long id);

	void delete(InvoiceDTO.Delete request);

	SearchDTO.SearchRs<InvoiceDTO.Info> search(SearchDTO.SearchRq request);
}
