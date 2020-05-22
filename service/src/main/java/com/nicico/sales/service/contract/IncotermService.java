package com.nicico.sales.service.contract;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.IncotermDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.contract.IIncotermService;
import com.nicico.sales.model.entities.contract.Incoterm;
import com.nicico.sales.model.entities.contract.IncotermRules;
import com.nicico.sales.model.entities.contract.IncotermSteps;
import com.nicico.sales.repository.contract.IncotermDetailDAO;
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
    private final IncotermDetailDAO incotermDetailDAO;

    @Override
    @Transactional
    @Action(ActionType.Create)
    public IncotermDTO.Info create(IncotermDTO.Create request) {

        IncotermDTO.Info incoterm = super.create(request);

        List<IncotermSteps> incotermStepsCreateList = new ArrayList<>();
        request.getIncotermStepIds().forEach(item -> {
            IncotermSteps incotermSteps = new IncotermSteps();
            incotermSteps.setIncotermStepId(item);
            incotermSteps.setIncotermId(incoterm.getId());
            incotermStepsCreateList.add(incotermSteps);
        });
        incotermStepsDAO.saveAll(incotermStepsCreateList);

        List<IncotermRules> incotermRulesCreateList = new ArrayList<>();
        request.getIncotermRuleIds().forEach(item -> {
            IncotermRules incotermRules = new IncotermRules();
            incotermRules.setIncotermRuleId(item);
            incotermRules.setIncotermId(incoterm.getId());
            incotermRulesCreateList.add(incotermRules);
        });
        incotermRulesDAO.saveAll(incotermRulesCreateList);

        return incoterm;
    }

    @Override
    @Transactional
    @Action(ActionType.Update)
    public IncotermDTO.Info update(Long id, IncotermDTO.Update request) {

        IncotermDTO.Info incoterm = super.update(id, request);

        if (incotermDetailDAO.countByIncotermId(id) == 0) {

            incotermStepsDAO.deleteAllByIncotermId(id);
            List<IncotermSteps> incotermStepsCreateList = new ArrayList<>();
            request.getIncotermStepIds().forEach(item -> {
                IncotermSteps incotermSteps = new IncotermSteps();
                incotermSteps.setIncotermStepId(item);
                incotermSteps.setIncotermId(incoterm.getId());
                incotermStepsCreateList.add(incotermSteps);
            });
            incotermStepsDAO.saveAll(incotermStepsCreateList);

            incotermRulesDAO.deleteAllByIncotermId(id);
            List<IncotermRules> incotermRulesCreateList = new ArrayList<>();
            request.getIncotermRuleIds().forEach(item -> {
                IncotermRules incotermRules = new IncotermRules();
                incotermRules.setIncotermRuleId(item);
                incotermRules.setIncotermId(incoterm.getId());
                incotermRulesCreateList.add(incotermRules);
            });
            incotermRulesDAO.saveAll(incotermRulesCreateList);
        }

        return incoterm;
    }
}
