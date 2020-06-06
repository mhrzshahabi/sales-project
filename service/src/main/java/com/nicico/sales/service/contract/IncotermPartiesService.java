package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.IncotermPartiesDTO;
import com.nicico.sales.iservice.contract.IIncotermPartiesService;
import com.nicico.sales.model.entities.contract.IncotermParties;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class IncotermPartiesService extends GenericService<IncotermParties, Long, IncotermPartiesDTO.Create, IncotermPartiesDTO.Info, IncotermPartiesDTO.Update, IncotermPartiesDTO.Delete> implements IIncotermPartiesService {
}
