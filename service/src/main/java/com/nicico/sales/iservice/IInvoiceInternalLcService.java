package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InvoiceInternalLcDTO;

import java.util.List;

public interface IInvoiceInternalLcService {

	InvoiceInternalLcDTO.Info get(Long id);

	List<InvoiceInternalLcDTO.Info> list();

	InvoiceInternalLcDTO.Info create(InvoiceInternalLcDTO.Create request);

	InvoiceInternalLcDTO.Info update(Long id, InvoiceInternalLcDTO.Update request);

	void delete(Long id);

	void delete(InvoiceInternalLcDTO.Delete request);

	TotalResponse<InvoiceInternalLcDTO.Info> search(NICICOCriteria criteria);

	SearchDTO.SearchRs<InvoiceInternalLcDTO.Info> search(SearchDTO.SearchRq request);
}
