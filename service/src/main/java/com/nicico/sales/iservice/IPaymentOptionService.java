package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.PaymentOptionDTO;

import java.util.List;

public interface IPaymentOptionService {

	PaymentOptionDTO.Info get(Long id);

	List<PaymentOptionDTO.Info> list();

	PaymentOptionDTO.Info create(PaymentOptionDTO.Create request);

	PaymentOptionDTO.Info update(Long id, PaymentOptionDTO.Update request);

	void delete(Long id);

	void delete(PaymentOptionDTO.Delete request);

	TotalResponse<PaymentOptionDTO.Info> search(NICICOCriteria criteria);
}
