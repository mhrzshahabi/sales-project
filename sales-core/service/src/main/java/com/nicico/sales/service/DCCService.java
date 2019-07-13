package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.DCCDTO;
import com.nicico.sales.iservice.IDCCService;
import com.nicico.sales.model.entities.base.DCC;
import com.nicico.sales.repository.DCCDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class DCCService implements IDCCService {

	private final DCCDAO dCCDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public DCCDTO.Info get(Long id) {
		final Optional<DCC> slById = dCCDAO.findById(id);
		final DCC dCC = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.DCCNotFound));

		return modelMapper.map(dCC, DCCDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<DCCDTO.Info> list() {
		final List<DCC> slAll = dCCDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<DCCDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public DCCDTO.Info create(DCCDTO.Create request) {
		final DCC dCC = modelMapper.map(request, DCC.class);

		return save(dCC);
	}

	@Transactional
	@Override
	public DCCDTO.Info update(Long id, DCCDTO.Update request) {
		final Optional<DCC> slById = dCCDAO.findById(id);
		final DCC dCC = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.DCCNotFound));

		DCC updating = new DCC();
		modelMapper.map(dCC, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		dCCDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(DCCDTO.Delete request) {
		final List<DCC> dCCs = dCCDAO.findAllById(request.getIds());

		dCCDAO.deleteAll(dCCs);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<DCCDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(dCCDAO, request, dCC -> modelMapper.map(dCC, DCCDTO.Info.class));
	}

	// ------------------------------

	private DCCDTO.Info save(DCC dCC) {
		final DCC saved = dCCDAO.saveAndFlush(dCC);
		return modelMapper.map(saved, DCCDTO.Info.class);
	}
}
