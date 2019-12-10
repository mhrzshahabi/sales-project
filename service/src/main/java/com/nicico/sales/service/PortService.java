package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.BankDTO;
import com.nicico.sales.dto.PortDTO;
import com.nicico.sales.iservice.IPortService;
import com.nicico.sales.model.entities.base.Port;
import com.nicico.sales.repository.PortDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class PortService implements IPortService {

	private final PortDAO portDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public PortDTO.Info get(Long id) {
		final Optional<Port> slById = portDAO.findById(id);
		final Port port = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.PortNotFound));

		return modelMapper.map(port, PortDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<PortDTO.Info> list() {
		final List<Port> slAll = portDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<PortDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public PortDTO.Info create(PortDTO.Create request) {
		final Port port = modelMapper.map(request, Port.class);

		return save(port);
	}

	@Transactional
	@Override
	public PortDTO.Info update(Long id, PortDTO.Update request) {
		final Optional<Port> slById = portDAO.findById(id);
		final Port port = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.PortNotFound));

		Port updating = new Port();
		modelMapper.map(port, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		portDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(PortDTO.Delete request) {
		final List<Port> ports = portDAO.findAllById(request.getIds());

		portDAO.deleteAll(ports);
	}

	@Transactional(readOnly = true)
	@Override
//    @PreAuthorize("hasAuthority('R_BANK')")
	public TotalResponse<PortDTO.Info> search(NICICOCriteria criteria) {
		return SearchUtil.search(portDAO, criteria, port -> modelMapper.map(port, PortDTO.Info.class));
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<PortDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(portDAO, request, port -> modelMapper.map(port, PortDTO.Info.class));
	}

	// ------------------------------

	private PortDTO.Info save(Port port) {
		final Port saved = portDAO.saveAndFlush(port);
		return modelMapper.map(saved, PortDTO.Info.class);
	}
}
