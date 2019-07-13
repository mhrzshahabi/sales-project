package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContractAttachmentDTO;
import com.nicico.sales.iservice.IContractAttachmentService;
import com.nicico.sales.model.entities.base.ContractAttachment;
import com.nicico.sales.repository.ContractAttachmentDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContractAttachmentService implements IContractAttachmentService {

	private final ContractAttachmentDAO contractAttachmentDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ContractAttachmentDTO.Info get(Long id) {
		final Optional<ContractAttachment> slById = contractAttachmentDAO.findById(id);
		final ContractAttachment contractAttachment = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractAttachmentNotFound));

		return modelMapper.map(contractAttachment, ContractAttachmentDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ContractAttachmentDTO.Info> list() {
		final List<ContractAttachment> slAll = contractAttachmentDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ContractAttachmentDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ContractAttachmentDTO.Info create(ContractAttachmentDTO.Create request) {
		final ContractAttachment contractAttachment = modelMapper.map(request, ContractAttachment.class);

		return save(contractAttachment);
	}

	@Transactional
	@Override
	public ContractAttachmentDTO.Info update(Long id, ContractAttachmentDTO.Update request) {
		final Optional<ContractAttachment> slById = contractAttachmentDAO.findById(id);
		final ContractAttachment contractAttachment = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractAttachmentNotFound));

		ContractAttachment updating = new ContractAttachment();
		modelMapper.map(contractAttachment, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		contractAttachmentDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ContractAttachmentDTO.Delete request) {
		final List<ContractAttachment> contractAttachments = contractAttachmentDAO.findAllById(request.getIds());

		contractAttachmentDAO.deleteAll(contractAttachments);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ContractAttachmentDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(contractAttachmentDAO, request, contractAttachment -> modelMapper.map(contractAttachment, ContractAttachmentDTO.Info.class));
	}

	// ------------------------------

	private ContractAttachmentDTO.Info save(ContractAttachment contractAttachment) {
		final ContractAttachment saved = contractAttachmentDAO.saveAndFlush(contractAttachment);
		return modelMapper.map(saved, ContractAttachmentDTO.Info.class);
	}
}
