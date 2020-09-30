package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InternalInvoiceDTO;

import java.util.List;

public interface IInvoiceInternalService {

	InternalInvoiceDTO.Info get(String id);

	List<InternalInvoiceDTO.Info> getIds(List<String> id);

	List<InternalInvoiceDTO.Info> list();

	TotalResponse<InternalInvoiceDTO.Info> search(NICICOCriteria criteria);

	InternalInvoiceDTO.Info sendInternalForm2accounting(String id, String data);

	void updateDeletedDocument(List<InternalInvoiceDTO.Info> data);
}
