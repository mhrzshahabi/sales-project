package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.PercentPerYearDTO;
import com.nicico.sales.iservice.IPercentPerYearService;
import com.nicico.sales.model.entities.base.PercentPerYear;
import com.nicico.sales.repository.PercentPerYearDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class PercentPerYearService implements IPercentPerYearService {

    private final PercentPerYearDAO percentPerYearDAO;
    private final ModelMapper modelMapper;


    @Transactional(readOnly = true)
    @Override
    public List<PercentPerYearDTO.Info> list() {
        final List<PercentPerYear> slAll = percentPerYearDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<PercentPerYearDTO.Info>>() {
        }.getType());
    }


    @Transactional(readOnly = true)
    @Override
    public TotalResponse<PercentPerYearDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(percentPerYearDAO, criteria, percentPerYear  -> modelMapper.map(percentPerYear, PercentPerYearDTO.Info.class));
    }

}
