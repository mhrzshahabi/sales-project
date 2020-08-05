package com.nicico.sales.iservice;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.sales.dto.RemittanceDTO;
import com.nicico.sales.model.entities.warehouse.Remittance;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JsonDataSource;
import org.springframework.util.MultiValueMap;

public interface IRemittanceService extends IGenericService<Remittance, Long, RemittanceDTO.Create, RemittanceDTO.Info, RemittanceDTO.Update, RemittanceDTO.Delete> {
    JsonDataSource print(MultiValueMap criteria) throws JsonProcessingException, JRException;
}
