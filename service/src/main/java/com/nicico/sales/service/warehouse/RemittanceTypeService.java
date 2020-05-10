package com.nicico.sales.service.warehouse;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.warehous.IRemittanceTypeService;
import com.nicico.sales.model.entities.warehouse.RemittanceType;
import com.nicico.sales.repository.warehouse.RemittanceTypeDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class RemittanceTypeService implements IRemittanceTypeService {
    private final RemittanceTypeDAO warehouseDAO;

    @Override
    public RemittanceType get(Long id) {
        final Optional<RemittanceType> one = warehouseDAO.findById(id);
        final RemittanceType RemittanceType = one.orElseThrow(() -> new NotFoundException());
        return RemittanceType;
    }

    @Override
    public List<RemittanceType> list() {
        return warehouseDAO.findAll();
    }

    @Override
    public TotalResponse<RemittanceType> search(NICICOCriteria request) {
        final TotalResponse<RemittanceType> response = SearchUtil.search(warehouseDAO, request, entity -> entity);
        return response;
    }

    @Override
    public SearchDTO.SearchRs<RemittanceType> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(warehouseDAO, request, entity -> entity);
    }
}
