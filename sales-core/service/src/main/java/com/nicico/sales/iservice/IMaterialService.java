package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.MaterialDTO;

import java.util.List;

public interface IMaterialService {

	MaterialDTO.Info get(Long id);

	List<MaterialDTO.Info> list();

	MaterialDTO.Info create(MaterialDTO.Create request);

	MaterialDTO.Info update(Long id, MaterialDTO.Update request);

	void delete(Long id);

	void delete(MaterialDTO.Delete request);

	SearchDTO.SearchRs<MaterialDTO.Info> search(SearchDTO.SearchRq request);
}
