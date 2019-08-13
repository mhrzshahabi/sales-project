package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.PaymentOptionContractDTO;

import java.util.List;

public interface IPaymentOptionContractService {

	PaymentOptionContractDTO.Info get(Long id);

	List<PaymentOptionContractDTO.Info> list();

	PaymentOptionContractDTO.Info create(PaymentOptionContractDTO.Create request);

	PaymentOptionContractDTO.Info update(Long id, PaymentOptionContractDTO.Update request);

	void delete(Long id);

	void delete(PaymentOptionContractDTO.Delete request);

	SearchDTO.SearchRs<PaymentOptionContractDTO.Info> search(SearchDTO.SearchRq request);
}
