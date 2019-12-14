package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InstructionDTO;
import com.nicico.sales.iservice.IInstructionService;
import com.nicico.sales.model.entities.base.Instruction;
import com.nicico.sales.repository.InstructionDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class InstructionService implements IInstructionService {

	private final InstructionDAO instructionDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public InstructionDTO.Info get(Long id) {
		final Optional<Instruction> slById = instructionDAO.findById(id);
		final Instruction instruction = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InstructionNotFound));

		return modelMapper.map(instruction, InstructionDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<InstructionDTO.Info> list() {
		final List<Instruction> slAll = instructionDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<InstructionDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public InstructionDTO.Info create(InstructionDTO.Create request) {
		final Instruction instruction = modelMapper.map(request, Instruction.class);

		return save(instruction);
	}

	@Transactional
	@Override
	public InstructionDTO.Info update(Long id, InstructionDTO.Update request) {
		final Optional<Instruction> slById = instructionDAO.findById(id);
		final Instruction instruction = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InstructionNotFound));

		Instruction updating = new Instruction();
		modelMapper.map(instruction, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		instructionDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(InstructionDTO.Delete request) {
		final List<Instruction> instructions = instructionDAO.findAllById(request.getIds());

		instructionDAO.deleteAll(instructions);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<InstructionDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(instructionDAO, request, instruction -> modelMapper.map(instruction, InstructionDTO.Info.class));
	}

	@Transactional(readOnly = true)
	@Override
//    @PreAuthorize("hasAuthority('R_BANK')")
	public TotalResponse<InstructionDTO.Info> search(NICICOCriteria criteria) {
		return SearchUtil.search(instructionDAO, criteria, instruction -> modelMapper.map(instruction, InstructionDTO.Info.class));
	}

	// ------------------------------

	private InstructionDTO.Info save(Instruction instruction) {
		final Instruction saved = instructionDAO.saveAndFlush(instruction);
		return modelMapper.map(saved, InstructionDTO.Info.class);
	}
}
