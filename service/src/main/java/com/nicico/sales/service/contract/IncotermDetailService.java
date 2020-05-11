package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.IncotermDetailDTO;
import com.nicico.sales.iservice.contract.IIncotermDetailService;
import com.nicico.sales.model.entities.contract.IncotermDetail;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class IncotermDetailService extends GenericService<IncotermDetail, Long, IncotermDetailDTO.Create, IncotermDetailDTO.Info, IncotermDetailDTO.Update, IncotermDetailDTO.Delete> implements IIncotermDetailService {
}