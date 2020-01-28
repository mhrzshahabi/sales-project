package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.MaterialFeatureDTO;

import java.util.List;

public interface IMaterialFeatureService {

	MaterialFeatureDTO.Info get(Long id);

	List<MaterialFeatureDTO.Info> list();

	MaterialFeatureDTO.Info create(MaterialFeatureDTO.Create request);

	MaterialFeatureDTO.Info update(Long id, MaterialFeatureDTO.Update request);

	void delete(Long id);

	void delete(MaterialFeatureDTO.Delete request);

	TotalResponse<MaterialFeatureDTO.Info> search(NICICOCriteria criteria);
}
