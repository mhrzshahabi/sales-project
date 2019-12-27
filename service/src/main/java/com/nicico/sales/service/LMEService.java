package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.LMEDTO;
import com.nicico.sales.iservice.ILMEService;
import com.nicico.sales.model.entities.base.LME;
import com.nicico.sales.repository.LMEDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class LMEService implements ILMEService {

    private final LMEDAO lMEDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    public LMEDTO.Info get(Long id) {
        final Optional<LME> slById = lMEDAO.findById(id);
        final LME lME = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.LMENotFound));

        return modelMapper.map(lME, LMEDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    public List<LMEDTO.Info> list() {
        final List<LME> slAll = lMEDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<LMEDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    public LMEDTO.Info create(LMEDTO.Create request) {
        final LME lME = modelMapper.map(request, LME.class);

        return save(lME);
    }

    @Transactional
    @Override
    public LMEDTO.Info update(Long id, LMEDTO.Update request) {
        final Optional<LME> slById = lMEDAO.findById(id);
        final LME lME = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.LMENotFound));

        LME updating = new LME();
        modelMapper.map(lME, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    public void delete(Long id) {
        lMEDAO.deleteById(id);
    }

    @Transactional
    @Override
    public void delete(LMEDTO.Delete request) {
        final List<LME> lMEs = lMEDAO.findAllById(request.getIds());

        lMEDAO.deleteAll(lMEs);
    }

    @Transactional(readOnly = true)
    @Override
    public SearchDTO.SearchRs<LMEDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(lMEDAO, request, lME -> modelMapper.map(lME, LMEDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_BANK')")
    public TotalResponse<LMEDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(lMEDAO, criteria, lme -> modelMapper.map(lme, LMEDTO.Info.class));
    }

    private LMEDTO.Info save(LME lME) {
        final LME saved = lMEDAO.saveAndFlush(lME);
        return modelMapper.map(saved, LMEDTO.Info.class);
    }
}
