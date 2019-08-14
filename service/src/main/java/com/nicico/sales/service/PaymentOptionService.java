package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.PaymentOptionDTO;
import com.nicico.sales.iservice.IPaymentOptionService;
import com.nicico.sales.model.entities.base.PaymentOption;
import com.nicico.sales.repository.PaymentOptionDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class PaymentOptionService implements IPaymentOptionService {

	private final PaymentOptionDAO paymentOptionDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public PaymentOptionDTO.Info get(Long id) {
		final Optional<PaymentOption> slById = paymentOptionDAO.findById(id);
		final PaymentOption paymentOption = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.PaymentOptionNotFound));

		return modelMapper.map(paymentOption, PaymentOptionDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<PaymentOptionDTO.Info> list() {
		final List<PaymentOption> slAll = paymentOptionDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<PaymentOptionDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public PaymentOptionDTO.Info create(PaymentOptionDTO.Create request) {
		final PaymentOption paymentOption = modelMapper.map(request, PaymentOption.class);

		return save(paymentOption);
	}

	@Transactional
	@Override
	public PaymentOptionDTO.Info update(Long id, PaymentOptionDTO.Update request) {
		final Optional<PaymentOption> slById = paymentOptionDAO.findById(id);
		final PaymentOption paymentOption = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.PaymentOptionNotFound));

		PaymentOption updating = new PaymentOption();
		modelMapper.map(paymentOption, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		paymentOptionDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(PaymentOptionDTO.Delete request) {
		final List<PaymentOption> paymentOptions = paymentOptionDAO.findAllById(request.getIds());

		paymentOptionDAO.deleteAll(paymentOptions);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<PaymentOptionDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(paymentOptionDAO, request, paymentOption -> modelMapper.map(paymentOption, PaymentOptionDTO.Info.class));
	}

	// ------------------------------

	private PaymentOptionDTO.Info save(PaymentOption paymentOption) {
		final PaymentOption saved = paymentOptionDAO.saveAndFlush(paymentOption);
		return modelMapper.map(saved, PaymentOptionDTO.Info.class);
	}
}