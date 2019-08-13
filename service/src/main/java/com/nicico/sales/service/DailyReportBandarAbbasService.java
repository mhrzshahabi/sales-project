package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.DailyReportBandarAbbasDTO;
import com.nicico.sales.iservice.IDailyReportBandarAbbasService;
import com.nicico.sales.model.entities.base.DailyReportBandarAbbas;
import com.nicico.sales.repository.DailyReportBandarAbbasDAO;
import com.nicico.sales.repository.MaterialDAO;
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
	private final DailyReportBandarAbbasDAO dailyReportBandarAbbasDAO;
	private final MaterialDAO materialDAO;

	@Transactional(readOnly = true)
	public DailyReportBandarAbbasDTO.Info get(Long id) {
		final Optional<DailyReportBandarAbbas> slById = dailyReportBandarAbbasDAO.findById(id);
		final DailyReportBandarAbbas dailyReportBandarAbbas = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.DailyReportBandarAbbasNotFound));

		return modelMapper.map(dailyReportBandarAbbas, DailyReportBandarAbbasDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<DailyReportBandarAbbasDTO.Info> list() {
		final List<DailyReportBandarAbbas> slAll = dailyReportBandarAbbasDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<DailyReportBandarAbbasDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public DailyReportBandarAbbasDTO.Info create(DailyReportBandarAbbasDTO.Create request) {
		final DailyReportBandarAbbas dailyReportBandarAbbas = modelMapper.map(request, DailyReportBandarAbbas.class);

		return save(dailyReportBandarAbbas);
	}

	@Transactional
	@Override
	public DailyReportBandarAbbasDTO.Info update(Long id, DailyReportBandarAbbasDTO.Update request) {
		final Optional<DailyReportBandarAbbas> slById = dailyReportBandarAbbasDAO.findById(id);
		final DailyReportBandarAbbas dailyReportBandarAbbas = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.DailyReportBandarAbbasNotFound));

		DailyReportBandarAbbas updating = new DailyReportBandarAbbas();
		modelMapper.map(dailyReportBandarAbbas, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		dailyReportBandarAbbasDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(DailyReportBandarAbbasDTO.Delete request) {
		final List<DailyReportBandarAbbas> dailyReportBandarAbbass = dailyReportBandarAbbasDAO.findAllById(request.getIds());

		dailyReportBandarAbbasDAO.deleteAll(dailyReportBandarAbbass);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<DailyReportBandarAbbasDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(dailyReportBandarAbbasDAO, request, dailyReportBandarAbbas -> modelMapper.map(dailyReportBandarAbbas, DailyReportBandarAbbasDTO.Info.class));
	}

	// ------------------------------

	private DailyReportBandarAbbasDTO.Info save(DailyReportBandarAbbas dailyReportBandarAbbas) {
		final DailyReportBandarAbbas saved = dailyReportBandarAbbasDAO.saveAndFlush(dailyReportBandarAbbas);
		return modelMapper.map(saved, DailyReportBandarAbbasDTO.Info.class);
	}

	public List<Object[]> findByDateAndWarehouseNo(String date, String warehouseNo) {
		return dailyReportBandarAbbasDAO.findByDateAndWarehouseNo(date, warehouseNo);

	}
}
