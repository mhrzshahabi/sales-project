package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InvoiceMolybdenumDTO;

import java.io.IOException;
import java.util.List;

public interface IInvoiceMolybdenumService {

	InvoiceMolybdenumDTO.Info get(Long id);

	List<InvoiceMolybdenumDTO.Info> list();

	void molybdenum(String data) throws IOException;

	InvoiceMolybdenumDTO.Info create(InvoiceMolybdenumDTO.Create request);

	InvoiceMolybdenumDTO.Info update(Long id, InvoiceMolybdenumDTO.Update request);

	void delete(Long id);

	void delete(InvoiceMolybdenumDTO.Delete request);

	TotalResponse<InvoiceMolybdenumDTO.Info> search(NICICOCriteria criteria);
}
