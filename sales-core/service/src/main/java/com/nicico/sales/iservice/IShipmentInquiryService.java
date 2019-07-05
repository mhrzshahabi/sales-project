package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentInquiryDTO;

import java.util.List;

public interface IShipmentInquiryService {

	ShipmentInquiryDTO.Info get(Long id);

	List<ShipmentInquiryDTO.Info> list();

	ShipmentInquiryDTO.Info create(ShipmentInquiryDTO.Create request);

	ShipmentInquiryDTO.Info update(Long id, ShipmentInquiryDTO.Update request);

	void delete(Long id);

	void delete(ShipmentInquiryDTO.Delete request);

	SearchDTO.SearchRs<ShipmentInquiryDTO.Info> search(SearchDTO.SearchRq request);
}
