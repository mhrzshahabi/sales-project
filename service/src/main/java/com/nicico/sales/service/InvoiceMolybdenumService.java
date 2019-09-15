package com.nicico.sales.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InvoiceDTO;
import com.nicico.sales.dto.InvoiceMolybdenumDTO;
import com.nicico.sales.iservice.IInvoiceMolybdenumService;
import com.nicico.sales.iservice.IInvoiceService;
import com.nicico.sales.model.entities.base.InvoiceMolybdenum;
import com.nicico.sales.repository.InvoiceMolybdenumDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class InvoiceMolybdenumService implements IInvoiceMolybdenumService {

	private final InvoiceMolybdenumDAO invoiceMolybdenumDAO;
	private final IInvoiceService invoiceService;
	private final ModelMapper modelMapper;
	private final ObjectMapper objectMapper;

	@Transactional(readOnly = true)
	public InvoiceMolybdenumDTO.Info get(Long id) {
		final Optional<InvoiceMolybdenum> slById = invoiceMolybdenumDAO.findById(id);
		final InvoiceMolybdenum invoiceMolybdenumMolybdenum = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceMolybdenumNotFound));

		return modelMapper.map(invoiceMolybdenumMolybdenum, InvoiceMolybdenumDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<InvoiceMolybdenumDTO.Info> list() {
		final List<InvoiceMolybdenum> slAll = invoiceMolybdenumDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<InvoiceMolybdenumDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public void molybdenum(String data) throws IOException {
		final Map<String, Object> map = objectMapper.readValue(data, Map.class);

		InvoiceDTO.Create c;
		InvoiceDTO.Update u;

		if (map.get("id") == null) {
			c = objectMapper.readValue(data, InvoiceDTO.Create.class);
			invoiceService.create(c);
		} else {
			u = objectMapper.readValue(data, InvoiceDTO.Update.class);
			invoiceService.update(u.getId(), u);
		}
		for (int i = 0; i <= 100; i++) {
			if (map.get("net" + i) == null)
				break;
			if (map.get("id" + i) == null) {
				InvoiceMolybdenumDTO.Create cc = new InvoiceMolybdenumDTO.Create();
				cc.setInvoiceId((new Float(map.get("invoiceId" + i).toString())).longValue());
				if (map.get("lotNo" + i) != null)
					cc.setLotNo(map.get("lotNo" + i).toString());
				if (map.get("grass" + i) != null)
					cc.setGrass(new Float(map.get("grass" + i).toString()));
				if (map.get("net" + i) != null)
					cc.setNet(new Float((map.get("net" + i).toString())));
				if (map.get("molybdenumPercent" + i) != null)
					cc.setMolybdenumPercent(new Float((map.get("molybdenumPercent" + i).toString())));
				if (map.get("copperPercent" + i) != null)
					cc.setCopperPercent(new Float((map.get("copperPercent" + i).toString())));
				if (map.get("molybdenumContent" + i) != null)
					cc.setMolybdenumContent(new Float((map.get("molybdenumContent" + i).toString())));
				if (map.get("discountPercent" + i) != null)
					cc.setDiscountPercent(new Float((map.get("discountPercent" + i).toString())));
				if (map.get("priceFee" + i) != null)
					cc.setPriceFee(new Float((map.get("priceFee" + i).toString())));
				if (map.get("price" + i) != null)
					cc.setPrice(new Float((map.get("price" + i).toString())));
				create(cc);
			} else {
				InvoiceMolybdenumDTO.Update uu = new InvoiceMolybdenumDTO.Update();
				uu.setId((new Float((map.get("id" + i).toString()))).longValue());
				uu.setInvoiceId((new Float(map.get("invoiceId" + i).toString())).longValue());
				if (map.get("lotNo" + i) != null)
					uu.setLotNo(map.get("lotNo" + i).toString());
				if (map.get("grass" + i) != null)
					uu.setGrass(new Float(map.get("grass" + i).toString()));
				if (map.get("net" + i) != null)
					uu.setNet(new Float((map.get("net" + i).toString())));
				if (map.get("molybdenumPercent" + i) != null)
					uu.setMolybdenumPercent(new Float((map.get("molybdenumPercent" + i).toString())));
				if (map.get("copperPercent" + i) != null)
					uu.setCopperPercent(new Float((map.get("copperPercent" + i).toString())));
				if (map.get("molybdenumContent" + i) != null)
					uu.setMolybdenumContent(new Float((map.get("molybdenumContent" + i).toString())));
				if (map.get("discountPercent" + i) != null)
					uu.setDiscountPercent(new Float((map.get("discountPercent" + i).toString())));
				if (map.get("priceFee" + i) != null)
					uu.setPriceFee(new Float((map.get("priceFee" + i).toString())));
				if (map.get("price" + i) != null)
					uu.setPrice(new Float((map.get("price" + i).toString())));
				if (map.get("version" + i) != null)
					uu.setVersion((new Float(map.get("version" + i).toString())).intValue());
				update((new Float((map.get("id" + i).toString()))).longValue(), uu);
			}
		}
	}

	@Transactional
	@Override
	public InvoiceMolybdenumDTO.Info create(InvoiceMolybdenumDTO.Create request) {
		final InvoiceMolybdenum invoiceMolybdenum = modelMapper.map(request, InvoiceMolybdenum.class);

		return save(invoiceMolybdenum);
	}

	@Transactional
	@Override
	public InvoiceMolybdenumDTO.Info update(Long id, InvoiceMolybdenumDTO.Update request) {
		final Optional<InvoiceMolybdenum> slById = invoiceMolybdenumDAO.findById(id);
		final InvoiceMolybdenum invoiceMolybdenum = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InvoiceMolybdenumNotFound));

		InvoiceMolybdenum updating = new InvoiceMolybdenum();
		modelMapper.map(invoiceMolybdenum, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		invoiceMolybdenumDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(InvoiceMolybdenumDTO.Delete request) {
		final List<InvoiceMolybdenum> invoiceMolybdenums = invoiceMolybdenumDAO.findAllById(request.getIds());

		invoiceMolybdenumDAO.deleteAll(invoiceMolybdenums);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<InvoiceMolybdenumDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(invoiceMolybdenumDAO, request, invoiceMolybdenum -> modelMapper.map(invoiceMolybdenum, InvoiceMolybdenumDTO.Info.class));
	}

	// ------------------------------

	private InvoiceMolybdenumDTO.Info save(InvoiceMolybdenum invoiceMolybdenum) {
		final InvoiceMolybdenum saved = invoiceMolybdenumDAO.saveAndFlush(invoiceMolybdenum);
		return modelMapper.map(saved, InvoiceMolybdenumDTO.Info.class);
	}
}
