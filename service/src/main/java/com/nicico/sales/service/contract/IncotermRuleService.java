package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.IncotermRuleDTO;
import com.nicico.sales.iservice.contract.IIncotermRuleService;
import com.nicico.sales.model.entities.contract.IncotermRule;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class IncotermRuleService extends GenericService<IncotermRule, Long, IncotermRuleDTO.Create, IncotermRuleDTO.Info, IncotermRuleDTO.Update, IncotermRuleDTO.Delete> implements IIncotermRuleService {
}