package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.CathodeListDTO;
import com.nicico.sales.iservice.ICathodeListService;
import com.nicico.sales.repository.CathodeListDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;

@RequiredArgsConstructor
@Service
public class CathodeListService implements ICathodeListService {

    private final CathodeListDAO cathodeListDAO;
    private final ModelMapper modelMapper;
    private final EntityManager entityManager;

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CATODLIST')")
    public TotalResponse<CathodeListDTO.Info> search(NICICOCriteria criteria) {
        entityManager.createNativeQuery("alter session set nls_language = 'AMERICAN'").executeUpdate();
        return SearchUtil.search(cathodeListDAO, criteria, entity -> modelMapper.map(entity, CathodeListDTO.Info.class));
    }

}
