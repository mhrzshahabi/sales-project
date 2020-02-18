package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.CostDTO;
import com.nicico.sales.iservice.ICostService;
import com.nicico.sales.model.entities.base.Cost;
import com.nicico.sales.repository.CostDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class CostService implements ICostService {

    private final CostDAO costDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_COST')")
    public CostDTO.Info get(Long id) {
        final Optional<Cost> slById = costDAO.findById(id);
        final Cost cost = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.CostNotFound));

        return modelMapper.map(cost, CostDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_COST')")
    public List<CostDTO.Info> list() {
        final List<Cost> slAll = costDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<CostDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_COST')")
    public CostDTO.Info create(CostDTO.Create request) {
        final Cost cost = modelMapper.map(request, Cost.class);

        return save(cost);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_COST')")
    public CostDTO.Info update(Long id, CostDTO.Update request) {
        final Optional<Cost> slById = costDAO.findById(id);
        final Cost cost = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.CostNotFound));

        Cost updating = new Cost();
        modelMapper.map(cost, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_COST')")
    public void delete(Long id) {
        costDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_COST')")
    public void delete(CostDTO.Delete request) {
        final List<Cost> costs = costDAO.findAllById(request.getIds());

        costDAO.deleteAll(costs);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_COST')")
    public TotalResponse<CostDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(costDAO, criteria, cost -> modelMapper.map(cost, CostDTO.Info.class));
    }

    private CostDTO.Info save(Cost cost) {
        final Cost saved = costDAO.saveAndFlush(cost);
        return modelMapper.map(saved, CostDTO.Info.class);
    }
}
