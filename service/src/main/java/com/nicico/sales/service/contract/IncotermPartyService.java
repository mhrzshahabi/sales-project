package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.IncotermPartyDTO;
import com.nicico.sales.iservice.contract.IIncotermPartyService;
import com.nicico.sales.model.entities.contract.IncotermParty;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class IncotermPartyService extends GenericService<IncotermParty, Long, IncotermPartyDTO.Create, IncotermPartyDTO.Info, IncotermPartyDTO.Update, IncotermPartyDTO.Delete> implements IIncotermPartyService {
}
