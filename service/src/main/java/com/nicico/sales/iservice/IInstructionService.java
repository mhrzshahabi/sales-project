package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InstructionDTO;

import java.util.List;

public interface IInstructionService {

	InstructionDTO.Info get(Long id);

	List<InstructionDTO.Info> list();

	InstructionDTO.Info create(InstructionDTO.Create request);

	InstructionDTO.Info update(Long id, InstructionDTO.Update request);

	void delete(Long id);

	void delete(InstructionDTO.Delete request);

	SearchDTO.SearchRs<InstructionDTO.Info> search(SearchDTO.SearchRq request);

	TotalResponse<InstructionDTO.Info> search(NICICOCriteria criteria);
}
