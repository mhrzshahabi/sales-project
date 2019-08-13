package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ProvisionalInvoiceDTO;

import java.util.List;

public interface IProvisionalInvoiceService {

	ProvisionalInvoiceDTO.Info get(Long id);

	List<ProvisionalInvoiceDTO.Info> list();

	ProvisionalInvoiceDTO.Info create(ProvisionalInvoiceDTO.Create request);

	ProvisionalInvoiceDTO.Info update(Long id, ProvisionalInvoiceDTO.Update request);

	void delete(Long id);

	void delete(ProvisionalInvoiceDTO.Delete request);

	SearchDTO.SearchRs<ProvisionalInvoiceDTO.Info> search(SearchDTO.SearchRq request);
}
