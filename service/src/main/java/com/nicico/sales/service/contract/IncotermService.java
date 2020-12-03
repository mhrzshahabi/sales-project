package com.nicico.sales.service.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.IncotermDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.contract.IIncotermService;
import com.nicico.sales.model.entities.contract.Incoterm;
import com.nicico.sales.model.entities.contract.IncotermForms;
import com.nicico.sales.model.entities.contract.IncotermRules;
import com.nicico.sales.model.entities.contract.IncotermSteps;
import com.nicico.sales.repository.contract.IncotermDetailDAO;
import com.nicico.sales.repository.contract.IncotermFormsDAO;
import com.nicico.sales.repository.contract.IncotermRulesDAO;
import com.nicico.sales.repository.contract.IncotermStepsDAO;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class IncotermService extends GenericService<Incoterm, Long, IncotermDTO.Create, IncotermDTO.Info, IncotermDTO.Update, IncotermDTO.Delete> implements IIncotermService {

    private final IncotermStepsDAO incotermStepsDAO;
    private final IncotermRulesDAO incotermRulesDAO;
    private final IncotermFormsDAO incotermFormsDAO;
    private final IncotermDetailDAO incotermDetailDAO;
    private final EntityManager entityManager;

    @Override
    @Transactional
    @Action(value = ActionType.Create, authority = "" +
            "hasAuthority('C_INCOTERM') AND " +
            "hasAuthority('C_INCOTERM_STEPS') AND " +
            "hasAuthority('C_INCOTERM_RULES') AND " +
            "hasAuthority('C_INCOTERM_FORMS')")
    public IncotermDTO.Info create(IncotermDTO.Create request) {

        IncotermDTO.Info incoterm = super.create(request);

        List<IncotermSteps> incotermStepsCreateList = new ArrayList<>();
        request.getIncotermSteps().forEach(item -> {
            IncotermSteps incotermSteps = new IncotermSteps();
            incotermSteps.setIncotermStepId(item.getIncotermStepId()).
                    setOrder(item.getOrder()).
                    setIncotermId(incoterm.getId());
            incotermStepsCreateList.add(incotermSteps);
        });
        incotermStepsDAO.saveAll(incotermStepsCreateList);

        request.getIncotermRules().forEach(item -> {
            IncotermRules incotermRules = new IncotermRules();
            incotermRules.setIncotermId(incoterm.getId()).
                    setOrder(item.getOrder()).
                    setIncotermRuleId(item.getIncotermRuleId());
            IncotermRules savedIncotermRules = incotermRulesDAO.save(incotermRules);

            if (item.getIncotermForms() == null || item.getIncotermForms().size() == 0)
                return;

            List<IncotermForms> incotermFormsCreateList = new ArrayList<>();
            item.getIncotermForms().forEach(formTuple -> {
                IncotermForms incotermForms = new IncotermForms();
                incotermForms.setIncotermRulesId(savedIncotermRules.getId()).
                        setIncotermFormId(formTuple.getIncotermFormId()).
                        setOrder(formTuple.getOrder());
                incotermFormsCreateList.add(incotermForms);
            });
            incotermFormsDAO.saveAll(incotermFormsCreateList);
        });

        return incoterm;
    }

    @Override
    @Transactional
    @Action(value = ActionType.Update, authority = "" +
            "hasAuthority('U_INCOTERM') AND " +
            "hasAuthority('U_INCOTERM_STEPS') AND " +
            "hasAuthority('U_INCOTERM_RULES') AND " +
            "hasAuthority('U_INCOTERM_FORMS')")
    public IncotermDTO.Info update(Long id, IncotermDTO.Update request) {

        IncotermDTO.Info incoterm = super.update(id, request);

        if (incotermDetailDAO.countByIncotermId(id) == 0) {

            incotermStepsDAO.deleteAllByIncotermId(id);
            List<IncotermSteps> incotermStepsCreateList = new ArrayList<>();
            request.getIncotermSteps().forEach(item -> {
                IncotermSteps incotermSteps = new IncotermSteps();
                incotermSteps.setIncotermStepId(item.getIncotermStepId()).
                        setOrder(item.getOrder()).
                        setIncotermId(incoterm.getId());
                incotermStepsCreateList.add(incotermSteps);
            });
            incotermStepsDAO.saveAll(incotermStepsCreateList);

            incotermRulesDAO.deleteAllByIncotermId(id);
            incotermFormsDAO.deleteAll(incotermFormsDAO.findAllByIncotermId(id));
            request.getIncotermRules().forEach(item -> {
                IncotermRules incotermRules = new IncotermRules();
                incotermRules.setIncotermId(incoterm.getId()).
                        setOrder(item.getOrder()).
                        setIncotermRuleId(item.getIncotermRuleId());
                IncotermRules savedIncotermRules = incotermRulesDAO.save(incotermRules);

                if (item.getIncotermForms() == null || item.getIncotermForms().size() == 0)
                    return;

                List<IncotermForms> incotermFormsCreateList = new ArrayList<>();
                item.getIncotermForms().forEach(formTuple -> {
                    IncotermForms incotermForms = new IncotermForms();
                    incotermForms.setIncotermRulesId(savedIncotermRules.getId()).
                            setIncotermFormId(formTuple.getIncotermFormId()).
                            setOrder(formTuple.getOrder());
                    incotermFormsCreateList.add(incotermForms);
                });
                incotermFormsDAO.saveAll(incotermFormsCreateList);
            });
        }

        return incoterm;
    }

    @Override
    @Transactional
    @Action(value = ActionType.Delete, authority = "" +
            "hasAuthority('D_INCOTERM') AND " +
            "hasAuthority('D_INCOTERM_STEPS') AND " +
            "hasAuthority('D_INCOTERM_RULES') AND " +
            "hasAuthority('D_INCOTERM_FORMS') AND " +
            "hasAuthority('D_INCOTERM_DETAIL') AND " +
            "hasAuthority('D_INCOTERM_PARTIES')")
    public void delete(Long id) {

        incotermDetailDAO.deleteAll(incotermDetailDAO.findAllByIncotermId(id));
        super.delete(id);
    }

    @Action(value = ActionType.List)
    @Transactional(readOnly = true)
    public TotalResponse<IncotermDTO.ViewForContract> getIncotermsForShowInContract(NICICOCriteria request) {

        List<Incoterm> entities = new ArrayList<>();
        TotalResponse<IncotermDTO.ViewForContract> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            IncotermDTO.ViewForContract eResult = modelMapper.map(entity, IncotermDTO.ViewForContract.class);
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }
}
