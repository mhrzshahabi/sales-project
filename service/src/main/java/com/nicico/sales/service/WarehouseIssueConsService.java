package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.WarehouseIssueConsDTO;
import com.nicico.sales.iservice.IWarehouseIssueConsService;
import com.nicico.sales.model.entities.base.WarehouseIssueCons;
import com.nicico.sales.repository.WarehouseIssueConsDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class WarehouseIssueConsService implements IWarehouseIssueConsService {

    private final WarehouseIssueConsDAO warehouseIssueConsDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUECONS')")
    public WarehouseIssueConsDTO.Info get(Long id) {
        final Optional<WarehouseIssueCons> slById = warehouseIssueConsDAO.findById(id);
        final WarehouseIssueCons warehouseIssueCons = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseIssueConsNotFound));

        return modelMapper.map(warehouseIssueCons, WarehouseIssueConsDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUECONS')")
    public List<WarehouseIssueConsDTO.Info> list() {
        final List<WarehouseIssueCons> slAll = warehouseIssueConsDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<WarehouseIssueConsDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('C_WAREHOUSEISSUECONS')")
    public WarehouseIssueConsDTO.Info create(WarehouseIssueConsDTO.Create request) {
        final WarehouseIssueCons warehouseIssueCons = modelMapper.map(request, WarehouseIssueCons.class);

        return save(warehouseIssueCons);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('U_WAREHOUSEISSUECONS')")
    public WarehouseIssueConsDTO.Info update(Long id, WarehouseIssueConsDTO.Update request) {
        final Optional<WarehouseIssueCons> slById = warehouseIssueConsDAO.findById(id);
        final WarehouseIssueCons warehouseIssueCons = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseIssueConsNotFound));

        WarehouseIssueCons updating = new WarehouseIssueCons();
        modelMapper.map(warehouseIssueCons, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_WAREHOUSEISSUECONS')")
    public void delete(Long id) {
        warehouseIssueConsDAO.deleteById(id);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_WAREHOUSEISSUECONS')")
    public void delete(WarehouseIssueConsDTO.Delete request) {
        final List<WarehouseIssueCons> warehouseIssueConss = warehouseIssueConsDAO.findAllById(request.getIds());

        warehouseIssueConsDAO.deleteAll(warehouseIssueConss);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUECONS')")
    public TotalResponse<WarehouseIssueConsDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(warehouseIssueConsDAO, criteria, warehouseIssueCons -> modelMapper.map(warehouseIssueCons, WarehouseIssueConsDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUECONS')")
    public SearchDTO.SearchRs<WarehouseIssueConsDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(warehouseIssueConsDAO, request, entity -> modelMapper.map(entity, WarehouseIssueConsDTO.Info.class));
    }

    private WarehouseIssueConsDTO.Info save(WarehouseIssueCons warehouseIssueCons) {
        final WarehouseIssueCons saved = warehouseIssueConsDAO.saveAndFlush(warehouseIssueCons);
        return modelMapper.map(saved, WarehouseIssueConsDTO.Info.class);
    }
}
