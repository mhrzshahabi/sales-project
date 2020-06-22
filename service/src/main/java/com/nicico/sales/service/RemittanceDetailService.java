package com.nicico.sales.service;

import com.nicico.sales.dto.RemittanceDetailDTO;
import com.nicico.sales.iservice.IRemittanceDetailService;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class RemittanceDetailService extends GenericService<RemittanceDetail, Long, RemittanceDetailDTO.Create, RemittanceDetailDTO.Info, RemittanceDetailDTO.Update, RemittanceDetailDTO.Delete> implements IRemittanceDetailService {

}
