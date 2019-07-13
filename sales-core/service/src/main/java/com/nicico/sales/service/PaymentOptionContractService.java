package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.PaymentOptionContractDTO;
import com.nicico.sales.iservice.IPaymentOptionContractService;
import com.nicico.sales.model.entities.base.PaymentOptionContract;
import com.nicico.sales.repository.PaymentOptionContractDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class PaymentOptionContractService implements IPaymentOptionContractService {

	private final PaymentOptionContractDAO paymentOptionContractDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public PaymentOptionContractDTO.Info get(Long id) {
		final Optional<PaymentOptionContract> slById = paymentOptionContractDAO.findById(id);
		final PaymentOptionContract paymentOptionContract = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.PaymentOptionContractNotFound));

		return modelMapper.map(paymentOptionContract, PaymentOptionContractDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<PaymentOptionContractDTO.Info> list() {
		final List<PaymentOptionContract> slAll = paymentOptionContractDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<PaymentOptionContractDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public PaymentOptionContractDTO.Info create(PaymentOptionContractDTO.Create request) {
		final PaymentOptionContract paymentOptionContract = modelMapper.map(request, PaymentOptionContract.class);

		return save(paymentOptionContract);
	}

	@Transactional
	@Override
	public PaymentOptionContractDTO.Info update(Long id, PaymentOptionContractDTO.Update request) {
		final Optional<PaymentOptionContract> slById = paymentOptionContractDAO.findById(id);
		final PaymentOptionContract paymentOptionContract = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.PaymentOptionContractNotFound));

		PaymentOptionContract updating = new PaymentOptionContract();
		modelMapper.map(paymentOptionContract, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		paymentOptionContractDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(PaymentOptionContractDTO.Delete request) {
		final List<PaymentOptionContract> paymentOptionContracts = paymentOptionContractDAO.findAllById(request.getIds());

		paymentOptionContractDAO.deleteAll(paymentOptionContracts);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<PaymentOptionContractDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(paymentOptionContractDAO, request, paymentOptionContract -> modelMapper.map(paymentOptionContract, PaymentOptionContractDTO.Info.class));
	}

	// ------------------------------

	private PaymentOptionContractDTO.Info save(PaymentOptionContract paymentOptionContract) {
		final PaymentOptionContract saved = paymentOptionContractDAO.saveAndFlush(paymentOptionContract);
		return modelMapper.map(saved, PaymentOptionContractDTO.Info.class);
	}
}
