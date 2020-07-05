package com.nicico.sales.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.TozinDTO;
import com.nicico.sales.iservice.ITozinService;
import com.nicico.sales.model.entities.base.Tozin;
import com.nicico.sales.repository.MaterialItemDAO;
import com.nicico.sales.repository.TozinDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Slf4j
@RequiredArgsConstructor
@Service
public class TozinService implements ITozinService {

    private final TozinDAO tozinDAO;
    private final MaterialItemDAO materialItemDAO;
    private final ModelMapper modelMapper;
    private final ObjectMapper objectMapper;

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_TOZIN')")
    public TotalResponse<TozinDTO.Info> searchTozin(NICICOCriteria criteria) {
        return SearchUtil.search(tozinDAO, criteria, tozin -> modelMapper.map(tozin, TozinDTO.Info.class));
    }

    @Transactional(readOnly = true)
    public TozinDTO.Info get(Long id) {
        final Optional<Tozin> tzById = tozinDAO.findById(id);
        final Tozin tozin = tzById.orElseThrow(() -> new SalesException(SalesException.ErrorType.TozinNotFound));
        return modelMapper.map(tozin, TozinDTO.Info.class);
    }
}
