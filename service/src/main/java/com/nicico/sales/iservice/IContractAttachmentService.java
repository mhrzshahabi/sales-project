package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractAttachmentDTO;

import java.util.List;

public interface IContractAttachmentService {

	ContractAttachmentDTO.Info get(Long id);

	List<ContractAttachmentDTO.Info> list();

	ContractAttachmentDTO.Info create(ContractAttachmentDTO.Create request);

	ContractAttachmentDTO.Info update(Long id, ContractAttachmentDTO.Update request);

	void delete(Long id);

	void delete(ContractAttachmentDTO.Delete request);

	SearchDTO.SearchRs<ContractAttachmentDTO.Info> search(SearchDTO.SearchRq request);
}
