package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InvoiceInternalCustomerDTO;

import java.util.List;

public interface IInvoiceInternalCustomerService {

	InvoiceInternalCustomerDTO.Info get(Long id);

	List<InvoiceInternalCustomerDTO.Info> list();

	InvoiceInternalCustomerDTO.Info create(InvoiceInternalCustomerDTO.Create request);

	InvoiceInternalCustomerDTO.Info update(Long id, InvoiceInternalCustomerDTO.Update request);

	void delete(Long id);

	void delete(InvoiceInternalCustomerDTO.Delete request);

	TotalResponse<InvoiceInternalCustomerDTO.Info> search(NICICOCriteria criteria);

	SearchDTO.SearchRs<InvoiceInternalCustomerDTO.Info> search(SearchDTO.SearchRq request);

}
