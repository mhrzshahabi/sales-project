package com.nicico.sales.service;

import com.nicico.sales.dto.RemittanceDTO;
import com.nicico.sales.iservice.IRemittanceService;
import com.nicico.sales.model.entities.warehouse.Remittance;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class RemittanceService extends GenericService<Remittance, Long, RemittanceDTO.Create, RemittanceDTO.Info, RemittanceDTO.Update, RemittanceDTO.Delete> implements IRemittanceService {

}
