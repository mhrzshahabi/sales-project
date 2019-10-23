package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.TozinDTO;
import com.nicico.sales.iservice.ITozinService;
import com.nicico.sales.model.entities.base.Tozin;
import com.nicico.sales.repository.TozinDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class TozinService implements ITozinService {

	private final TozinDAO tozinDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public TozinDTO.Info get(Long id) {
		final Optional<Tozin> slById = tozinDAO.findById(id);
		final Tozin tozin = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.TozinNotFound));

		return modelMapper.map(tozin, TozinDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<TozinDTO.Info> list() {
		final List<Tozin> slAll = tozinDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<TozinDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public TozinDTO.Info create(TozinDTO.Create request) {
		final Tozin tozin = modelMapper.map(request, Tozin.class);

		return save(tozin);
	}

	@Transactional
	@Override
	public TozinDTO.Info update(Long id, TozinDTO.Update request) {
		final Optional<Tozin> slById = tozinDAO.findById(id);
		final Tozin tozin = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.TozinNotFound));

		Tozin updating = new Tozin();
		modelMapper.map(tozin, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		tozinDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(TozinDTO.Delete request) {
		final List<Tozin> tozins = tozinDAO.findAllById(request.getIds());

		tozinDAO.deleteAll(tozins);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<TozinDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(tozinDAO, request, tozin -> modelMapper.map(tozin, TozinDTO.Info.class));
	}

	@Transactional(readOnly = true)
	@Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSECAD')")
	public  TotalResponse<TozinDTO.Info> searchTozin(NICICOCriteria criteria) {
		return SearchUtil.search(tozinDAO, criteria, tozin -> modelMapper.map(tozin, TozinDTO.Info.class));
	}

	// ------------------------------

	private TozinDTO.Info save(Tozin tozin) {
		final Tozin saved = tozinDAO.saveAndFlush(tozin);
		return modelMapper.map(saved, TozinDTO.Info.class);
	}


	public List<Object[]> findTransport2Plants(String date, String plantId) {
		return tozinDAO.findTransport2Plants(date, plantId);
	}

	;


	public String[] findPlants() {
		return tozinDAO.findPlants();
	}

	;
}
