package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.IncotermVersionDTO;
import com.nicico.sales.iservice.contract.IIncotermVersionService;
import com.nicico.sales.model.entities.contract.IncotermVersion;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class IncotermVersionService extends GenericService<IncotermVersion, Long, IncotermVersionDTO.Create, IncotermVersionDTO.Info, IncotermVersionDTO.Update, IncotermVersionDTO.Delete> implements IIncotermVersionService {
}
