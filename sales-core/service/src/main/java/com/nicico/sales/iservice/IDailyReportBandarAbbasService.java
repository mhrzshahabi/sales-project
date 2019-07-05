package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.DailyReportBandarAbbasDTO;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface IDailyReportBandarAbbasService {

	DailyReportBandarAbbasDTO.Info get(Long id);

	List<DailyReportBandarAbbasDTO.Info> list();

	DailyReportBandarAbbasDTO.Info create(DailyReportBandarAbbasDTO.Create request);

	DailyReportBandarAbbasDTO.Info update(Long id, DailyReportBandarAbbasDTO.Update request);

	void delete(Long id);

	void delete(DailyReportBandarAbbasDTO.Delete request);

	SearchDTO.SearchRs<DailyReportBandarAbbasDTO.Info> search(SearchDTO.SearchRq request);

	@Transactional
	List<Object[]> findByDateAndWarehouseNo(String date, String warehouseNo);
}
