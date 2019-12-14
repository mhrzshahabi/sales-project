package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InvoiceItemDTO;
import com.nicico.sales.iservice.IInvoiceItemService;
import com.nicico.sales.model.entities.base.InvoiceItem;
import com.nicico.sales.repository.InvoiceItemDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class InvoiceItemService implements IInvoiceItemService {

	private final InvoiceItemDAO invoiceItemDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public InvoiceItemDTO.Info get(Long id) {
		final Optional<InvoiceItem> slById = invoiceItemDAO.findById(id);
		final InvoiceItem invoiceItemItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceItemNotFound));

		return modelMapper.map(invoiceItemItem, InvoiceItemDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<InvoiceItemDTO.Info> list() {
		final List<InvoiceItem> slAll = invoiceItemDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<InvoiceItemDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public InvoiceItemDTO.Info create(InvoiceItemDTO.Create request) {
		final InvoiceItem invoiceItem = modelMapper.map(request, InvoiceItem.class);

		return save(invoiceItem);
	}

	@Transactional
	@Override
	public InvoiceItemDTO.Info update(Long id, InvoiceItemDTO.Update request) {
		final Optional<InvoiceItem> slById = invoiceItemDAO.findById(id);
		final InvoiceItem invoiceItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceItemNotFound));

		InvoiceItem updating = new InvoiceItem();
		modelMapper.map(invoiceItem, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		invoiceItemDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(InvoiceItemDTO.Delete request) {
		final List<InvoiceItem> invoiceItems = invoiceItemDAO.findAllById(request.getIds());

		invoiceItemDAO.deleteAll(invoiceItems);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<InvoiceItemDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(invoiceItemDAO, request, invoiceItem -> modelMapper.map(invoiceItem, InvoiceItemDTO.Info.class));
	}

	@Transactional(readOnly = true)
	@Override
//    @PreAuthorize("hasAuthority('R_BANK')")
	public TotalResponse<InvoiceItemDTO.Info> search(NICICOCriteria criteria) {
		return SearchUtil.search(invoiceItemDAO, criteria, invoiceItem -> modelMapper.map(invoiceItem, InvoiceItemDTO.Info.class));
	}

	// ------------------------------

	private InvoiceItemDTO.Info save(InvoiceItem invoiceItem) {
		final InvoiceItem saved = invoiceItemDAO.saveAndFlush(invoiceItem);
		return modelMapper.map(saved, InvoiceItemDTO.Info.class);
	}
}
