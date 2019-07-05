package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ExportDTO;
import com.nicico.sales.iservice.IExportService;
import com.nicico.sales.model.entities.base.Export;
import com.nicico.sales.repository.ExportDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ExportService implements IExportService {

	private final ExportDAO exportDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ExportDTO.Info get(Long id) {
		final Optional<Export> slById = exportDAO.findById(id);
		final Export export = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ExportNotFound));

		return modelMapper.map(export, ExportDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ExportDTO.Info> list() {
		final List<Export> slAll = exportDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ExportDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ExportDTO.Info create(ExportDTO.Create request) {
		final Export export = modelMapper.map(request, Export.class);

		return save(export);
	}

	@Transactional
	@Override
	public ExportDTO.Info update(Long id, ExportDTO.Update request) {
		final Optional<Export> slById = exportDAO.findById(id);
		final Export export = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ExportNotFound));

		Export updating = new Export();
		modelMapper.map(export, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		exportDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ExportDTO.Delete request) {
		final List<Export> exports = exportDAO.findAllById(request.getIds());

		exportDAO.deleteAll(exports);
	}

	public SearchDTO.SearchRs<ExportDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(exportDAO, request, export -> modelMapper.map(export, ExportDTO.Info.class));
	}

	// ------------------------------

	private ExportDTO.Info save(Export export) {
		final Export saved = exportDAO.saveAndFlush(export);
		return modelMapper.map(saved, ExportDTO.Info.class);
	}
}
