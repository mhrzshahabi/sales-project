package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.MaterialFeatureDTO;

import java.util.List;

public interface IMaterialFeatureService {

	MaterialFeatureDTO.Info get(Long id);

	List<MaterialFeatureDTO.Info> list();

	MaterialFeatureDTO.Info create(MaterialFeatureDTO.Create request);

	MaterialFeatureDTO.Info update(Long id, MaterialFeatureDTO.Update request);

	void delete(Long id);

	void delete(MaterialFeatureDTO.Delete request);

	SearchDTO.SearchRs<MaterialFeatureDTO.Info> search(SearchDTO.SearchRq request);
}
