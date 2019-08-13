package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ExportDTO;

import java.util.List;

public interface IExportService {

	ExportDTO.Info get(Long id);

	List<ExportDTO.Info> list();

	ExportDTO.Info create(ExportDTO.Create request);

	ExportDTO.Info update(Long id, ExportDTO.Update request);

	void delete(Long id);

	void delete(ExportDTO.Delete request);

	SearchDTO.SearchRs<ExportDTO.Info> search(SearchDTO.SearchRq request);
}
