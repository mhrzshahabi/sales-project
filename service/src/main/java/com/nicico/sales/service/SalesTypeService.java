package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.SalesTypeDTO;
import com.nicico.sales.iservice.ISalesTypeService;
import com.nicico.sales.model.entities.base.SalesType;
import com.nicico.sales.repository.SalesTypeDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class SalesTypeService implements ISalesTypeService {

    private final SalesTypeDAO salesTypeDAO;
    private final ModelMapper modelMapper;


    @Transactional(readOnly = true)
    @Override
    public List<SalesTypeDTO.Info> list() {
        final List<SalesType> slAll = salesTypeDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<SalesTypeDTO.Info>>() {
        }.getType());
    }

    @Transactional(readOnly = true)
    @Override
    public TotalResponse<SalesTypeDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(salesTypeDAO, criteria, salesType  -> modelMapper.map(salesType, SalesTypeDTO.Info.class));
    }

}
