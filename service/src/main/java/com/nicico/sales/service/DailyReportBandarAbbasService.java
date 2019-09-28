package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.DailyReportBandarAbbasDTO;
import com.nicico.sales.iservice.IDailyReportBandarAbbasService;
import com.nicico.sales.model.entities.base.DailyReportBandarAbbas;
import com.nicico.sales.model.entities.base.myModel.WholeDto;
import com.nicico.sales.repository.DailyReportBandarAbbasDAO;
import com.nicico.sales.repository.MaterialDAO;
import com.nicico.sales.repository.WholeDtoDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class DailyReportBandarAbbasService implements IDailyReportBandarAbbasService {

	private final ModelMapper modelMapper;
	//private final DailyReportBandarAbbasDAO wholeDtoDAO;
	private final WholeDtoDAO wholeDtoDAO;
	private final MaterialDAO materialDAO;

	@Transactional(readOnly = true)
	public DailyReportBandarAbbasDTO.Info get(Long id) {
		//final Optional<DailyReportBandarAbbas> slById = wholeDtoDAO.findById(id);
		final Optional<WholeDto> slById = wholeDtoDAO.findById(id);
		//final DailyReportBandarAbbas dailyReportBandarAbbas = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.DailyReportBandarAbbasNotFound));
		final WholeDto dailyReportBandarAbbas = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.DailyReportBandarAbbasNotFound));

		return modelMapper.map(dailyReportBandarAbbas, DailyReportBandarAbbasDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<DailyReportBandarAbbasDTO.Info> list() {
		final List<WholeDto> slAll = wholeDtoDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<DailyReportBandarAbbasDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public DailyReportBandarAbbasDTO.Info create(DailyReportBandarAbbasDTO.Create request) {
		final WholeDto dailyReportBandarAbbas = modelMapper.map(request, WholeDto.class);

		return save(dailyReportBandarAbbas);
	}

	@Transactional
	@Override
	public DailyReportBandarAbbasDTO.Info update(Long id, DailyReportBandarAbbasDTO.Update request) {
		final Optional<WholeDto> slById = wholeDtoDAO.findById(id);
		final WholeDto dailyReportBandarAbbas = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.DailyReportBandarAbbasNotFound));

		WholeDto updating = new WholeDto();
		modelMapper.map(dailyReportBandarAbbas, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		wholeDtoDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(DailyReportBandarAbbasDTO.Delete request) {
		final List<WholeDto> dailyReportBandarAbbass = wholeDtoDAO.findAllById(request.getIds());

		wholeDtoDAO.deleteAll(dailyReportBandarAbbass);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<DailyReportBandarAbbasDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(wholeDtoDAO, request, dailyReportBandarAbbas -> modelMapper.map(dailyReportBandarAbbas, DailyReportBandarAbbasDTO.Info.class));
	}

	// ------------------------------

	private DailyReportBandarAbbasDTO.Info save(WholeDto dailyReportBandarAbbas) {
		final WholeDto saved = wholeDtoDAO.saveAndFlush(dailyReportBandarAbbas);
		return modelMapper.map(saved, DailyReportBandarAbbasDTO.Info.class);
	}

	public List<WholeDto> findByDateAndWarehouse(String date, String warehouse) {
		return wholeDtoDAO.findByDateAndWarehouse(date, warehouse);

	}
}
