package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InspectionContractDTO;
import com.nicico.sales.iservice.IInspectionContractService;
import com.nicico.sales.model.entities.base.InspectionContract;
import com.nicico.sales.repository.InspectionContractDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class InspectionContractService implements IInspectionContractService {

	private final InspectionContractDAO inspectionContractDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public InspectionContractDTO.Info get(Long id) {
		final Optional<InspectionContract> slById = inspectionContractDAO.findById(id);
		final InspectionContract inspectionContract = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InspectionContractNotFound));

		return modelMapper.map(inspectionContract, InspectionContractDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<InspectionContractDTO.Info> list() {
		final List<InspectionContract> slAll = inspectionContractDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<InspectionContractDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public InspectionContractDTO.Info create(InspectionContractDTO.Create request) {
		final InspectionContract inspectionContract = modelMapper.map(request, InspectionContract.class);

		return save(inspectionContract);
	}

	@Transactional
	@Override
	public InspectionContractDTO.Info update(Long id, InspectionContractDTO.Update request) {
		final Optional<InspectionContract> slById = inspectionContractDAO.findById(id);
		final InspectionContract inspectionContract = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InspectionContractNotFound));

		InspectionContract updating = new InspectionContract();
		modelMapper.map(inspectionContract, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		inspectionContractDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(InspectionContractDTO.Delete request) {
		final List<InspectionContract> inspectionContracts = inspectionContractDAO.findAllById(request.getIds());

		inspectionContractDAO.deleteAll(inspectionContracts);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<InspectionContractDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(inspectionContractDAO, request, inspectionContract -> modelMapper.map(inspectionContract, InspectionContractDTO.Info.class));
	}

	// ------------------------------

	private InspectionContractDTO.Info save(InspectionContract inspectionContract) {
		final InspectionContract saved = inspectionContractDAO.saveAndFlush(inspectionContract);
		return modelMapper.map(saved, InspectionContractDTO.Info.class);
	}
}
