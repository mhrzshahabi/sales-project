package com.nicico.sales.service;

import com.nicico.sales.dto.RemittanceViewDTO;
import com.nicico.sales.iservice.IRemittanceViewService;
import com.nicico.sales.model.entities.warehouse.RemittanceView;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class RemittanceViewService extends GenericService<RemittanceView, Long, RemittanceViewDTO.Create,
        RemittanceViewDTO.Info, RemittanceViewDTO.Update, RemittanceViewDTO.Delete> implements IRemittanceViewService {
}
