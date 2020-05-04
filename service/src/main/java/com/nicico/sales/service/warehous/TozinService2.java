package com.nicico.sales.service.warehous;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.iservice.warehous.ITozinService2;
import com.nicico.sales.model.entities.warehouse.Tozin2;
import com.nicico.sales.model.entities.warehouse.TozinId;
import com.nicico.sales.repository.warehouse.TozinDAO2;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class TozinService2 implements ITozinService2 {
    private final TozinDAO2 tozinDAO;
    private final ModelMapper modelMapper;

    @Override
    public Tozin2 get(TozinId id) {
        return tozinDAO.getOne(id);
    }

    @Override
    public Tozin2 getByTozinId(String tozinIdString) {
        return null;
    }

    @Override
    public List<Tozin2> getAllById(List<TozinId> ids) {
        return null;
    }


    @Override
    public List<Tozin2> getAllByTozinCode(List<String> TozinCode) {
        return null;
    }

    @Override
    public List<Tozin2> list() {
        return tozinDAO.findAll();
    }

    @Override
    public TotalResponse<Tozin2> search(NICICOCriteria request) {
        return SearchUtil.search(tozinDAO, request, entity -> entity);
    }

    @Override
    public SearchDTO.SearchRs<Tozin2> search(SearchDTO.SearchRq request) {
        return null;
    }

    @Override
    public List<Map> getTargets() {
        return tozinDAO.listTargets();
    }
}
