package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.IncotermContactDTO;
import com.nicico.sales.iservice.contract.IIncotermContactService;
import com.nicico.sales.model.entities.contract.IncotermContact;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class IncotermContactService extends GenericService<IncotermContact, Long, IncotermContactDTO.Create, IncotermContactDTO.Info, IncotermContactDTO.Update, IncotermContactDTO.Delete> implements IIncotermContactService {
}