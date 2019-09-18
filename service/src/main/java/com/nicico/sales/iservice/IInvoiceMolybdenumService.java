package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InvoiceMolybdenumDTO;

import java.util.List;

public interface IInvoiceMolybdenumService {

	InvoiceMolybdenumDTO.Info get(Long id);

	List<InvoiceMolybdenumDTO.Info> list();

	InvoiceMolybdenumDTO.Info create(InvoiceMolybdenumDTO.Create request);

	InvoiceMolybdenumDTO.Info update(Long id, InvoiceMolybdenumDTO.Update request);

	void delete(Long id);

	void delete(InvoiceMolybdenumDTO.Delete request);

	SearchDTO.SearchRs<InvoiceMolybdenumDTO.Info> search(SearchDTO.SearchRq request);
}
