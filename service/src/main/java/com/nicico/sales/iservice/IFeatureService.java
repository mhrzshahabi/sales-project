package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.FeatureDTO;

import java.util.List;

public interface IFeatureService {

	FeatureDTO.Info get(Long id);

	List<FeatureDTO.Info> list();

	FeatureDTO.Info create(FeatureDTO.Create request);

	FeatureDTO.Info update(Long id, FeatureDTO.Update request);

	void delete(Long id);

	void delete(FeatureDTO.Delete request);

	SearchDTO.SearchRs<FeatureDTO.Info> search(SearchDTO.SearchRq request);
}
