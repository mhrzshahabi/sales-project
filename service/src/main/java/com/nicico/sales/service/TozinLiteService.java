package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.iservice.ITozinLiteService;
import com.nicico.sales.model.entities.base.TozinLite;
import com.nicico.sales.repository.TozinLiteDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@RequiredArgsConstructor
@Service
public class TozinLiteService implements ITozinLiteService {

    private final TozinLiteDAO tozinDAO;

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_TOZIN')")
    public TotalResponse<TozinLite> search(NICICOCriteria criteria) {
        return SearchUtil.search(tozinDAO, criteria, tozin -> tozin);
    }
}
