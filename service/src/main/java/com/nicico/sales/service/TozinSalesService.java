package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.TozinSalesDTO;
import com.nicico.sales.iservice.ITozinSalesService;
import com.nicico.sales.repository.TozinSalesDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;

@RequiredArgsConstructor
@Service
public class TozinSalesService implements ITozinSalesService {

    private final TozinSalesDAO tozinSalesDAO;
    private final ModelMapper modelMapper;
    private final EntityManager entityManager;

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_TOZIN_SALES')")
    public TotalResponse<TozinSalesDTO.Info> search(NICICOCriteria criteria) {
        entityManager.createNativeQuery("alter session set time_zone = 'UTC'").executeUpdate();
        entityManager.createNativeQuery("alter session set nls_language = 'AMERICAN'").executeUpdate();
        return SearchUtil.search(tozinSalesDAO, criteria, tozinSales -> modelMapper.map(tozinSales, TozinSalesDTO.Info.class));
    }
}
