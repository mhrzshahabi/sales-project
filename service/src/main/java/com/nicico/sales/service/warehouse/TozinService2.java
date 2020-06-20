package com.nicico.sales.service.warehouse;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.iservice.warehous.ITozinService2;
import com.nicico.sales.model.entities.warehouse.TozinTable;
import com.nicico.sales.repository.warehouse.TozinDAO2;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TozinService2 implements ITozinService2 {
    private final TozinDAO2 tozinDAO;

    @Override
    public TozinTable get(Long id) {
        return tozinDAO.getOne(id);
    }

    @Override
    public TozinTable getByTozinId(String tozinIdString) {
        return null;
    }

    @Override
    public List<TozinTable> getAllById(List<Long> ids) {
        return null;
    }


    @Override
    public List<TozinTable> getAllByTozinCode(List<String> TozinCode) {
        return null;
    }

    @Override
    public List<TozinTable> list() {
        return tozinDAO.findAll();
    }

    @Override
    public TotalResponse<TozinTable> search(NICICOCriteria request) {
        return SearchUtil.search(tozinDAO, request, entity -> entity);
    }

    @Override
    public SearchDTO.SearchRs<TozinTable> search(SearchDTO.SearchRq request) {
        return null;
    }


}
