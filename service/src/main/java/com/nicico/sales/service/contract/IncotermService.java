package com.nicico.sales.service.contract;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.IncotermDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.contract.IIncotermService;
import com.nicico.sales.model.entities.contract.Incoterm;
import com.nicico.sales.model.entities.contract.IncotermRules;
import com.nicico.sales.model.entities.contract.IncotermSteps;
import com.nicico.sales.repository.contract.IncotermRulesDAO;
import com.nicico.sales.repository.contract.IncotermStepsDAO;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class IncotermService extends GenericService<Incoterm, Long, IncotermDTO.Create, IncotermDTO.Info, IncotermDTO.Update, IncotermDTO.Delete> implements IIncotermService {

    private final IncotermStepsDAO incotermStepsDAO;
    private final IncotermRulesDAO incotermRulesDAO;

    @Override
    @Transactional
    @Action(ActionType.Create)
    public IncotermDTO.Info create(IncotermDTO.Create request) {

        IncotermDTO.Info incoterm = super.create(request);

        List<IncotermSteps> incotermStepsCreateList = new ArrayList<>();
        request.getIncotermStepIds().forEach(item -> {
            IncotermSteps incotermSteps = new IncotermSteps();
            incotermSteps.setIncotermId(item);
            incotermSteps.setIncotermId(incoterm.getId());
            incotermStepsCreateList.add(incotermSteps);
        });
        incotermStepsDAO.saveAll(incotermStepsCreateList);

        List<IncotermRules> incotermRulesCreateList = new ArrayList<>();
        request.getIncotermRuleIds().forEach(item -> {
            IncotermRules incotermRules = new IncotermRules();
            incotermRules.setIncotermId(item);
            incotermRules.setIncotermId(incoterm.getId());
            incotermRulesCreateList.add(incotermRules);
        });
        incotermRulesDAO.saveAll(incotermRulesCreateList);

        return incoterm;
    }
}
