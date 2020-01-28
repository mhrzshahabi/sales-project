package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.MaterialItemDTO;

import java.util.List;

public interface IMaterialItemService {

	MaterialItemDTO.Info get(Long id);

	List<MaterialItemDTO.Info> list();

	MaterialItemDTO.Info create(MaterialItemDTO.Create request);

	MaterialItemDTO.Info update(Long id, MaterialItemDTO.Update request);

	void delete(Long id);

	void delete(MaterialItemDTO.Delete request);

	TotalResponse<MaterialItemDTO.Info> search(NICICOCriteria criteria);
}
